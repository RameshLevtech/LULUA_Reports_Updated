page 50010 "Signatory"
{
    Caption = 'Signatory List';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Signatory;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}