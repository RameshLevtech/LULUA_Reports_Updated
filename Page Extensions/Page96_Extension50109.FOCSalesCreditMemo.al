pageextension 50109 "Ext Sales Credit Memo" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Unit Price")
        {
            field("FOC Sales"; "FOC Sales")
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