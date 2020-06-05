tableextension 50001 "Customer LedgerEntry Ext" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50001; "Cash/Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Cash/Cheque Number';
        }
        field(50002; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Cheque Date';
        }
        field(50003; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Bank Name';
        }
    }

    var
        myInt: Integer;
}