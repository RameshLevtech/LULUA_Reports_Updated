pageextension 50014 "Bank AccountCard Ext" extends "Bank Account Card"
{
    layout
    {
        addafter("Bank Branch No.2")
        {
            field("Sort Code"; "Sort Code")
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