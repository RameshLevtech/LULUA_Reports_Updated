pageextension 50103 "Foc SalesInvoice" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Unit Price")
        {
            field("FOC Sales"; "FOC Sales")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Parent Item"; "Parent Item")
            {
                ApplicationArea = All;
            }
        }
    }
}