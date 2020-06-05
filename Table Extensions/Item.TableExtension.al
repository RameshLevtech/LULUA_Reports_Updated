tableextension 50008 "Item ext" extends Item
{
    fields
    {
        field(50000; "Check Parent Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Check Parent Item';
        }
    }

    var
        myInt: Integer;
}