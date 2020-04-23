tableextension 50105 "FOC User SetUp" extends "User Setup"
{
    fields
    {
        field(50000; "Can Cancel & Shortclose orders"; Boolean)
        {
            Caption = 'Can Cancel and Shortclose orders';
            DataClassification = ToBeClassified;
        }
    }
}