pageextension 50162 "Ext Vendor Ledger Enteries" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("Pay to the order of"; "Pay to the order of")
            {
                ApplicationArea = All;
            }
            field("Cash/Cheque Number"; "Cash/Cheque Number")
            {
                ApplicationArea = All;
            }
            field("Cheque Date"; "Cheque Date")
            {
                ApplicationArea = All;
            }
            field("Bank Name"; "Bank Name")
            {
                ApplicationArea = All;
            }
            field("Bank Charges"; "Bank Charges")
            {
                ApplicationArea = All;
            }
            field(Signatory; Signatory)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Create Payment")
        {
            action(Telex)
            {
                ApplicationArea = All;
                Image = PrintExcise;
                trigger OnAction()
                Var
                    VendorLedgEntryL: Record "Vendor Ledger Entry";
                begin
                    VendorLedgEntryL.SetRange("Document No.", "Document No.");
                    Report.Run(Report::Telex, true, true, VendorLedgEntryL);
                end;
            }
            action("Payment Voucher")
            {
                ApplicationArea = All;
                Image = PaymentJournal;
                trigger OnAction()
                VAR
                    RecGLEntries: Record "G/L Entry";
                    PaymentVoucherReport: Report "Payment Voucher Report";
                    VendorLegderEntryL: Record "Vendor Ledger Entry";
                begin
                    // Clear(RecGLEntries);
                    // RecGLEntries.SetRange("Document No.", Rec."Document No.");
                    // RecGLEntries.SetRange("Posting Date", Rec."Posting Date");
                    // if RecGLEntries.FindSet() then begin
                    //     PaymentVoucherReport.SetTableView(RecGLEntries);
                    //     PaymentVoucherReport.Run();
                    // end;
                    VendorLegderEntryL.SetRange("Document No.", "Document No.");
                    VendorLegderEntryL.SetRange("Posting Date", "Posting Date");
                    Report.Run(Report::"Payment Voucher Report", true, true, VendorLegderEntryL);
                end;
            }
        }

    }

    var
        myInt: Integer;
}