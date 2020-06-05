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
            Caption = 'Parent Item Number';
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

            trigger OnLookup()
            var
                Sline: Record "Sales Line";
                ItemNumsL: Code[250];
                ItemL: Record Item;
                ItemList: Page "Item List";
                CopyItemL: Code[250];
            begin
                if "Additional Parent Item" then
                    Error('No Need To Select The Parent Item');
                Sline.SetRange("Document Type", Rec."Document Type");
                Sline.SetRange("Document No.", Rec."Document No.");
                Sline.SetRange(Type, Rec.Type::Item);
                Sline.SetRange("Additional Parent Item", true);
                if Sline.FindSet() then begin
                    repeat
                        ItemNumsL += Sline."No." + '|';
                    until sline.Next() = 0;
                    ItemNumsL := DelChr(ItemNumsL, '>', '|');
                    ItemL.SetFilter("No.", ItemNumsL);
                    //Page.Run(Page::"Item List", ItemL);
                    ItemList.SetRecord(ItemL);
                    ItemList.SetTableView(ItemL);
                    ItemList.LookupMode(true);
                    if ItemList.RunModal = Action::LookupOK then begin
                        ItemList.GetRecord(ItemL);
                        "Parent Item" := ItemL."No.";
                    end;

                end;
            end;
        }
        field(50152; "Additional Parent Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Parent Item';
            trigger OnValidate()
            var
                Sline: Record "Sales Line";
                ItemNumsL: Code[250];
                ItemL: Record Item;
                ItemList: Page "Item List";
            begin
                if not "Additional Parent Item" then begin
                    Sline.SetRange("Document Type", Rec."Document Type");
                    Sline.SetRange("Document No.", Rec."Document No.");
                    Sline.SetRange(Type, Rec.Type);
                    Sline.SetRange("Parent Item", Rec."No.");
                    if Sline.FindSet() then
                        Error('You Cannot UnTick the Addtional Parent Item');
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
