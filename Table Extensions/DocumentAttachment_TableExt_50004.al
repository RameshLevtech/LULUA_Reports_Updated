tableextension 50005 DocAttachment extends "Document Attachment"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}