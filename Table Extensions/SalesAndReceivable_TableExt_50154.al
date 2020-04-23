tableextension 50154 SalesNReceivableSetup extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50150; "Limited Edition Attribute ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Attribute".ID where(Blocked = const(false));
        }
        //Ramesh
        field(50000; "FOC Gen.Prod.Posting Group"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group".Code;
            Caption = 'FOC General Product Posting Group';
        }
        //Ramesh
    }

    var
        myInt: Integer;
}