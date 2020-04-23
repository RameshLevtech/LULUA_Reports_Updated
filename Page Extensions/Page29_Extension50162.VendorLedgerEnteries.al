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
                    PettycashReport: Report Telex;
                    RecGLEntries: Record "G/L Entry";
                begin
                    Clear(RecGLEntries);
                    RecGLEntries.SetRange("Document No.", Rec."Document No.");
                    //RecGLEntries.SetRange("Posting Date", Rec."Posting Date");
                    if RecGLEntries.FindSet() then begin
                        PettycashReport.SetTableView(RecGLEntries);
                        PettycashReport.Run();
                    end;
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
                begin
                    Clear(RecGLEntries);
                    RecGLEntries.SetRange("Document No.", Rec."Document No.");
                    RecGLEntries.SetRange("Posting Date", Rec."Posting Date");
                    if RecGLEntries.FindSet() then begin
                        PaymentVoucherReport.SetTableView(RecGLEntries);
                        PaymentVoucherReport.Run();
                    end;
                end;
            }
        }

    }

    var
        myInt: Integer;
}