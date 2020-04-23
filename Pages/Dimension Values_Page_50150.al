page 50150 "Dimension Value"
{
    PageType = Card;
    //ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = "Dimension Value";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Dimension Code"; "Dimension Code")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Logo; Logo)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension No."; "Global Dimension No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}