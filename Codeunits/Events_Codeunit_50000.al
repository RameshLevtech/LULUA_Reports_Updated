codeunit 50000 Events
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLine', '', false, false)]
    procedure InsertPurchOrderNoToInvoice(VAR PurchRcptLine: Record "Purch. Rcpt. Line"; VAR PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line")
    VAR
        Pheader: Record "Purchase Header";
    begin
        Clear(Pheader);
        if Pheader.GET(Pheader."Document Type"::Invoice, PurchLine."Document No.") then begin
            if Pheader."Purchase Order No." <> PurchRcptLine."Order No." then
                Error('Receipt lines should be against the Same Purchase order number ' + Pheader."Purchase Order No." + ' as Incoming document attached to the Invoice');
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    procedure ToCheckTaxDetailsBeforePosting(VAR PurchaseHeader: Record "Purchase Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean)
    var
        RecIncomingDoc: Record "Incoming Document";
        RecPline: Record "Purchase Line";
        RecPnP: Record "Purchases & Payables Setup";
        DifferenceAllowed: Decimal;
        Difference: Decimal;
    begin
        Clear(RecIncomingDoc);
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) AND (PurchaseHeader."Incoming Document Entry No." <> 0) then begin
            if RecIncomingDoc.GET(PurchaseHeader."Incoming Document Entry No.") then begin
                Clear(RecPline);
                RecPline.SetRange("Document Type", RecPline."Document Type"::Invoice);
                RecPline.SetRange("Document No.", PurchaseHeader."No.");
                RecPline.CalcSums("Amount Including VAT", "VAT Base Amount", "VAT %");
                PurchaseHeader.CalcFields("Amount Including VAT");

                RecPnP.GET;
                Clear(DifferenceAllowed);
                Clear(Difference);
                if PurchaseHeader."Amount Including VAT" <> RecIncomingDoc."Amount Incl. VAT" then begin
                    if (RecPnP."Tolerance %" <> 0) AND (RecIncomingDoc."Amount Incl. VAT" <> 0) then begin
                        Difference := PurchaseHeader."Amount Including VAT" - RecIncomingDoc."Amount Incl. VAT";
                        if Difference < 0 then
                            Difference := Difference * -1;
                        DifferenceAllowed := RecIncomingDoc."Amount Incl. VAT" * RecPnP."Tolerance %" / 100;
                        if (Difference > DifferenceAllowed) then
                            Error('Amount Including VAT should be equal to ' + FORMAT(RecIncomingDoc."Amount Incl. VAT") + 'mentioned in attachhed Incoming document ' + Format(PurchaseHeader."Incoming Document Entry No."))
                    end else
                        Error('Amount Including VAT should be equal to ' + FORMAT(RecIncomingDoc."Amount Incl. VAT") + 'mentioned in attachhed Incoming document ' + Format(PurchaseHeader."Incoming Document Entry No."))
                end
                else
                    if RecIncomingDoc."VAT Amount" <> (RecPline."Amount Including VAT" - RecPline."VAT Base Amount") then begin

                        if (RecPnP."Tolerance %" <> 0) AND (RecIncomingDoc."VAT Amount" <> 0) then begin
                            Difference := (RecPline."Amount Including VAT" - RecPline."VAT Base Amount") - RecIncomingDoc."VAT Amount";
                            if Difference < 0 then
                                Difference := Difference * -1;
                            DifferenceAllowed := RecIncomingDoc."VAT Amount" * RecPnP."Tolerance %" / 100;
                            if (Difference > DifferenceAllowed) then
                                Error('VAT Amount should be equal to' + Format(RecIncomingDoc."VAT Amount") + 'mentioned in attachhed Incoming document ' + Format(PurchaseHeader."Incoming Document Entry No."))
                        end else
                            Error('VAT Amount should be equal to' + Format(RecIncomingDoc."VAT Amount") + 'mentioned in attachhed Incoming document ' + Format(PurchaseHeader."Incoming Document Entry No."))
                    end
                    else
                        if RecIncomingDoc."Amount Excl. VAT" <> RecPline."VAT Base Amount" then begin

                            if (RecPnP."Tolerance %" <> 0) AND (RecIncomingDoc."Amount Excl. VAT" <> 0) then begin
                                Difference := RecPline."VAT Base Amount" - RecIncomingDoc."Amount Excl. VAT";
                                if Difference < 0 then
                                    Difference := Difference * -1;
                                DifferenceAllowed := RecIncomingDoc."Amount Excl. VAT" * RecPnP."Tolerance %" / 100;
                                if (Difference > DifferenceAllowed) then
                                    Error('Amount Excl. VAT should be equal to' + Format(RecIncomingDoc."Amount Excl. VAT") + 'mentioned in attachhed Incoming document ' + Format(PurchaseHeader."Incoming Document Entry No."))
                            end else
                                Error('Amount Excl. VAT should be equal to' + Format(RecIncomingDoc."Amount Excl. VAT") + 'mentioned in attachhed Incoming document ' + Format(PurchaseHeader."Incoming Document Entry No."))
                        end;
            end;
        end;
    end;

    var
        myInt: Integer;
}