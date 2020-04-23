tableextension 50151 SalesLineExt extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here
        field(50150; "FOC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "Parent Item"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                Sline: Record "Sales Line";
            begin
                if "Parent Item" = '' then
                    exit;
                Clear(Sline);
                Sline.SetRange("Document Type", "Document Type");
                Sline.SetRange("Document No.", "Document No.");
                Sline.SetRange(Type, Type::Item);
                Sline.SetRange("No.", "Parent Item");
                if not Sline.FindFirst() then
                    Error('Selected Item Does not exists in the current order.');

                if "Parent Item" = "No." then
                    Error('Item ' + "Parent Item" + ' cannot be selected as Parent Item.');

                Clear(Sline);
                Sline.SetRange("Document Type", "Document Type");
                Sline.SetRange("Document No.", "Document No.");
                Sline.SetRange(Type, Type::Item);
                Sline.SetRange("No.", "Parent Item");
                if Sline.FindFirst() then begin
                    if Sline."Parent Item" = Rec."No." then
                        Error('Selected Items Parent cant be used as a Parent of the same Item.');
                end;
            end;
        }
//Ramesh
 field(50000; "FOC Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'FOC Sales';
        }
//Ramesh
    }


    keys
    {
        key(PK3; "Parent Item")
        {
        }
    }

    fieldgroups
    {
        addlast(Brick; "No.")
        {

        }
    }



    var
        myInt: Integer;



}
