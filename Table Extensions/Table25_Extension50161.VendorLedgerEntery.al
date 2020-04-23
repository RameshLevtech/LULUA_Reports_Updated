tableextension 50160 "Ext Vendor Ledger Entry" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Pay to the order of"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Cash/Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Cash/Cheque Number';
        }
        field(50003; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Cheque Date';
        }
        field(50004; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Bank Name';
        }
    }

    var
        myInt: Integer;
}