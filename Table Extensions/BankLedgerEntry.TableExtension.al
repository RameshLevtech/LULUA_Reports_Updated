tableextension 50004 "Bank Ledger Entry Ext" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "Bank Charges"; Option)
        {
            Caption = 'Bank Charges';
            OptionCaption = ',Ours,Shared,Beneficiary';
            OptionMembers = ,Ours,"Shared",Beneficiary;
        }
    }

    var
        myInt: Integer;
}