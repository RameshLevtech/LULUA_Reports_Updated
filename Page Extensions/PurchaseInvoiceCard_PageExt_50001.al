pageextension 50001 PurchInvcard extends "Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Due Date")
        {
            field("Purchase Order No."; "Purchase Order No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(SelectIncomingDoc)
        {
            Visible = false;
        }
        addafter(IncomingDocCard)
        {
            action(SelectIncomingDocs)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Select';
                Image = SelectLineToApply;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';
                AccessByPermission = TableData "Incoming Document" = R;

                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                begin
                    VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocuments("Incoming Document Entry No.", "Buy-from Vendor No.", RECORDID));
                end;
            }
        }

        modify("Re&lease")
        {
            trigger OnBeforeAction()
            begin
                validateAmounts;
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                validateAmounts
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                validateAmounts;
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                validateAmounts;
            end;

        }
    }

    local procedure validateAmounts()
    var
        RecIncomingDoc: Record "Incoming Document";
        RecPline: Record "Purchase Line";
        RecPnP: Record "Purchases & Payables Setup";
        DifferenceAllowed: Decimal;
        Difference: Decimal;
    begin
        Clear(RecIncomingDoc);
        if (Rec."Document Type" = Rec."Document Type"::Invoice) AND (Rec."Incoming Document Entry No." <> 0) then begin
            if RecIncomingDoc.GET(Rec."Incoming Document Entry No.") then begin
                Clear(RecPline);
                RecPline.SetRange("Document Type", RecPline."Document Type"::Invoice);
                RecPline.SetRange("Document No.", Rec."No.");
                RecPline.CalcSums("Amount Including VAT", "VAT Base Amount", "VAT %");
                Rec.CalcFields("Amount Including VAT");

                RecPnP.GET;
                Clear(DifferenceAllowed);
                Clear(Difference);
                if Rec."Amount Including VAT" <> RecIncomingDoc."Amount Incl. VAT" then begin
                    if (RecPnP."Tolerance %" <> 0) AND (RecIncomingDoc."Amount Incl. VAT" <> 0) then begin
                        Difference := Rec."Amount Including VAT" - RecIncomingDoc."Amount Incl. VAT";
                        if Difference < 0 then
                            Difference := Difference * -1;
                        DifferenceAllowed := RecIncomingDoc."Amount Incl. VAT" * RecPnP."Tolerance %" / 100;
                        if (Difference > DifferenceAllowed) then
                            Error('Amount Including VAT should be equal to ' + FORMAT(RecIncomingDoc."Amount Incl. VAT") + 'mentioned in attachhed Incoming document ' + Format(Rec."Incoming Document Entry No."))
                    end else
                        Error('Amount Including VAT should be equal to ' + FORMAT(RecIncomingDoc."Amount Incl. VAT") + 'mentioned in attachhed Incoming document ' + Format(Rec."Incoming Document Entry No."));
                end
                else
                    if RecIncomingDoc."VAT Amount" <> (RecPline."Amount Including VAT" - RecPline."VAT Base Amount") then begin

                        if (RecPnP."Tolerance %" <> 0) AND (RecIncomingDoc."VAT Amount" <> 0) then begin
                            Difference := (RecPline."Amount Including VAT" - RecPline."VAT Base Amount") - RecIncomingDoc."VAT Amount";
                            if Difference < 0 then
                                Difference := Difference * -1;
                            DifferenceAllowed := RecIncomingDoc."VAT Amount" * RecPnP."Tolerance %" / 100;
                            if (Difference > DifferenceAllowed) then
                                Error('VAT Amount should be equal to' + Format(RecIncomingDoc."VAT Amount") + 'mentioned in attachhed Incoming document ' + Format(Rec."Incoming Document Entry No."))
                        end else
                            Error('VAT Amount should be equal to' + Format(RecIncomingDoc."VAT Amount") + 'mentioned in attachhed Incoming document ' + Format(Rec."Incoming Document Entry No."));
                    end
                    else
                        if RecIncomingDoc."Amount Excl. VAT" <> RecPline."VAT Base Amount" then begin
                            if (RecPnP."Tolerance %" <> 0) AND (RecIncomingDoc."Amount Excl. VAT" <> 0) then begin
                                Difference := RecPline."VAT Base Amount" - RecIncomingDoc."Amount Excl. VAT";
                                if Difference < 0 then
                                    Difference := Difference * -1;
                                DifferenceAllowed := RecIncomingDoc."Amount Excl. VAT" * RecPnP."Tolerance %" / 100;
                                if (Difference > DifferenceAllowed) then
                                    Error('Amount Excl. VAT should be equal to' + Format(RecIncomingDoc."Amount Excl. VAT") + 'mentioned in attachhed Incoming document ' + Format(Rec."Incoming Document Entry No."));
                            end else
                                Error('Amount Excl. VAT should be equal to' + Format(RecIncomingDoc."Amount Excl. VAT") + 'mentioned in attachhed Incoming document ' + Format(Rec."Incoming Document Entry No."));
                        end;
            end;
        end;
    end;

    var
        myInt: Integer;
}