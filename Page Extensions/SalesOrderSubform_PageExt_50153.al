pageextension 50153 "SoSubform" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Cross-Reference No"; "Cross-Reference No.")
            {
                ApplicationArea = All;
            }
            field("Parent Item"; "Parent Item")
            {
                ApplicationArea = All;
                Enabled = ParentItemEnable;
                trigger OnLookup(Var Text: Text): Boolean
                var
                    PageSline: Page "Sales Lines";
                    RecSline: Record "Sales Line";
                begin
                    Clear(RecSline);
                    RecSline.SetRange("Document Type", "Document Type");
                    RecSline.SetRange("Document No.", "Document No.");
                    RecSline.SetRange(Type, Type::Item);
                    RecSline.SetFilter("No.", '<>%1', "No.");
                    if RecSline.FindSet() then begin
                        PageSline.SetTableView(RecSline);
                        PageSline.LOOKUPMODE := TRUE;
                        PageSline.Editable(false);
                        IF PageSline.RUNMODAL = ACTION::LookupOK THEN begin
                            PageSline.GetRecord(RecSline);
                            "Parent Item" := RecSline."No.";
                        end;
                    end;
                end;
            }
        }
        //Ramesh
        addafter("Unit Price")
        {
            field("FOC Sales"; "FOC Sales")
            {
                ApplicationArea = All;
            }
        }
        //Ramesh
        modify(Type)
        {
            trigger OnAfterValidate()
            begin

                if Type = Type::Item then
                    ParentItemEnable := true
                else
                    ParentItemEnable := false;

            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Type = Type::Item then
            ParentItemEnable := true
        else
            ParentItemEnable := false;
    end;

    var
        ParentItemEnable: Boolean;
}