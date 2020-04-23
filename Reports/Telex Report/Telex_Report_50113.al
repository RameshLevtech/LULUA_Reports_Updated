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
        dataitem("Gen. Journal Line"; "G/L Entry")
        {
            column(Posting_Date; "Posting Date")
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
            column(CompanyLogo; RecDimValues.Logo)//CompanyInfo.Picture)
            {
            }
            column(CompanyPostcode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {

            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {

            }
            column(CompanyPhone; 'T:' + CompanyInfo."Phone No.")
            {
            }

            column(CompanyEmail; 'E:' + CompanyInfo."E-Mail")
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
            column(BeneficiaryAddress; Recvendor.Address + ' ' + Recvendor."Address 2" + ' ' + Recvendor.City + ' ' + Recvendor."Post Code" + ' ' + Recvendor."Country/Region Code")
            {

            }
            column(RecipientBankAccNo; RecRecipientBank."Bank Account No.")
            {

            }
            column(RecipientBankAccName; RecRecipientBank.Name)
            {

            }
            column(RecipientBankAccAddress; RecRecipientBank.Address + ' ' + RecRecipientBank."Address 2" + ' ' + RecRecipientBank.City + ' ' + RecRecipientBank."Post Code" + ' ' + RecRecipientBank."Country/Region Code")
            {

            }
            column(BankAccountName; BankAccountG.Name + '' + BankAccountG."Bank Account No.")
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
            column(IBAN; RecRecipientBank.IBAN)
            {

            }
            column(AmountText; AmountText)
            {

            }
            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
            end;

            trigger OnAfterGetRecord()
            var
                RecGenLedSetup: Record "General Ledger Setup";
            begin
                RecGenLedSetup.GET;
                Clear(RecDimValues);
                Clear(GlobalDimension1Desc);
                RecDimValues.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Global Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    GlobalDimension1Desc := RecDimValues.Name;
                end;


                Clear(GlobalDimension2Desc);
                Clear(RecDimValues2);
                RecDimValues2.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 2 Code");
                RecDimValues2.SetRange(Code, "Global Dimension 2 Code");
                if RecDimValues2.FindFirst() then begin
                    GlobalDimension2Desc := RecDimValues2.Name;
                end;


                if "Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."Bal. Account Type"::Vendor then
                    // if "Source Type" = "Source Type"::Vendor then begin
                    // if Recvendor.GET("Source No.") then;
                    if Recvendor.Get("Bal. Account No.") then;
                RecVendorLedgerEntry.SetRange("Document No.", "Document No.");
                RecVendorLedgerEntry.SetRange("Vendor No.", Recvendor."No.");
                RecVendorLedgerEntry.SetFilter("Recipient Bank Account", '<>%1', '');
                if RecVendorLedgerEntry.FindFirst() then begin
                    Clear(RecRecipientBank);
                    If RecRecipientBank.GET(Recvendor."No.", RecVendorLedgerEntry."Recipient Bank Account") then;
                end;
                Clear(BankAccountG);
                if "Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."Bal. Account Type"::"Bank Account" then
                    if BankAccountG.Get("Gen. Journal Line"."Bal. Account No.") then;



                tvar := (ROUND(Amount) MOD 1 * 100);
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray1, tvar, BankAccountG."Currency Code");
                AmountInWords := AmtInwrdArray1[1];
                IF AmountInWords = '' THEN
                    AmountInWords := 'ZERO';
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, Amount, BankAccountG."Currency Code");
                AmountInWords2 := AmtInwrdArray2[1];
                //AmountText1 := Text + ' ' + CurrCode + ' AND ' + AmtInwrdArray2 + ' ' + DecimalDec + ' ONLY';
                AmountText := BankAccountG."Currency Code" + ' ' + AmountInWords2;//+ ' AND ' + AmountInWords + ' ONLY';
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
        RecDimValues: Record "Dimension Value";
        GlobalDimension1Desc: Text;
        GlobalDimension2Desc: Text;
        RecGenJlnLine: Record "Gen. Journal Line";
        VendorName: Text;
        RefLbl: Label 'Ref -';
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


}