pageextension 50108 "Ext Sales Return Order" extends "Sales Return Order Subform"
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