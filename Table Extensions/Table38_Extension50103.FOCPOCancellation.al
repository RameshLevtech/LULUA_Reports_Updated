tableextension 50103 "Foc Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50000; "Cancel PO"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cancel PO';
        }
        field(50001; "Remarks For Cancellation"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks For Cancellation';
        }
        field(50002; "Cancelled UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Cancelled UserID';
        }
        field(50003; "Cancelled DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Cancelled DateTime';
        }
        field(50004; "Remarks For Short Close"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks For Short Close';
        }
        field(50005; "Short Close"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Short Close';
        }
        field(50006; "Short Close Cancelled User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Short Close Cancelled User ID';
        }
        field(50007; "Short Close Cancelled DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Short Close Cancelled DateTime';
        }

        field(50100; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Vendor No.1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            begin
                Clear(Recvendor);
                if Recvendor.Get("Vendor No.1") then
                    "Vendor Name 1" := Recvendor.Name
                else
                    "Vendor Name 1" := '';
            end;
        }
        field(50102; "Vendor No.2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            begin
                Clear(Recvendor);
                if Recvendor.Get("Vendor No.2") then
                    "Vendor Name 2" := Recvendor.Name
                else
                    "Vendor Name 2" := '';
            end;
        }
        field(50103; "Vendor No.3"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            begin
                Clear(Recvendor);
                if Recvendor.Get("Vendor No.3") then
                    "Vendor Name 3" := Recvendor.Name
                else
                    "Vendor Name 3" := '';
            end;
        }

        field(50104; "Vendor Name 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Vendor Name 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Vendor Name 3"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        /*field(50107; "Attachment1"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Attachment2"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Attachment3"; Integer)
        {
            DataClassification = ToBeClassified;
        }*/
        modify("Incoming Document Entry No.")
        {
            trigger OnAfterValidate()
            var
                RecIncDoc: Record "Incoming Document";
            begin
                If "Incoming Document Entry No." <> 0 then begin
                    Clear(RecIncDoc);
                    if RecIncDoc.GET("Incoming Document Entry No.") then begin
                        Validate("Purchase Order No.", RecIncDoc."Order No.");
                        Validate("Vendor Invoice No.", RecIncDoc."Vendor Invoice No.");
                        Validate("Document Date", RecIncDoc."Document Date");
                        Validate("Due Date", RecIncDoc."Due Date");
                        Validate("Currency Code", RecIncDoc."Currency Code");
                    end;
                end else begin
                    Validate("Purchase Order No.", '');
                    Validate("Document Date", 0D);
                    Validate("Due Date", 0D);
                    Validate("Currency Code", '');
                    Validate("Vendor Invoice No.", '');
                end;
            end;
        }

    }
    var
        Recvendor: Record Vendor;
}