table 50000 "Signatory"
{
    DataClassification = ToBeClassified;
    Caption = 'Signatory';
    LookupPageId = Signatory;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;

        }
        field(2; "Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
    }

    keys
    {
        key(PK; "Entry No.", Name)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
}