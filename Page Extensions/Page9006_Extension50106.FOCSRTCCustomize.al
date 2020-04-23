pageextension 50106 "FOC RTC Customize" extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("Sales Orders")
        {
            group("SO Cancellation")
            {
                Caption = 'SO Cancellation';
                action("Cancelled Sales Order")
                {
                    ApplicationArea = All;
                    Caption = 'Cancelled Sales Order';
                    RunObject = page "cancelled Sales Order List";
                    //RunPageView = WHERE("Cancel SO" = CONST(true), "Status" = FILTER(Released));
                }
                action("Short Closed Sales Order")
                {
                    ApplicationArea = All;
                    Caption = 'Short Closed Sales Order';
                    RunObject = page "ShortClosed Sales Order List";
                    // RunPageView = WHERE("Short Close" = CONST(true), "Status" = FILTER(Released));
                }
            }
        }
        addafter("Purchase Orders")
        {
            group("PO Cancellation")
            {
                Caption = 'PO Cancellation';
                action("Cancelled Purchase Order")
                {
                    ApplicationArea = All;
                    Caption = 'Cancelled Purchase Order';
                    RunObject = page "Cancelled Purchase order List";
                    //RunPageView = WHERE("Cancel PO" = CONST(true), "Status" = FILTER(Released));
                }
                action("Short Closed Purchase Order")
                {
                    ApplicationArea = All;
                    Caption = 'Short Closed Purchase Order';
                    RunObject = page "ShortClosed Purchase Order";
                    //RunPageView = WHERE("Short Close" = CONST(true), "Status" = FILTER(Released));
                }
            }
        }
    }




    var
        myInt: Integer;
}