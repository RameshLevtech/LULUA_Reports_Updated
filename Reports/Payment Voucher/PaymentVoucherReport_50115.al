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
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Document No.", "Source Type";
            DataItemTableView = SORTING("Entry No.");
            column(Entry_No_; "Entry No.")
            {
            }
            column(ReasonCodeNameG; ReasonCodeNameG) { }
            column(AmountText; AmountText)
            {

            }
            column(VatAmountDecimal; VatAmountDecimal)
            {
            }
            column(Bal__Account_Type; "Bal. Account Type")
            {
            }
            column(Bal__Account_No_; "Bal. Account No.")
            {
            }
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<Year4>'))
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(Document_No_; "Document No.")
            {

            }
            column(PaymentMethodDesc; RecPaymentMethod.Description)
            {

            }
            column(AmountText1; AmountText1)
            {

            }
            column(CompanyName; CompanyInfo."Long Name")
            {
            }
            column(Journal_Batch_Name; "Journal Batch Name")
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
            column(UserName; UserName)
            {

            }
            column(CompanyPostcode; CompanyInfo."Post Code")
            {

            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {

            }
            column(CountryNameG; CountryNameG)
            { }

            column(CompanyEmail; CompanyInfo."E-Mail")
            {

            }
            column(CompanyLogo; RecDimValues.Logo)//CompanyInfo.Picture)
            {

            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {

            }
            column(Amount_GLEntry; Amount)
            {

            }
            column(BankName; BankName)
            {

            }
            column(VLEAmount; VLEAmount)
            {

            }
            column(CompanyHompage; CompanyInfo."Home Page")
            {

            }
            column(CurrencyCode; CurrencyCode)
            {

            }
            column(CompanyVAT; CompanyInfo."VAT Registration No.")
            {

            }
            column(CheckNameG; CheckNameG)
            {

            }
            column(AccountName; AccountNameG)
            { }
            column(VatAmountDecimalTotal; VatAmountDecimalTotal)
            { }
            column(vendorName; vendorName)
            {

            }
            dataitem(DetailedVendorLedgEntry1; "Detailed Vendor Ledg. Entry")
            {
                DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type") WHERE(Unapplied = CONST(false), "Entry Type" = CONST(Application), "Initial Document Type" = CONST(Invoice));
                column(Entry_No_DVLE; "Entry No.")
                {

                }
                column(GlobalDimension1Desc; GlobalDimension1Desc)
                {

                }
                column(Description; VendorLedgerEntry.Description)
                {

                }
                column(ExternalDocNum; VendorLedgerEntry."External Document No.")
                {

                }
                column(G_L_Account_Name; GLAccountNameG)
                {
                }
                // column(vendorName; vendorName)
                // {

                // }
                column(Vendor_No_; VendorLedgerEntry."Vendor No.")
                {

                }
                // column(Document_No_DVLE; VendorLedgerEntry."External Document No.")
                // column(Document_No_DVLE; VendorLedgerEntry."Document No.")
                // {

                // }
                column(Document_No_DVLE; VendorLedgerEntry."External Document No.")
                {

                }
                column(Document_Type_DVLE; "Initial Document Type")
                {

                }
                column(Initial_Entry_Global_Dim__1_DVLE; "Initial Entry Global Dim. 1")
                {

                }
                column(Posting_Date__DVLE; "Posting Date")//Document Date
                {
                }
                column(Amount_DVLE; Amount)
                {
                }
                column(OtherDimensionDesc; OtherDimensionDesc)
                { }
                column(OtherDimensionDesc1; OtherDimensionDesc1) { }
                column(TotalAmountTextG; TotalAmountTextG)
                {

                }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    DetailedVendorLedgEntry1.SETRANGE("Document No.", "G/L Entry"."Document No.");
                end;

                trigger OnAfterGetRecord()
                var
                    DimensionSetEntryL: Record "Dimension Set Entry";
                    GLEnteriesL: Record "G/L Entry";
                    VendorL: Record Vendor;
                    RecDimValuesL: Record "Dimension Value";

                begin
                    if VendorL.Get(DetailedVendorLedgEntry1."Vendor No.") then
                        PayToVendorNameG := VendorL."Pay to the order of";
                    //Clear(GlobalDimension1Desc);
                    Clear(OtherDimensionDesc);
                    Clear(OtherDimensionDesc1);
                    VendorLedgerEntry.RESET;
                    VendorLedgerEntry.SETRANGE("Entry No.", DetailedVendorLedgEntry1."Vendor Ledger Entry No.");
                    IF VendorLedgerEntry.FINDFIRST THEN begin
                        GLEnteriesL.SetRange("Document Type", "Document Type"::Invoice);
                        GLEnteriesL.SetRange("Gen. Posting Type", GLEnteriesL."Gen. Posting Type"::Purchase);
                        GLEnteriesL.SetRange("Document No.", VendorLedgerEntry."Document No.");
                        //GLEnteriesL.SetFilter("Source Type", '<>%1', GLEnteriesL."Source Type"::Vendor);
                        if GLEnteriesL.FindLast() then begin
                            GLEnteriesL.CalcFields("G/L Account Name");
                            GLAccountNameG := GLEnteriesL."G/L Account Name";
                        end;
                    end;
                    // VAT Ramesh
                    Clear(VatAmountDecimal);
                    VatAmountLed.SetRange("Document No.", VendorLedgerEntry."Document No.");
                    if VatAmountLed.FindSet() then
                        repeat
                            VatAmountDecimal += VatAmountLed.Amount;
                        until VatAmountLed.Next() = 0;
                    VatAmountDecimalTotal := VatAmountDecimal;
                    // RecDimValuesL.SetRange("Dimension Code", RecGlSetup."Global Dimension 1 Code");
                    // RecDimValuesL.SetRange(Code, VendorLedgerEntry."Global Dimension 1 Code");
                    // if RecDimValuesL.FindFirst() then
                    //     GlobalDimension1Desc := RecDimValuesL.Name;
                    DimensionSetEntryL.SetAutoCalcFields("Dimension Value Name");
                    DimensionSetEntryL.SetRange("Dimension Set ID", VendorLedgerEntry."Dimension Set ID");
                    // DimensionSetEntryL.SetFilter("Dimension Code", '<>%1', RecGlSetup."Global Dimension 1 Code");
                    if DimensionSetEntryL.FindSet() then
                        repeat
                            if OtherDimensionDesc = '' then
                                OtherDimensionDesc := DimensionSetEntryL."Dimension Code" + '-' + DimensionSetEntryL."Dimension Value Name"
                            else
                                OtherDimensionDesc := OtherDimensionDesc + ',' + DimensionSetEntryL."Dimension Code" + '-' + DimensionSetEntryL."Dimension Value Name";

                            if OtherDimensionDesc1 = '' then
                                OtherDimensionDesc1 := DimensionSetEntryL."Dimension Value Name"
                            else
                                OtherDimensionDesc1 := OtherDimensionDesc1 + ',' + DimensionSetEntryL."Dimension Value Name";
                        until DimensionSetEntryL.Next() = 0;



                    TotalAmountTextG := TotalAmountTextG + Amount;
                end;
            }

            trigger OnAfterGetRecord()
            var
                GLentryRecL: Record "G/L Entry";
                RecVendor: Record Vendor;
                VendorLedEntry_Rec: Record "Vendor Ledger Entry";
                CountryL: Record "Country/Region";
                CheckLedEntry: Record "Check Ledger Entry";
                DimensionSetEntryRecL: Record "Dimension Set Entry";
                EntryNoTextL: Text;
            begin
                GLentryRecL.CopyFilters("G/L Entry");
                GLentryRecL.SetRange("Document No.", "G/L Entry"."Document No.");
                GLentryRecL.SetRange("Source Type", "G/L Entry"."Source Type"::Vendor);
                if not GLentryRecL.FindFirst() then
                    Error('Vendor does not exits, So you cannot print the payment voucher');


                Clear(TotalAmountTextG);
                CalcFields("G/L Account Name");
                Clear(RecDimValues);
                RecGlSetup.GET;
                // Clear(GlobalDimension1Desc);
                AccountNameG := FindAccName("Source Type", "Source No.");
                RecDimValues.SetRange("Dimension Code", RecGlSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Global Dimension 1 Code");
                if RecDimValues.FindFirst() then begin

                    RecDimValues.CalcFields(Logo);
                    //GlobalDimension1Desc := RecDimValues.Name;
                end;
                DimensionSetEntryRecL.SetRange("Dimension Set ID", "Dimension Set ID");
                DimensionSetEntryRecL.SetRange("Dimension Value Code", "Global Dimension 1 Code");
                if DimensionSetEntryRecL.FindFirst() then begin

                    DimensionSetEntryRecL.CalcFields("Dimension Value Name");
                    if GlobalDimension1Desc <> '' then
                        GlobalDimension1Desc := GlobalDimension1Desc + ' - ' + DimensionSetEntryRecL."Dimension Value Name"
                    else
                        GlobalDimension1Desc := DimensionSetEntryRecL."Dimension Value Name";
                end;



                //if "Source Type" IN ["Source Type"::"Bank Account", "Source Type"::Vendor] then begin
                if ("Source Type" = "Source Type"::"Bank Account") OR ("Source Type" = "Source Type"::Vendor) then begin
                    //if "Source Type" = "Source Type"::"Bank Account"  "Source Type" = "Source Type"::Vendor begin
                    Clear(RecBankAccount);
                    if RecBankAccount.GET("Source No.") then
                        BankName := RecBankAccount.Name
                    else
                        BankName := "G/L Entry"."G/L Account Name";

                end;
                Clear(VendorLedEntry_Rec);
                VendorLedEntry_Rec.SETRANGE("Document No.", "Document No.");
                IF VendorLedEntry_Rec.FindFirst() THEN
                    if VendorLedEntry_Rec."Currency Code" = '' then
                        CurrencyCode := RecGlSetup."LCY Code"
                    else
                        CurrencyCode := VendorLedEntry_Rec."Currency Code";
                // else
                //     Error('Vendor does not exits, So you cannot print the payment voucher');

                if ReasonCodeG.Get(VendorLedEntry_Rec."Reason Code") then
                    ReasonCodeNameG := ReasonCodeG.Description;

                if "Source Type" = "Source Type"::Vendor then begin

                    Clear(RecVendor);
                    if RecVendor.GET("Source No.") AND (RecVendor."Pay to the order of" <> '') then
                        vendorName := RecVendor."Pay to the order of"
                    else
                        vendorName := VendorLedEntry_Rec."Pay to the order of";

                    //GLAccountNameG := "G/L Entry"."G/L Account Name";
                end;

                TotalAmt := TotalAmt + "G/L Entry"."Debit Amount";
                //Message(format(TotalAmt));
                tvar := (ROUND(TotalAmt) MOD 1 * 100);
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray1, tvar, CurrencyCode);
                AmountInWords := AmtInwrdArray1[1];
                IF AmountInWords = '' THEN
                    AmountInWords := 'ZERO';
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, TotalAmt, CurrencyCode);
                AmountInWords2 := AmtInwrdArray2[1];
                //AmountText1 := Text + ' ' + CurrCode + ' AND ' + AmtInwrdArray2 + ' ' + DecimalDec + ' ONLY';
                AmountText := CurrencyCode + ' ' + AmountInWords2;//+ ' AND ' + AmountInWords + ' ONLY';

                //Message(VendorLedEntry_Rec."Payment Method Code");
                if RecPaymentMethod.GET(VendorLedEntry_Rec."Payment Method Code") then
                    PaymentMethodDesc := RecPaymentMethod.Description;
                //Message(RecPaymentMethod.Description);
                //Message(VendorLedEntry_Rec."External Document No.");
                CheckLedEntry.SetRange("Document No.", VendorLedEntry_Rec."Document No.");
                if CheckLedEntry.FindFirst() then
                    CheckNameG := CheckLedEntry."Document No."
                else
                    CheckNameG := VendorLedEntry_Rec."External Document No.";



                IF "Source Type" = "Source Type"::Vendor THEN BEGIN
                    Clear(VendorLedEntry_Rec);
                    VendorLedEntry_Rec.SetRange("Document Type", VendorLedEntry_Rec."Document Type"::Payment);
                    VendorLedEntry_Rec.SETRANGE("Document No.", "Document No.");
                    IF VendorLedEntry_Rec.FIND('-') THEN begin
                        //CurrencyCode := VendorLedEntry_Rec."Currency Code";
                        VendorLedEntry_Rec.CalcFields(Amount);
                        VLEAmount := VendorLedEntry_Rec.Amount;
                        if VLEAmount < 0 then
                            VLEAmount := VLEAmount * -1;
                        //Clear(RecPaymentMethod);



                    end;
                END;

                //Start Ramesh
                // CountryL.SetRange(Code, "Sales Header"."Sell-to Country/Region Code");
                // if CountryL.FindSet() then
                if CountryL.Get(CompanyInfo."Country/Region Code") then
                    CountryNameG := CountryL."County Name";

                Users.SetCurrentKey("User Name");
                Users.SetRange("User Name", "G/L Entry"."User ID");
                IF Users.FindFirst() then begin
                    if Users."Full Name" <> '' then
                        UserName := Users."Full Name"
                    else
                        UserName := UserId;
                end;

            end;
            //Stop Ramesh


            trigger OnPreDataItem()
            var

            begin
                CompanyInfo.GET;
                CompanyInfo.CalcFields(Picture);
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
        ReasonCodeG: Record "Reason Code";
        VatAmountLed: Record "VAT Entry";
        CompanyInfo: Record "Company Information";
        RecGlSetup: Record "General Ledger Setup";
        Users: Record User;
        RecPaymentMethod: Record "Payment Method";
        UserName: Text;
        ReasonCodeNameG: Text;
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


        VendorLedgerEntry: Record "Vendor Ledger Entry";
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