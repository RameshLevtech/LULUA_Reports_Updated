pageextension 50012 "Contact Card Ext" extends "Contact Card"
{
    layout
    {
        addafter("Company No.")
        {
            field(ID; ID)
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