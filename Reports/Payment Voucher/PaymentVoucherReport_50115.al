report 50115 "Payment Voucher Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Payment Voucher\PaymentVoucherLayout.rdl';
    Caption = 'Payment Voucher';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Document No.";
            DataItemTableView = SORTING("Entry No.");
            CalcFields = Amount;
            column(Entry_No_; "Entry No.") { }
            column(vendorName; VendorG.Name) { }
            column(Journal_Batch_Name; "Journal Batch Name") { }
            column(Document_No_; "Document No.") { }
            column(CurrencyCodeTextG; CurrencyCodeTextG) { }
            column(ReasonCodeNameG; ReasonCodeNameG) { }
            column(BankName; BankName) { }
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<Year4>')) { }
            column(Vendor_No_; "Vendor No.") { }
            column("VLEReasonCode"; ReasonCodeG.Description) { }
            column(CompanyName; CompanyInfo."Long Name") { }
            column(CompanyAddress1; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(UserName; UserName) { }
            column(CompanyPostcode; CompanyInfo."Post Code") { }
            column(CompanyCountry; CompanyInfo."Country/Region Code") { }
            column(CountryNameG; CountryG.Name) { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(RecDimValuesLogo; RecDimValuesLogo) { }
            column(DimensionLogo; RecDimValues.Logo) { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyHompage; CompanyInfo."Home Page") { }
            column(CompanyVAT; CompanyInfo."VAT Registration No.") { }
            column(CheckNameG; CheckNameG) { }
            column(Document_No_DVLE; "Vendor Ledger Entry"."External Document No.") { }
            column(AmountText; AmountText) { }
            column(VLE_Amount; Amount) { }
            column(InvoiceLbl; InvoiceLbl) { }
            column(AppliedAmountLbl; AppliedAmountLbl) { }
            column(OriginalAmountLbl; OriginalAmountLbl) { }
            column(RemaningAmountLbl; RemaningAmountLbl) { }
            column(PurposeLbl; PurposeLbl) { }
            column(ChequeDateNo; ChequeDateNo) { }


            dataitem(DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry")
            {
                DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type") WHERE(Unapplied = CONST(false), "Entry Type" = CONST(Application), "Initial Document Type" = CONST(Invoice));
                column(Entry_No_DVLE; "Entry No.") { }
                column(G_L_Account_Name; GLAccountNameG) { }
                column(DVLE_Amount; DetailedVendorLedgEntry.Amount) { }
                dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
                {
                    DataItemTableView = SORTING("Entry No.");
                    DataItemLinkReference = DetailedVendorLedgEntry;
                    DataItemLink = "Entry No." = FIELD("Vendor Ledger Entry No.");
                    CalcFields = "Original Amount", "Remaining Amount";
                    column(Description; VendorLedgerEntry.Description) { }
                    column(VendorLedgerEntryOriginalAMT; Abs(VendorLedgerEntry."Original Amount")) { }
                    column(VendorLedgerEntryRemainingAMT; Abs(VendorLedgerEntry."Remaining Amount")) { }
                    column(VendorLedgerEntryDocNo; VendorLedgerEntry."Document No.") { }
                    column(External_Document_No; VendorLedgerEntry."External Document No.") { }

                    dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
                    {
                        DataItemTableView = SORTING("No.");
                        DataItemLinkReference = VendorLedgerEntry;
                        DataItemLink = "No." = field("Document No.");
                        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                        {
                            DataItemTableView = SORTING("Document No.");
                            DataItemLinkReference = "Purch. Inv. Header";
                            //DataItemTableView = WHERE(Type = FILTER(Item));
                            DataItemLink = "Document No." = field("No.");
                            column(Type; Type) { }
                            column(InvoiceDocNo; "Document No.") { }
                            column(GLNo; GLAccountG."No.") { }
                            column(GLAccName; GLAccountG.Name) { }
                            column(ItemNo; "No.") { }
                            column(ItemDesc; Description) { }
                            column(Amount; Amount) { }
                            column(Amount_Including_VAT; "Amount Including VAT") { }
                            column(PurchaseInvocie_VAT_Amount; "Amount Including VAT" - Amount) { }
                            column(OtherDimensionDesc; OtherDimensionDesc) { }
                            column(OtherDimensionDesc1; OtherDimensionDesc1) { }



                            trigger OnAfterGetRecord()
                            var
                                DimensionSetEntryL: Record "Dimension Set Entry";
                                GLSetupL: Record "General Ledger Setup";
                            begin
                                Clear(GLAccountG);
                                if GLAccountG.Get("No.") then;
                                Clear(OtherDimensionDesc);
                                Clear(OtherDimensionDesc1);


                                DimensionSetEntryL.SetAutoCalcFields("Dimension Value Name");
                                DimensionSetEntryL.SetRange("Dimension Set ID", "Dimension Set ID");
                                if DimensionSetEntryL.FindSet() then
                                    repeat
                                        if OtherDimensionDesc = '' then
                                            OtherDimensionDesc := DimensionSetEntryL."Dimension Value Code"
                                        else
                                            OtherDimensionDesc := OtherDimensionDesc + ',' + DimensionSetEntryL."Dimension Value Code";
                                    until DimensionSetEntryL.Next() = 0;

                                Clear(GLSetupL);
                                GLSetupL.Get();
                                DimensionSetEntryL.SetRange("Dimension Code", GLSetupL."Shortcut Dimension 1 Code");
                                if DimensionSetEntryL.FindFirst() then
                                    OtherDimensionDesc1 := DimensionSetEntryL."Dimension Value Code";
                            end;
                        }

                    }

                }


                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    DetailedVendorLedgEntry.SETRANGE("Document No.", "Vendor Ledger Entry"."Document No.");
                end;
            }
            trigger OnAfterGetRecord()
            var
                GLEntryL: Record "G/L Entry";
                BankLedgerEntryL: Record "Bank Account Ledger Entry";
                VendorL: Record Vendor;
                GLAccount: Record "G/L Account";
            begin
                if "Vendor Ledger Entry".Reversed = true then
                    Error('You Cannot Print Payment Voucher It Has Been Reversed');
                RecDimValues.SetRange("Dimension Code", RecGlSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Global Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    RecDimValuesLogo := RecDimValues.Logo.HasValue;
                end;
                if VendorG.Get("Vendor No.") then;

                RecGlSetup.Get();
                if "Vendor Ledger Entry"."Currency Code" = '' then
                    CurrencyCodeTextG := RecGlSetup."LCY Code"
                else
                    CurrencyCodeTextG := "Vendor Ledger Entry"."Currency Code";
                TotalAmt := Abs("Vendor Ledger Entry".Amount); //"Debit Amount";
                IntegerAmountG := (TotalAmt DIV 1);
                DecimalAmountG := (ROUND(TotalAmt) MOD 1 * 100);
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, IntegerAmountG, CurrencyCodeTextG);
                AmountInWords2 := AmtInwrdArray2[1];
                AmountInWords2 := CopyStr(AmountInWords2, 1, StrPos(AmountInWords2, 'ONLY') - 2);
                if CurrencyG.Get(CurrencyCodeTextG) AND (CurrencyG."Currency Fractional Value" > 0) AND (DecimalAmountG > 0) then
                    AmountText := CurrencyCodeTextG + ' ' + AmountInWords2 + 'AND ' + Format(DecimalAmountG) + '/' + Format(CurrencyG."Currency Fractional Value") + ' ' + CurrencyG."Subsidary Currency" + ' ONLY'
                else
                    AmountText := CurrencyCodeTextG + ' ' + AmountInWords2 + 'ONLY';

                if "Vendor Ledger Entry"."Cash/Cheque Number" <> '' then
                    ChequeDateNo := "Vendor Ledger Entry"."Cash/Cheque Number" + ' ' + Format("Cheque Date", 0, '<Day,2>-<Month Text,3>-<Year4>');

                if ReasonCodeG.Get("Reason Code") then;

                Clear(BankName);
                BankLedgerEntryL.SetRange("Document No.", "Document No.");
                BankLedgerEntryL.SetRange("Transaction No.", "Transaction No.");
                if BankLedgerEntryL.FindFirst() then begin
                    if RecBankAccount.Get(BankLedgerEntryL."Bank Account No.") then
                        BankName := RecBankAccount.Name;
                end else begin
                    if GLAccount.Get("Bal. Account No.") then
                        BankName := GLAccount.Name
                    else begin
                        GLEntryL.SetRange("Document No.", "Document No.");
                        GLEntryL.SetRange("Transaction No.", "Transaction No.");
                        GLEntryL.SetFilter("Entry No.", '<>%1', "Entry No.");
                        if GLEntryL.FindFirst() then;
                        GLEntryL.CalcFields("G/L Account Name");
                        BankName := GLEntryL."G/L Account Name";
                    end;
                end;



                Users.SetCurrentKey("User Name");
                Users.SetRange("User Name", "Vendor Ledger Entry"."User ID");
                IF Users.FindFirst() then begin
                    if Users."Full Name" <> '' then
                        UserName := Users."Full Name"
                    else
                        UserName := UserId;
                end;

            end;


            trigger OnPreDataItem()
            var
            begin
                CompanyInfo.GET;
                CompanyInfo.CalcFields(Picture);
                if CountryG.Get(CompanyInfo."Country/Region Code") then;
            end;
        }
    }



    var
        CountryG: Record "Country/Region";
        ChequeDateNo: Text;
        PurchaseInvoiceCounterG: Integer;
        InvoiceLbl: Label 'Invoice';
        AppliedAmountLbl: Label 'Applied Amount';
        OriginalAmountLbl: Label 'Original Amount';
        RemaningAmountLbl: Label 'Remaning Amount';
        PurposeLbl: Label 'Purpose';
        VendorG: Record Vendor;
        ReasonCodeG: Record "Reason Code";
        VatAmountLed: Record "VAT Entry";
        CompanyInfo: Record "Company Information";
        RecGlSetup: Record "General Ledger Setup";
        Users: Record User;
        RecPaymentMethod: Record "Payment Method";
        UserName: Text;
        CheckNumberDateG: Text;
        RecDimValuesLogo: Boolean;
        ReasonCodeNameG: Text;
        CurrencyG: Record Currency;
        DecimalAmountG: Decimal;
        IntegerAmountG: Integer;
        CurrencyCodeTextG: Text;
        ExternalDocumentNo: Text;
        RecDimValues: Record "Dimension Value";
        OtherDimensionDesc: Text;
        OtherDimensionDesc1: Text;
        GlobalDimension1Desc: Text;
        AmtInwrd11: array[2] of Text;
        AmtInwrd12: Text;
        Amount_Words: array[2] of Text;
        Text: Text;
        AmountInWords2: Text;
        AmtInwrdArray2: array[2] of Text;
        PayToVendorNameG: Text;
        AmountText1: Text;
        vendorName: Text;
        AmountText: Text;
        TotalAmountTextG: Decimal;
        CountryNameG: Text;
        RecBankAccount: Record "Bank Account";
        BankName: Text;
        CurrencyCode: Text;
        VLEAmount: Decimal;
        PaymentMethodDesc: Text;
        CheckNameG: Text;
        GLAccountNameG: Text;
        VatAmountDecimal: Decimal;
        VatAmountDecimalTotal: Decimal;
        AccountNameG: Text;
        AmountInWords: Text;
        AmtInwrdArray1: array[2] of Text;
        GLAccountG: Record "G/L Account";
        ConvertAmountInWord: Codeunit 50150;
        TotalAmt: Decimal;
        tvar: Decimal;
        ConvertAmountInWords: Codeunit "Amount In Word LT";

    local procedure FindAccName(SourceTypeP: Option " ",Customer,Vendor,"Bank Account","Fixed Asset",Employee; SourceNoP: Code[20]): Text
    var
        AccName: Text[250];
        Vend: Record "Vendor";
        Cust: Record "Customer";
        Bank: Record "Bank Account";
        GLAccount: Record "G/L Account";
        Employee: Record Employee;
    begin
        case SourceTypeP of
            SourceTypeP::Vendor:
                begin
                    if Vend.Get(SourceNoP) then
                        AccName := Vend.Name;
                end;
            SourceTypeP::"Bank Account":
                begin
                    if Bank.Get(SourceNoP) then
                        AccName := Bank.Name;
                end;
            SourceTypeP::Customer:
                begin
                    if Cust.Get(SourceNoP) then
                        AccName := Cust.Name;
                end;
            SourceTypeP::Employee:
                begin
                    if Employee.Get(SourceNoP) then
                        AccName := Employee.FullName();
                end;
            SourceTypeP::" ":
                begin
                    if GLAccount.Get(SourceNoP) then
                        AccName := GLAccount.Name;
                end;
        end;
        exit(AccName);
    end;
}