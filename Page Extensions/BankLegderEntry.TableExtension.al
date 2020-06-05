pageextension 50010 "Bank Ledger Entry Ext" extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field("Bank Charges"; "Bank Charges")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}