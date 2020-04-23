pageextension 50166 "Ext_Dimension List" extends Dimensions
{
    layout
    {
        addbefore(Blocked)
        {
            field("Employee Dimension"; "Employee Dimension")
            {
                ApplicationArea = All;

            }
        }
    }
}