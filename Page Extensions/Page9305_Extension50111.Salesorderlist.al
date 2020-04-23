pageextension 50111 "Ext Sales Order List" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetAscending("No.", Ascending);
    end;

    var
        myInt: Integer;
}