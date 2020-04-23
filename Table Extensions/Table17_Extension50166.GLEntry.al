tableextension 50166 "Ext G/L Entry" extends "G/L Entry"
{
    fields
    {
        field(50002; "Cash/Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cash/Cheque Number';
        }
        field(50003; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Date';
        }
        field(50004; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Name';
        }
    }

    var
        myInt: Integer;
}