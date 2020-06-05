pageextension 50113 "Currency Ext" extends Currencies
{
    layout
    {
        addafter(Description)
        {
            field("Subsidary Currency"; "Subsidary Currency")
            {
                ApplicationArea = All;
            }
            field("Currency Fractional Value"; "Currency Fractional Value")
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