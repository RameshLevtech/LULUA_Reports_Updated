pageextension 50167 "Ext Customer Ledger Enteries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Cash/Cheque Number"; "Cash/Cheque Number")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Cheque Date"; "Cheque Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Bank Name"; "Bank Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
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
                    RecCustLedgL: Record "Cust. Ledger Entry";
                    ReceiptVoucherReport: Report "Receipt Voucher";
                begin
                    if "Document Type" IN ["Document Type"::" ", "Document Type"::Payment, "Document Type"::Refund] then begin
                        RecCustLedgL.SetRange("Document No.", "Document No.");
                        RecCustLedgL.SetRange("Customer No.", "Customer No.");
                        RecCustLedgL.SetRange("Posting Date", "Posting Date");
                        Report.Run(Report::"Receipt Voucher", true, true, RecCustLedgL);
                    end;
                end;

            }
        }
    }


    var
        myInt: Integer;
}