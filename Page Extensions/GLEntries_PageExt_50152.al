pageextension 50152 GLEntries extends "General Ledger Entries"
{
    layout
    {
        addafter("Bal. Account Type")
        {
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
        // Add changes to page actions here
        addafter("Ent&ry")
        {
            group(Print)
            {
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


                action("Journal Voucher")
                {
                    ApplicationArea = All;
                    Image = PaymentJournal;
                    trigger OnAction()
                    VAR
                        RecGLEntries: Record "G/L Entry";
                        JournalVoucherReport: Report JournalVoucher;
                    begin
                        Clear(RecGLEntries);
                        RecGLEntries.SetRange("Document No.", Rec."Document No.");
                        RecGLEntries.SetRange("Posting Date", Rec."Posting Date");
                        if RecGLEntries.FindSet() then begin
                            JournalVoucherReport.SetTableView(RecGLEntries);
                            JournalVoucherReport.Run();
                        end;
                    end;
                }
                action("Receipt Voucher")
                {
                    ApplicationArea = All;
                    Image = ReceiptVoucher;
                    trigger OnAction()
                    VAR
                        RecGLEntries: Record "G/L Entry";
                        ReceiptVoucherReport: Report "Receipt Voucher";
                    begin
                        Clear(RecGLEntries);
                        RecGLEntries.SetRange("Document No.", Rec."Document No.");
                        RecGLEntries.SetRange("Posting Date", Rec."Posting Date");
                        if RecGLEntries.FindSet() then begin
                            ReceiptVoucherReport.SetTableView(RecGLEntries);
                            ReceiptVoucherReport.Run();
                        end;
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}