report 50120 "Receipt Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Receipt Voucher\ReceiptVoucherLayout.rdl';
    Caption = 'Receipt Voucher';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Document No.", "Customer No.", "Posting Date";
            DataItemTableView = SORTING("Entry No.");

            column(Entry_No_; "Entry No.")
            {
            }
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<Year4>'))
            {
            }
            column(ReasonCodeNameG; ReasonCodeNameG)
            {
            }
            column(GlobalDimension1Desc; GlobalDimension1Desc)
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Currency; CurrencyCodeTextG)
            {
            }
            column(AmountCust; "Cust. Ledger Entry".Amount)
            {
            }
            column(AmountText; AmountText)
            {
            }
            column(Source_No_; "Source Code")
            {
            }
            column(MainCash; MainCash)
            {
            }
            column(Cash_Cheque_Number; "Cash/Cheque Number")
            {
            }
            column(Cheque_Date; Format("Cheque Date", 0, '<Day,2>-<Month Text,3>-<Year4>'))
            {
            }
            column(Bank_Name; "Bank Name")
            {
            }
            column(CompanyName; CompanyInfo."Long Name")
            {
            }
            column(CompanyAddress1; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPostcode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(CountryNameG; CountryG.Name)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyHompage; CompanyInfo."Home Page")
            {
            }
            column(RecDimValuesLogo; RecDimValuesLogo)
            {
            }
            column(DimensionLogo; RecDimValues.Logo)
            {
            }
            column(UserName; UserName)
            {
            }
            column(CustomerNoDesc; CustomerG.Name + ' - ' + "Customer No.")
            {
            }
            column(DescriptionName; "Cust. Ledger Entry".Description)
            {
            }
            column(CompanyVAT; CompanyInfo."VAT Registration No.")
            {
            }
            column(UsersName; UsersG."Full Name")
            {
            }
            column(Document_No_DVLE; InvoiceNumbersG)
            {
            }
            column(PageCaption; PageCaptionCap)
            {
            }
            column(Customer_No_; "Customer No.")
            {
            }
            dataitem(DetailedVendorLedgEntry1; "Detailed Cust. Ledg. Entry")
            {
                DataItemTableView = SORTING("Applied Cust. Ledger Entry No.", "Entry Type") WHERE(Unapplied = CONST(false), "Entry Type" = CONST(Application), "Initial Document Type" = CONST(Invoice));

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    DetailedVendorLedgEntry1.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    CustomerLedgerEntryG.SETRANGE("Entry No.", DetailedVendorLedgEntry1."Cust. Ledger Entry No.");
                    IF CustomerLedgerEntryG.FindFirst() THEN
                        if InvoiceNumbersG <> '' then begin
                            if StrPos(InvoiceNumbersG, CustomerLedgerEntryG."Document No.") <= 0 then
                                InvoiceNumbersG := InvoiceNumbersG + ', ' + CustomerLedgerEntryG."Document No."
                        end else
                            InvoiceNumbersG := CustomerLedgerEntryG."Document No.";
                end;
            }
            trigger OnAfterGetRecord()
            var
                RecGlSetup: Record "General Ledger Setup";
                CountryL: Record "Country/Region";
                GLentryRec2L: Record "G/L Entry";
                CustLedgL: Record "Cust. Ledger Entry";
            begin
                Clear(InvoiceNumbersG);
                Clear(CustomerLedgerEntryG);
                if "Cust. Ledger Entry".Reversed = true then Error('You Cannot Print Receipt Voucher It Has Been Reversed');
                Clear(MainCash);
                GLentryRec2L.SetFilter("Entry No.", '<>%1', "Cust. Ledger Entry"."Entry No.");
                GLentryRec2L.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                GLentryRec2L.SetRange("Source Code", 'CASHRECJNL');
                if GLentryRec2L.FindSet() then
                    repeat
                        if MainCash <> '' then
                            MainCash := MainCash + ', ' + GLentryRec2L."G/L Account No."
                        else
                            MainCash := GLentryRec2L."G/L Account No.";
                    until GLentryRec2L.Next() = 0;
                Clear(CustomerG);
                // CalcFields("G/L Account Name");
                Clear(RecDimValues);
                RecGlSetup.GET;
                Clear(GlobalDimension1Desc);
                RecDimValues.SetRange("Dimension Code", RecGlSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Global Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    RecDimValuesLogo := RecDimValues.Logo.HasValue;
                    GlobalDimension1Desc := RecDimValues.Name;
                end;
                if CustomerG.Get("Customer No.") then;

                Clear(ReasonCodeNameG);
                if ReasonCodeG.Get("Reason Code") then ReasonCodeNameG := ReasonCodeG.Description;
                RecGlSetup.Get();
                if "Cust. Ledger Entry"."Currency Code" = '' then
                    CurrencyCodeTextG := RecGlSetup."LCY Code"
                else
                    CurrencyCodeTextG := "Cust. Ledger Entry"."Currency Code";
                TotalAmt := Abs("Cust. Ledger Entry".Amount); //"Debit Amount";
                IntegerAmountG := (TotalAmt DIV 1);
                DecimalAmountG := (ROUND(TotalAmt) MOD 1 * 100);
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, IntegerAmountG, CurrencyCodeTextG);
                AmountInWords2 := AmtInwrdArray2[1];
                AmountInWords2 := CopyStr(AmountInWords2, 1, StrPos(AmountInWords2, 'ONLY') - 2);
                if CurrencyG.Get(CurrencyCodeTextG) then
                    if (CurrencyG."Currency Fractional Value" > 0) AND (DecimalAmountG > 0) then
                        AmountText := CurrencyCodeTextG + ' ' + AmountInWords2 + 'AND ' + Format(DecimalAmountG) + '/' + Format(CurrencyG."Currency Fractional Value") + ' ' + CurrencyG."Subsidary Currency" + ' ONLY'
                    else
                        AmountText := CurrencyCodeTextG + ' ' + AmountInWords2 + 'ONLY';
                UsersG.SetRange("User Name", "User ID");
                if UsersG.FindFirst() then;
                Users.SetCurrentKey("User Name");
                Users.SetRange("User Name", "Cust. Ledger Entry"."User ID");
                IF Users.FindFirst() then begin
                    if Users."Full Name" <> '' then
                        UserName := Users."Full Name"
                    else
                        UserName := UserId;
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                CompanyInfo.GET;
                CompanyInfo.CalcFields(Picture);
                if CountryG.Get(CompanyInfo."Country/Region Code") then;
                // CountryNameG := CountryL."County Name";
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        PageCaptionCap: Label 'Page %1 of %2';
        CountryG: Record "Country/Region";
        ReasonCodeG: Record "Reason Code";
        UserSetUpG: Record "User Setup";
        UsersG: Record "User";
        CustomerG: Record Customer;
        PaymentMethodG: Record "Payment Method";
        CompanyInfo: Record "Company Information";
        Users: Record User;
        AmountDecimalPlaceG: Text;
        CurrencyG: Record Currency;
        DecimalAmountG: Decimal;
        IntegerAmountG: Integer;
        RecDimValuesLogo: Boolean;
        ReasonCodeNameG: Text;
        InvoiceNumbersG: Text;
        CurrencyCodeTextG: Text;
        UserName: Text;
        MainCash: Text;
        RecDimValues: Record "Dimension Value";
        GlobalDimension1Desc: Text;
        AmtInwrd11: array[2] of Text;
        AmtInwrd12: Text;
        Amount_Words: array[2] of Text;
        Text: Text;
        PaymentTermName: Text;
        PaymentMethodDecTextG: Text;
        AmountText1: Text;
        AmountInWords: Text;
        AmountInWords2: Text;
        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
        vendorName: Text;
        CountryNameG: Text;
        RecBankAccount: Record "Bank Account";
        BankName: Text;
        CurrencyCode: Text;
        VLEAmount: Decimal;
        PaymentMethodDesc: Text;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CustomerLedgerEntryG: Record "Cust. Ledger Entry";
        DimensionG: Record "Dimension";
        customerLedgerG: Record "Cust. Ledger Entry";
        ConvertAmountInWord: Codeunit 50150;
        TotalAmt: Decimal;
        tvar: Decimal;
        ConvertAmountInWords: Codeunit "Amount In Word LT";
}
