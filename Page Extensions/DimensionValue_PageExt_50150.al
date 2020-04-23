pageextension 50150 DimensionValueList extends "Dimension Values"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field(Logo; Logo)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        //Add changes to page actions here
        addafter("Indent Dimension Values")
        {
            action(Card)
            {
                ApplicationArea = All;
                Image = EditLines;
                ToolTip = 'View or change detailed information about the record on the document';
                ShortcutKey = 'Shift+F7';
                trigger OnAction()
                VAR
                    RecDimensionValue: Record "Dimension Value";
                    DimensionValueCard: Page "Dimension Value";
                begin
                    Clear(RecDimensionValue);
                    RecDimensionValue.SetRange("Dimension Code", Rec."Dimension Code");
                    RecDimensionValue.SetRange(Code, Rec.Code);
                    if RecDimensionValue.FindSet() then begin
                        DimensionValueCard.SetTableView(RecDimensionValue);
                        DimensionValueCard.RunModal();
                    end;

                end;
            }
        }
    }

    var
        myInt: Integer;
}