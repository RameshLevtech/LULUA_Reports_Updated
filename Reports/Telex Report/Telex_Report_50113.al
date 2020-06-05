report 50113 "Telex"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Telex Report\TelexReport.rdl';
    Caption = 'Telex';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<Year4>'))
            {
            }
            column(CurrencyCodeG; CurrencyCodeG)
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(BusinessType; GlobalDimension1Desc)
            {
            }
            column(EmployeeDesc; GlobalDimension2Desc)
            {
            }
            column(Document_No_; "Document No.")
            {

            }
            column(RecDimValuesLogo; RecDimValuesLogo)
            {
            }
            column(CompanyLogo; RecDimValues.Logo)//CompanyInfo.Picture)
            {
            }
            column(CompanyLogo1; CompanyInfo.Picture)
            {
            }
            column(CompanyPostcode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {

            }
            column(CompanyCountry; CountryG.Name)
            {

            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }

            column(CompanyEmail; CompanyInfo."E-Mail")
            {

            }
            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(BeneficiarryName; Recvendor.Name)
            {

            }
            column(BeneficiaryAddress; BeneficiaryAddress)
            {

            }
            column(RecipientBankAccNo; RecRecipientBank."Bank Account No.")
            {

            }
            column(RecipientBankAccName; RecRecipientBank.Name)
            {

            }
            column(RecipientBankAccAddress; RecipientBankAccAddress)
            {

            }
            column(BankAccountName; BankAccountG."Bank Account No.")
            {
            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(Bal__Account_Type; "Bal. Account Type")
            {

            }
            column(Bal__Account_No_; "Bal. Account No.")
            {

            }
            column(Credit_Amount; "Credit Amount")
            {

            }
            column(RefLbl; RefLbl)
            {

            }
            column(SWIFT; RecRecipientBank."SWIFT Code")
            {

            }
            column(TransitNo; RecRecipientBank."Transit No.")
            {

            }
            column(SortCord; RecRecipientBank."Sort Cord")
            {

            }
            column(IBAN; RecRecipientBank.IBAN)
            {

            }
            column(AmountText; AmountText)
            {

            }
            column(Bank_Charges; "Bank Charges")
            {
            }
            column(Signatory; Signatory)
            {
            }
            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CalcFields(Picture);
                if CountryG.Get(CompanyInfo."Country/Region Code") then;
            end;

            trigger OnAfterGetRecord()
            var
                RecGenLedSetup: Record "General Ledger Setup";
            begin

                if "Vendor Ledger Entry".Reversed = true then
                    Error('You Cannot Print Telex Report It Has Been Reversed');

                RecGenLedSetup.GET;
                Clear(RecDimValues);
                Clear(GlobalDimension1Desc);
                RecDimValues.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Global Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    RecDimValuesLogo := RecDimValues.Logo.HasValue;
                    GlobalDimension1Desc := RecDimValues.Name;
                end;


                Clear(GlobalDimension2Desc);
                Clear(RecDimValues2);
                RecDimValues2.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 2 Code");
                RecDimValues2.SetRange(Code, "Global Dimension 2 Code");
                if RecDimValues2.FindFirst() then begin
                    GlobalDimension2Desc := RecDimValues2.Name;
                end;



                if Recvendor.GET("Vendor No.") then begin
                    if CountryL.Get(Recvendor."Country/Region Code") then;

                    BeneficiaryAddress := Recvendor.Address;
                    if BeneficiaryAddress <> '' then
                        BeneficiaryAddress += ' ' + Recvendor."Address 2"
                    else
                        BeneficiaryAddress := Recvendor."Address 2";
                    if BeneficiaryAddress <> '' then
                        BeneficiaryAddress += ' ' + Recvendor.City
                    else
                        BeneficiaryAddress := Recvendor.City;
                    if BeneficiaryAddress <> '' then
                        BeneficiaryAddress += ' ' + Recvendor."Post Code"
                    else
                        BeneficiaryAddress := Recvendor."Post Code";
                    if BeneficiaryAddress <> '' then
                        BeneficiaryAddress += ' ' + CountryL.Name
                    else
                        BeneficiaryAddress := CountryL.Name;
                end;



                Recvendor.SetRange("Preferred Bank Account Code", "Recipient Bank Account");
                If RecRecipientBank.GET(Recvendor."No.", Recvendor."Preferred Bank Account Code") then begin
                    If CountryL1.Get(RecRecipientBank."Country/Region Code") then;

                    RecipientBankAccAddress := RecRecipientBank.Address;
                    if RecipientBankAccAddress <> '' then
                        RecipientBankAccAddress += ' ' + RecRecipientBank."Address 2"
                    else
                        RecipientBankAccAddress := RecRecipientBank."Address 2";

                    if RecipientBankAccAddress <> '' then
                        RecipientBankAccAddress += ' ' + RecRecipientBank."city"
                    else
                        RecipientBankAccAddress := RecRecipientBank."City";

                    if RecipientBankAccAddress <> '' then
                        RecipientBankAccAddress += ' ' + RecRecipientBank."Post Code"
                    else
                        RecipientBankAccAddress := RecRecipientBank."Post Code";

                    if RecipientBankAccAddress <> '' then
                        RecipientBankAccAddress += ' ' + CountryL1.Name
                    else
                        RecipientBankAccAddress := CountryL1.Name;
                end;



                Clear(BankAccountG);
                //if "Vendor Ledger Entry"."Bal. Account Type" = "Vendor Ledger Entry"."Bal. Account Type"::"Bank Account" then
                BankAccountLegderEentry.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                BankAccountLegderEentry.SetRange("Transaction No.", "Vendor Ledger Entry"."Transaction No.");
                if BankAccountLegderEentry.FindFirst() then
                    if BankAccountG.Get(BankAccountLegderEentry."Bank Account No.") then;


                RecGenLedSetup.Get();
                if "Vendor Ledger Entry"."Currency Code" = '' then
                    CurrencyCodeG := RecGenLedSetup."LCY Code"
                else
                    CurrencyCodeG := "Vendor Ledger Entry"."Currency Code";
                TotalAmt := Abs("Vendor Ledger Entry".Amount);
                IntegerAmountG := (TotalAmt DIV 1);
                DecimalAmountG := (ROUND(TotalAmt) MOD 1 * 100);
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, TotalAmt, BankAccountG."Currency Code");
                AmountInWords2 := AmtInwrdArray2[1];
                AmountInWords2 := CopyStr(AmountInWords2, 1, StrPos(AmountInWords2, 'ONLY') - 2);
                if CurrencyG.Get(CurrencyCodeG) then
                    if (CurrencyG."Currency Fractional Value" > 0) AND (DecimalAmountG > 0) then
                        AmountText := CurrencyCodeG + ' ' + AmountInWords2 + 'AND ' + Format(DecimalAmountG) + '/' + Format(CurrencyG."Currency Fractional Value") + ' ' + CurrencyG."Subsidary Currency" + '' + ' ONLY'
                    else
                        AmountText := CurrencyCodeG + ' ' + AmountInWords2 + '' + 'ONLY';
            end;



        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        BankAccountLegderEentry: Record "Bank Account Ledger Entry";
        CountryG: Record "Country/Region";
        CountryL: Record "Country/Region";
        CountryL1: Record "Country/Region";
        RecDimValues: Record "Dimension Value";
        DecimalAmountG: Decimal;
        IntegerAmountG: Integer;
        CurrencyG: Record Currency;
        RecDimValuesLogo: Boolean;
        GlobalDimension1Desc: Text;
        GlobalDimension2Desc: Text;
        RecipientBankAccAddress: Text;
        BeneficiaryAddress: Text;
        RecGenJlnLine: Record "Vendor Ledger Entry";
        VendorName: Text;
        RefLbl: Label 'Ref -';
        CurrencyCodeG: Text;
        tvar: Decimal;
        ConvertAmountInWord: Codeunit 50150;
        AmountInWords: Text;
        AmountInWords2: Text;
        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
        Recvendor: Record Vendor;
        RecRecipientBank: Record "Vendor Bank Account";
        CompanyInfo: Record "Company Information";
        RecVendorLedgerEntry: Record "Vendor Ledger Entry";
        RecDimValues2: Record "Dimension Value";
        BankAccountG: Record "Bank Account";
        TotalAmt: Decimal;


}