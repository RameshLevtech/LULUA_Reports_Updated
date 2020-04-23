tableextension 50002 PurchNPayables extends "Purchases & Payables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Tolerance %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}