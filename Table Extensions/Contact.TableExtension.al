tableextension 50007 "Contact Ext" extends Contact
{
    fields
    {
        field(50000; "ID"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
        }
    }

    var
        myInt: Integer;
}