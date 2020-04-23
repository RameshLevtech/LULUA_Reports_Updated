pageextension 50163 "Ext Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(Payments)
        {
            field("Pay to the order of"; "Pay to the order of")
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