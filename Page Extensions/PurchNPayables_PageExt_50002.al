pageextension 50002 PurchNPayables extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Tolerance %"; "Tolerance %")
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