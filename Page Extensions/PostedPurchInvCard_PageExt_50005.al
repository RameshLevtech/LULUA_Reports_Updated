pageextension 50005 PostedPurchInvCard extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Due Date")
        {
            field("Purchase Order No."; "Purchase Order No.")
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