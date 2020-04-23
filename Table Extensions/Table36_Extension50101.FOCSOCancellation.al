tableextension 50101 "FOC SO Cancellation" extends "Sales Header"
{
    fields
    {
        field(50000; "Cancel SO"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cancel SO';
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
        field(50008; "Ship-to Contact Number"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ship-to Contact Number';
        }
        field(5009; "Bill-to Contact Number"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill-to Contact Number';
        }
    }
}