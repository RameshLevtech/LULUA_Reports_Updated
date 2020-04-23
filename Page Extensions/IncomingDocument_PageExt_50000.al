pageextension 50000 IncomingDocument extends "Incoming Document"
{
    layout
    {
        // Add changes to page layout here
        modify("Vendor Name")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Vendor VAT Registration No.")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Vendor IBAN")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Vendor Bank Account No.")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Vendor Bank Branch No.")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Vendor Phone No.")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Vendor Invoice No.")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }

        modify("Document Date")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Due Date")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Amount Excl. VAT")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Amount Incl. VAT")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("VAT Amount")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        modify("Currency Code")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
        }
        addbefore("Vendor Name")
        {
            field("Vendor No."; "Vendor No.")
            {
                ApplicationArea = All;
                Editable = IsEnabled;
                Enabled = IsEnabled;
            }

        }
        modify("Order No.")
        {
            Editable = IsEnabled;
            Enabled = IsEnabled;
            trigger OnLookup(VAR Text: Text): Boolean
            var
                RecPurchHeader: Record "Purchase Header";
                PagePurchList: Page "Purchase List";
            begin
                //TableRelation = "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("Vendor No."));
                Clear(RecPurchHeader);
                RecPurchHeader.SetRange("Document Type", RecPurchHeader."Document Type"::Order);
                RecPurchHeader.SetRange("Buy-from Vendor No.", "Vendor No.");
                RecPurchHeader.SetRange(Status, RecPurchHeader.Status::Released);
                if RecPurchHeader.FindSet() then;
                PagePurchList.SetTableView(RecPurchHeader);
                PagePurchList.LookupMode(true);
                if PagePurchList.RunModal() = Action::LookupOK then begin
                    PagePurchList.GetRecord(RecPurchHeader);
                    Text := RecPurchHeader."No.";
                    exit(true);
                end;
            end;
        }

        movebefore("Vendor Bank Account No."; "Vendor IBAN")
        addafter("Vendor VAT Registration No.")
        {
            field("Bank Account Code"; "Bank Account Code")
            {
                ApplicationArea = All;
                Editable = IsEnabled;
                Enabled = IsEnabled;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(SendApprovalRequest)
        {
            trigger OnAfterAction()
            begin
                if Status = Status::"Pending Approval" then
                    IsEnabled := false
                else
                    IsEnabled := true;
                CurrPage.Update();
            end;
        }
    }

    trigger OnOpenPage()
    begin
        if (Status = Status::Released) OR (Status = Status::"Pending Approval") then
            IsEnabled := false
        else
            IsEnabled := true
    end;



    protected var
        IsEnabled: Boolean;

    var
        myInt: Integer;
}