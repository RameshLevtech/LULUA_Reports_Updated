tableextension 50011 "Employee Ext" extends Employee
{
    fields
    {
        field(50000; "Employee ID"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
        }
    }

    var
        myInt: Integer;
}