pageextension 50164 "Ext Posted Sales Memo Subform" extends "Posted Sales Cr. Memo Subform"
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