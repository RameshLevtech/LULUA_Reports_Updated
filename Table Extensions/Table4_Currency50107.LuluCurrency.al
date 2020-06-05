tableextension 50107 "Currency Ext" extends Currency
{
    fields
    {
        field(50000; "Subsidary Currency"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Currency Fractional Value"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}