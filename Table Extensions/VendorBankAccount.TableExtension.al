tableextension 50006 "Vendor Bank Account Ext" extends "Vendor Bank Account"
{
    fields
    {
        field(50000; "Sort Cord"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sort Cord';
        }
    }

    var
        myInt: Integer;
}