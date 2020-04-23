pageextension 50104 "Foc Po Cancellation" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("Remarks For Cancellation"; "Remarks For Cancellation")
            {
                ApplicationArea = All;
                // Visible = VisableG;
            }
            field("Cancel PO"; "Cancel PO")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible = VisableG;
            }
            field("Cancelled UserID"; "Cancelled UserID")
            {
                ApplicationArea = All;
            }
            field("Cancelled DateTime"; "Cancelled DateTime")
            {
                ApplicationArea = All;
                // Visible = VisableG;
            }
            field("Remarks For Short Close"; "Remarks For Short Close")
            {
                ApplicationArea = All;
                //  Visible = VisableG;
            }
            field("PO Short Close"; "Short Close")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible = VisableG;
            }
            field("Short Close Cancelled User ID"; "Short Close Cancelled User ID")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible = VisableG;
            }
            field("Short Close Cancelled DateTime"; "Short Close Cancelled DateTime")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible = VisableG;
            }
        }


        addafter(PurchLines)
        {
            group(Quotations)
            {
                field("Vendor No.1"; "Vendor No.1")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                }
                field("Vendor Name 1"; "Vendor Name 1")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                }
                field(Attachment1; Attachment1)
                {
                    ApplicationArea = All;
                    Caption = 'Attachment';
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        Clear(RecDocAttachment);
                        Clear(DocumentAttachmentDetails);
                        //RecDocAttachment.SetRange("Table ID", 38);
                        RecDocAttachment.SetRange("No.", "No.");
                        RecDocAttachment.SetRange("Vendor Line No.", 10000);
                        DocumentAttachmentDetails.SetData(10000, "No.", 38, true);
                        DocumentAttachmentDetails.SetTableView(RecDocAttachment);
                        if DocumentAttachmentDetails.RunModal() = Action::LookupOK then;
                        UpdateAttachmentValues;
                        CurrPage.Update();
                    end;
                }
                field("Vendor No.2"; "Vendor No.2")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                }
                field("Vendor Name 2"; "Vendor Name 2")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                }
                field(Attachment2; Attachment2)
                {
                    ApplicationArea = All;
                    Caption = 'Attachment';
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        Clear(RecDocAttachment);
                        Clear(DocumentAttachmentDetails);
                        //RecDocAttachment.SetRange("Table ID", 38);
                        RecDocAttachment.SetRange("No.", "No.");
                        RecDocAttachment.SetRange("Vendor Line No.", 20000);
                        DocumentAttachmentDetails.SetData(20000, "No.", 38, true);
                        DocumentAttachmentDetails.SetTableView(RecDocAttachment);
                        if DocumentAttachmentDetails.RunModal() = Action::LookupOK then;
                        UpdateAttachmentValues;
                        CurrPage.Update();
                    end;
                }
                field("Vendor No.3"; "Vendor No.3")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                }
                field("Vendor Name 3"; "Vendor Name 3")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';

                }
                field(Attachment3; Attachment3)
                {
                    ApplicationArea = All;
                    Caption = 'Attachment';
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        Clear(RecDocAttachment);
                        Clear(DocumentAttachmentDetails);
                        //RecDocAttachment.SetRange("Table ID", 38);
                        RecDocAttachment.SetRange("No.", "No.");
                        RecDocAttachment.SetRange("Vendor Line No.", 30000);
                        DocumentAttachmentDetails.SetData(30000, "No.", 38, true);
                        DocumentAttachmentDetails.SetTableView(RecDocAttachment);
                        if DocumentAttachmentDetails.RunModal() = Action::LookupOK then;
                        UpdateAttachmentValues;
                        CurrPage.Update();
                    end;
                }

            }
        }
    }

    actions
    {
        addafter(Print)
        {
            group(ShortcloseCancelation)
            {
                Caption = 'Shortclose/Cancelation';
                action("Cancel PurchaseOrder")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel PurchaseOrder';
                    // Visible = VisableG;
                }
                action("Order Short Close")
                {
                    ApplicationArea = All;
                    Caption = 'Order Short Close';
                    // Visible = VisableG;
                }
            }
        }
    }

    local procedure UpdateAttachmentValues()
    begin
        Clear(RecDocAttachment);
        //RecDocAttachment.SetRange("Table ID", Database::"Purchase Header");
        RecDocAttachment.SetRange("No.", "No.");
        RecDocAttachment.SetRange("Vendor Line No.", 10000);
        if RecDocAttachment.FindSet() then
            Attachment1 := RecDocAttachment.Count;

        Clear(RecDocAttachment);
        //RecDocAttachment.SetRange("Table ID", Database::"Purchase Header");
        RecDocAttachment.SetRange("No.", "No.");
        RecDocAttachment.SetRange("Vendor Line No.", 20000);
        if RecDocAttachment.FindSet() then
            Attachment2 := RecDocAttachment.Count;

        Clear(RecDocAttachment);
        //RecDocAttachment.SetRange("Table ID", Database::"Purchase Header");
        RecDocAttachment.SetRange("No.", "No.");
        RecDocAttachment.SetRange("Vendor Line No.", 30000);
        if RecDocAttachment.FindSet() then
            Attachment3 := RecDocAttachment.Count;
    end;

    var
        Attachment1: Integer;
        Attachment2: Integer;
        Attachment3: Integer;
        RecDocAttachment: Record "Document Attachment";
        DocumentAttachmentDetails: Page "Document Attachment Details";
}