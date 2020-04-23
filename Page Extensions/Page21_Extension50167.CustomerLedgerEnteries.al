pageextension 50167 "Ext Customer Ledger Enteries" extends "Customer Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(ShowDocumentAttachment)
        {
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


    var
        myInt: Integer;
}