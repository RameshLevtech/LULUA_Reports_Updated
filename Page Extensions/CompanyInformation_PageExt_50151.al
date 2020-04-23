pageextension 50151 CompanyInformation extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Long Name"; "Long Name")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("Arabic Name"; "Arabic Name")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        //Add changes to page actions here
    }

    var
        myInt: Integer;
}