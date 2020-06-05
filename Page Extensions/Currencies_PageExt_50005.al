pageextension 50006 Currencycard extends "Currency Card"
{
    layout
    {
        // Add changes to page layout here
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