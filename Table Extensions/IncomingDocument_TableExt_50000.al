tableextension 50000 IncomingDocument extends "Incoming Document"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Bank Account Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Vendor No."));
            trigger OnValidate()
            var
                RecVendorBank: Record "Vendor Bank Account";
            begin
                Clear(RecVendorBank);
                IF RecVendorBank.Get("Vendor No.", "Bank Account Code") then begin
                    Validate("Vendor IBAN", RecVendorBank.IBAN);
                    Validate("Vendor Bank Account No.", RecVendorBank."Bank Account No.");
                    Validate("Vendor Bank Branch No.", RecVendorBank."Bank Branch No.");
                end else begin
                    Validate("Vendor IBAN", '');
                    Validate("Vendor Bank Account No.", '');
                    Validate("Vendor Bank Branch No.", '');
                end;
            end;
        }
        modify("Vendor No.")
        {
            trigger OnAfterValidate()
            var
                RecVendor: Record Vendor;
            begin
                if xRec."Vendor No." <> Rec."Vendor No." then begin
                    Validate("Vendor IBAN", '');
                    Validate("Vendor Bank Account No.", '');
                    Validate("Vendor Bank Branch No.", '');
                    Validate("Bank Account Code", '');
                    Validate("Document Date", 0D);
                    Validate("Due Date", 0D);
                    Validate("Order No.", '');
                    Validate("Currency Code", '');
                    Validate("Amount Incl. VAT", 0);
                    Validate("VAT Amount", 0);
                    Validate("Amount Excl. VAT", 0);
                end;
                Clear(RecVendor);
                IF RecVendor.GET("Vendor No.") then begin
                    Validate("Vendor Name", RecVendor.Name);
                    Validate("Vendor VAT Registration No.", RecVendor."VAT Registration No.");
                    Validate("Vendor Phone No.", RecVendor."Phone No.");
                end else begin
                    Validate("Vendor Name", '');
                    Validate("Vendor VAT Registration No.", '');
                    Validate("Vendor Phone No.", '');
                end;
            end;
        }
        modify("Order No.")
        {
            //TableRelation = "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("Vendor No."));
            trigger OnAfterValidate()
            var
                RecPurchHeader: Record "Purchase Header";
                RecPline: Record "Purchase Line";
            begin
                Clear(RecPline);
                RecPline.SetRange("Document Type", RecPline."Document Type"::Order);
                RecPline.SetRange("Document No.", "Order No.");
                RecPline.CalcSums("Amount Including VAT", "VAT Base Amount", "VAT %");
                Validate("Amount Incl. VAT", Round(RecPline."Amount Including VAT", 0.01, '='));
                Validate("VAT Amount", Round(RecPline."Amount Including VAT" - RecPline."VAT Base Amount", 0.01, '='));
                Validate("Amount Excl. VAT", Round(RecPline."VAT Base Amount", 0.01, '='));

                Clear(RecPurchHeader);
                IF RecPurchHeader.GET(RecPurchHeader."Document Type"::Order, "Order No.") then begin
                    Validate("Document Date", RecPurchHeader."Document Date");
                    Validate("Due Date", RecPurchHeader."Due Date");
                    Validate("Currency Code", RecPurchHeader."Currency Code");
                end else begin
                    Validate("Document Date", 0D);
                    Validate("Due Date", 0D);
                    Validate("Currency Code", '');
                end;
            end;
        }
    }
    procedure SelectIncomingDocuments(EntryNo: Integer; VendorNo: Code[20]; RelatedRecordID: RecordID): Integer
    var
        IncomingDocumentsSetup: Record "Incoming Documents Setup";
        IncomingDocument: Record "Incoming Document";
        IncomingDocuments: Page "Incoming Documents";
    begin
        IF EntryNo <> 0 THEN BEGIN
            //IncomingDocument.GET(EntryNo);
            Clear(IncomingDocument);//LT
            IncomingDocument.SetRange("Entry No.", "Entry No.");//LT
            IncomingDocument.SetRange("Vendor No.", VendorNo);
            if IncomingDocument.FindSet() then
                IncomingDocuments.SETRECORD(IncomingDocument);
        END;
        IF IncomingDocumentsSetup.GET THEN
            IF IncomingDocumentsSetup."Require Approval To Create" THEN
                IncomingDocument.SETRANGE(Released, TRUE);
        IncomingDocument.SETRANGE(Posted, FALSE);
        IncomingDocument.SetRange("Vendor No.", VendorNo);//LT
        IncomingDocuments.SETTABLEVIEW(IncomingDocument);
        IncomingDocuments.LOOKUPMODE := TRUE;
        IF IncomingDocuments.RUNMODAL = ACTION::LookupOK THEN BEGIN
            IncomingDocuments.GETRECORD(IncomingDocument);
            IncomingDocument.VALIDATE("Related Record ID", RelatedRecordID);
            IncomingDocument.MODIFY;
            EXIT(IncomingDocument."Entry No.");
        END;
        EXIT(EntryNo);
    end;

    var
        myInt: Integer;
}