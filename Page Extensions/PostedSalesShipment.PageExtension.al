pageextension 50009 "Posted SalesShipment" extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Print")
        {
            action("Delivery Note")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    SalesHipHeaderL: Record "Sales Shipment Header";
                begin
                    SalesHipHeaderL.SetRange("No.", "No.");
                    SalesHipHeaderL.SetRange("Sell-to Customer No.");
                    Report.Run(Report::"Delivery Note", true, true, SalesHipHeaderL);
                end;
            }
        }
    }

    var
        myInt: Integer;
}