pageextension 50011 "Vendor BankAcount Ext" extends "Vendor Bank Account Card"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field("Sort Cord"; "Sort Cord")
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