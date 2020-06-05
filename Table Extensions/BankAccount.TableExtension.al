tableextension 50009 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        field(50000; "Sort Code"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sort Code';
        }
    }

    var
        myInt: Integer;
}