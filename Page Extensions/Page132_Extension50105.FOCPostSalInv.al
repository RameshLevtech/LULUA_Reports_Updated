pageextension 50105 "Foc Item Post Sal Inv" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("FOC Sales"; "FOC Sales")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Cross-Reference No"; "Cross-Reference No.")
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