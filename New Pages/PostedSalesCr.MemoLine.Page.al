page 50011 "Posted Sales Cr.Memo Line"
{

    ApplicationArea = All;
    Caption = 'Posted Sales Cr.Memo Line';
    PageType = List;
    SourceTable = "Sales Cr.Memo Line";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; "VAT %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; "Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; "Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Units per Parcel"; "Units per Parcel")
                {
                    ApplicationArea = All;
                }
                field("Unit Volume"; "Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; "Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    ApplicationArea = All;
                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                }
                field("Order Line No."; "Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Calculation Type"; "VAT Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Attached to Line No."; "Attached to Line No.")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; "Exit Point")
                {
                    ApplicationArea = All;
                }
                //         field(Area; Area)
                // {
                //                         ApplicationArea = All;
                // }
                field("Transaction Specification"; "Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Tax Category"; "Tax Category")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; "Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; "Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; "Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Clause Code"; "VAT Clause Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No."; "Blanket Order No.")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; "Blanket Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Base Amount"; "VAT Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("System-Created Entry"; "System-Created Entry")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Difference"; "VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("VAT Identifier"; "VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; "IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Reference"; "IC Partner Reference")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Line"; "Prepayment Line")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Amount"; "Pmt. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Calculation"; "Line Discount Calculation")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Contract Entry No."; "Job Contract Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Deferral Code"; "Deferral Code")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("FA Posting Date"; "FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; "Depreciation Book Code")
                {
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; "Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; "Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                }
                field("Use Duplication List"; "Use Duplication List")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure (Cross Ref.)"; "Unit of Measure (Cross Ref.)")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference Type"; "Cross-Reference Type")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference Type No."; "Cross-Reference Type No.")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(Nonstock; Nonstock)
                {
                    ApplicationArea = All;
                }
                field("Purchasing Code"; "Purchasing Code")
                {
                    ApplicationArea = All;
                }
                // field("Product Group Code"; "Product Group Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Appl.-from Item Entry"; "Appl.-from Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt No."; "Return Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt Line No."; "Return Receipt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; "Allow Line Disc.")
                {
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; "Customer Disc. Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
