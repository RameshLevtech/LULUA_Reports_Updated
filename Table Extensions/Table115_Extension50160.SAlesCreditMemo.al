tableextension 50161 "Ext Sales Credit Memo" extends "Sales Cr.Memo Line"
{
    fields
    {
        //Ramesh
        field(50000; "FOC Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'FOC Sales';
        }
        //Ramesh
    }

    var
        myInt: Integer;
}