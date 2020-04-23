pageextension 50003 GetReceiptLines extends "Get Receipt Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Order No."; "Order No.")
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