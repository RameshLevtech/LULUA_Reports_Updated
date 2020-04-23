pageextension 50107 "Foc User Setup" extends "User Setup"
{
    layout
    {
        addafter(PhoneNo)
        {
            field("FOC User"; "Can Cancel & Shortclose orders")
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