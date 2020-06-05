tableextension 50010 "Customer Ext" extends Customer
{
    fields
    {
        field(50000; "Customer ID"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
        }
    }

    var
        myInt: Integer;
}