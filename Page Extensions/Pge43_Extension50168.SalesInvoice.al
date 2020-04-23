pageextension 50168 "Sales Invoice Ext" extends "Sales Invoice"
{
    layout
    {
        addafter("Ship-to Contact")
        {
            field("Ship-to Contact Number"; "Ship-to Contact Number")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Contact No.")
        {
            field("Bill-to Contact Number"; "Bill-to Contact Number")
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