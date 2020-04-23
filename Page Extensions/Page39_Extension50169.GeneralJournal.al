pageextension 50169 "Ext General Journal" extends "General Journal"
{
    layout
    {
        addafter("Bal. Account Type")
        {
            field("Cash/Cheque Number"; "Cash/Cheque Number")
            {
                ApplicationArea = All;
            }
            field("Cheque Date"; "Cheque Date")
            {
                ApplicationArea = All;
            }
            field("Bank Name"; "Bank Name")
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