tableextension 50162 "Vendor Ext" extends Vendor
{
    fields
    {
        field(50000; "Pay to the order of"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}