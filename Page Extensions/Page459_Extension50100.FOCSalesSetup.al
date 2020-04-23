pageextension 50100 "FOC Sales Additional Field" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Skip Manual Reservation")
        {
            field("FOC Gen.Prod.Posting Group"; "FOC Gen.Prod.Posting Group")
            {
                ApplicationArea = All;

            }
            field("Limited Edition Attribute ID"; "Limited Edition Attribute ID")
            {
                ApplicationArea = All;
            }
        }
    }
}