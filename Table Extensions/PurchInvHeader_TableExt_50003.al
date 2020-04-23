tableextension 50003 PurchInvHeader extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}