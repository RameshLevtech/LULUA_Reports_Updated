tableextension 50152 SalesInvLine extends "Sales Invoice Line"
{
    fields
    {
        // Add changes to table fields here
        /*field(50150; "FOC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }*/

        field(50151; "Parent Item"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                Sline: Record "Sales Invoice Line";
            begin
                Clear(Sline);
                Sline.SetRange("Document No.", "Document No.");
                Sline.SetRange(Type, Type::Item);
                Sline.SetRange("No.", "Parent Item");
                if not Sline.FindFirst() then
                    Error('Selected Item Does not exists in the current order.');

                if "Parent Item" = "No." then
                    Error('Item ' + "Parent Item" + ' cannot be selected as Parent Item.');

            end;
        }
	//Ramesh
field(50000; "FOC Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'FOC Sales';
            Editable = false;
        }
//Ramesh
    }

    var
        myInt: Integer;
}