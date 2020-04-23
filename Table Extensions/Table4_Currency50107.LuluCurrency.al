tableextension 50107 "Currency Ext" extends Currency
{
    fields
    {
        field(50000; "Subsidary Currency"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}