pageextension 50101 "FOC SO Cancellation" extends "sales Order"
{
    layout
    {
        addafter(Status)
        {
            field("Remarks For Cancellation"; "Remarks For Cancellation")
            {
                ApplicationArea = All;
                //Visible = VisableG;
            }
            field("Cancel SO"; "Cancel SO")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible = VisableG;
            }
            field("Cancelled UserID"; "Cancelled UserID")
            {
                ApplicationArea = All;
                Editable = false;
                //Visible = VisableG;
            }
            field("Cancelled DateTime"; "Cancelled DateTime")
            {
                ApplicationArea = All;
                Editable = false;
                //Visible = VisableG;
            }
            field("Remarks For Short Close"; "Remarks For Short Close")
            {
                ApplicationArea = All;
                //Visible = VisableG;
            }
            field("SO Short Close"; "Short Close")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible = VisableG;

            }
            field("Short Close Cancelled User ID"; "Short Close Cancelled User ID")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible = VisableG;
            }
            field("Short Close Cancelled DateTime"; "Short Close Cancelled DateTime")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible = VisableG;
            }
        }
    }

    actions
    {
        addafter("&Order Confirmation")
        {
            group(ShortcloseCancelation)
            {
                Caption = 'Shortclose/Cancelation';
                action("Cancel SalesOrder")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel SalesOrder';
                    //Visible = VisableG;
                }
                action("Order Short Close")
                {
                    ApplicationArea = All;
                    Caption = 'Order Short Close';
                    //Visible = VisableG;
                }
            }
        }

    }

    // trigger OnOpenPage()
    // begin
    //     UserSetUpRecG.Get(UserId);
    //     VisableG := UserSetUpRecG."FOC User";
    // end;

    // var
    //     [InDataSet]
    //     VisableG: Boolean;
    //     UserSetUpRecG: Record "User Setup";
}