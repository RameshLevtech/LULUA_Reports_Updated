tableextension 50153 CompanyInfo extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(50150; "Long Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "Arabic Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}