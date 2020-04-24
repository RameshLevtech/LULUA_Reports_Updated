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
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Document No.", "Source Type";
            DataItemTableView = SORTING("Entry No.");
            column(Entry_No_; "Entry No.")
            {
            }
            column(ReasonCodeNameG; ReasonCodeNameG) { }
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
            column(Bal__Account_Type; "Bal. Account Type")
            {
            }
            column(Bal__Account_No_; "Bal. Account No.")
            {
            }
            column(G_L_Account_Name; "G/L Account Name")
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
            column(PaymentMethodDesc; PaymentMethodG.Description)
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
            column(Description; Description)
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
            column(GlobalDimension1Desc; GlobalDimension1Desc)
            {

            }
            column(PaymentTermName; PaymentTermName)
            {

            }
            column(CustomerNoDesc; CustomerG.Name + ' - ' + customerLedgerG."Customer No.")
            {

            }
            column(DescriptionName; customerLedgerG.Description)
            {

            }
            column(AmountCust; customerLedgerG.Amount)
            {

            }
            column(AmountText; AmountText)
            {

            }

            column(VLEAmount; VLEAmount)
            {

            }
            column(CompanyHompage; CompanyInfo."Home Page")
            {

            }
            column(vendorName; vendorName)
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
            column(Currency; CurrencyCodeTextG)
            {

            }
            dataitem(DetailedVendorLedgEntry1; "Detailed Cust. Ledg. Entry")
            {
                DataItemTableView = SORTING("Applied Cust. Ledger Entry No.", "Entry Type") WHERE(Unapplied = CONST(false), "Entry Type" = CONST(Application), "Initial Document Type" = CONST(Invoice));
                column(Entry_No_DVLE; "Entry No.")
                {

                }
                // column(Document_No_DVLE; InvoiceNumbersG)
                // {

                // }
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
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    DetailedVendorLedgEntry1.SETRANGE("Document No.", "G/L Entry"."Document No.");
                end;

                trigger OnAfterGetRecord()
                var
                    RecGlSetup: Record "General Ledger Setup";
                begin
                    //     VendorLedgerEntry.RESET;
                    //     //VendorLedgerEntry.SETRANGE("Entry No.", DetailedVendorLedgEntry1."Vendor Ledger Entry No.");
                    //     IF VendorLedgerEntry.FINDFIRST THEN;
                    // Clear(InvoiceNumbersG);
                    CustomerLedgerEntryG.RESET;

                    CustomerLedgerEntryG.SETRANGE("Entry No.", DetailedVendorLedgEntry1."Cust. Ledger Entry No.");
                    IF CustomerLedgerEntryG.FindFirst() THEN
                        if InvoiceNumbersG <> '' then begin
                            if StrPos(InvoiceNumbersG, CustomerLedgerEntryG."Document No.") <= 0 then
                                InvoiceNumbersG := InvoiceNumbersG + ',' + CustomerLedgerEntryG."Document No."
                        end else
                            InvoiceNumbersG := CustomerLedgerEntryG."Document No.";
                end;
            }

            trigger OnAfterGetRecord()
            var
                GLentryRecL: Record "G/L Entry";
                RecGlSetup: Record "General Ledger Setup";
                RecVendor: Record Vendor;
                VendorLedEntry_Rec: Record "Vendor Ledger Entry";
                RecPaymentMethod: Record "Payment Method";
                CountryL: Record "Country/Region";
                PaymentTermsL: Record "Payment Terms";
            begin

                if "Bal. Account Type" = "Bal. Account Type"::Customer then
                    MainCash := "G/L Entry"."G/L Account No." + ' - ' + "G/L Entry"."G/L Account Name";

                GLentryRecL.CopyFilters("G/L Entry");
                GLentryRecL.SetRange("Document No.", "G/L Entry"."Document No.");
                GLentryRecL.SetRange("Source Type", "G/L Entry"."Source Type"::Customer);
                if not GLentryRecL.FindFirst() then
                    Error('Customer does not exits, So you cannot print the receipt voucher');

                Clear(CustomerG);
                Clear(customerLedgerG);
                CalcFields("G/L Account Name");
                Clear(RecDimValues);
                RecGlSetup.GET;
                Clear(GlobalDimension1Desc);
                RecDimValues.SetRange("Dimension Code", RecGlSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Global Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    GlobalDimension1Desc := RecDimValues.Name;
                end;

                if "Source Type" = "Source Type"::Vendor then begin
                    Clear(RecVendor);
                    if RecVendor.GET("Source No.") then
                        vendorName := RecVendor."Pay to the order of";
                end;
                if "Source Type" = "Source Type"::"Bank Account" then begin
                    Clear(RecBankAccount);
                    if RecBankAccount.GET("Source No.") then
                        BankName := RecBankAccount.Name;
                end;




                // ConvertAmountInWords.InitTextVariable;
                // ConvertAmountInWords.FormatNoText(AmtInwrd11, tvar, '');
                // AmtInwrd12 := AmtInwrd11[1];
                // IF AmtInwrd12 = '' THEN
                //     AmtInwrd12 := 'ZERO';
                // ConvertAmountInWords.InitTextVariable;
                // ConvertAmountInWords.FormatNoText(Amount_Words, TotalAmt, customerLedgerG."Currency Code");
                // Text := Amount_Words[1];
                // // AmountText1 := Text + ' ' + CurrCode + ' AND ' + AmtInwrd12 + ' ' + DecimalDec + ' ONLY';
                // AmountText1 := Text + ' ' + RecGlSetup."LCY Code" + ' AND ' + AmtInwrd12 + ' ' + ' ONLY';


                IF "Source Type" = "Source Type"::Vendor THEN BEGIN
                    Clear(VendorLedEntry_Rec);
                    VendorLedEntry_Rec.SetRange("Document Type", VendorLedEntry_Rec."Document Type"::Payment);
                    VendorLedEntry_Rec.SETRANGE("Document No.", "Document No.");
                    IF VendorLedEntry_Rec.FIND('-') THEN begin
                        CurrencyCode := VendorLedEntry_Rec."Currency Code";
                        VendorLedEntry_Rec.CalcFields(Amount);
                        VLEAmount := VendorLedEntry_Rec.Amount;
                        if VLEAmount < 0 then
                            VLEAmount := VLEAmount * -1;
                        Clear(RecPaymentMethod);
                        if RecPaymentMethod.GET(VendorLedEntry_Rec."Payment Method Code") then
                            PaymentMethodDesc := RecPaymentMethod.Description;
                    end;
                END;

                //Start Ramesh
                // CountryL.SetRange(Code, "Sales Header"."Sell-to Country/Region Code");
                // if CountryL.FindSet() then
                if CountryL.Get(CompanyInfo."Country/Region Code") then
                    CountryNameG := CountryL."County Name";

                customerLedgerG.SetRange("Document No.", "G/L Entry"."Document No.");
                if customerLedgerG.FindFirst() then begin
                    customerLedgerG.CalcFields(Amount);
                    if PaymentTermsL.Get(customerLedgerG."Payment Method Code") then
                        PaymentTermName := PaymentTermsL.Description;


                    if PaymentMethodG.Get(customerLedgerG."Payment Method Code") then;

                    //Start 24-04-2020

                    if ReasonCodeG.Get(customerLedgerG."Reason Code") then
                        ReasonCodeNameG := ReasonCodeG.Description;

                    //End 24-04-2020


                    RecGlSetup.Get();
                    if CustomerLedgerG."Currency Code" = '' then
                        CurrencyCodeTextG := RecGlSetup."LCY Code"
                    else
                        CurrencyCodeTextG := CustomerLedgerG."Currency Code";

                end;



                CustomerG.SetRange("No.", customerLedgerG."Customer No.");
                if CustomerG.FindFirst() then;

                TotalAmt := TotalAmt + Abs(customerLedgerG.Amount);//"Debit Amount";

                tvar := (ROUND(TotalAmt) MOD 1 * 100);
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray1, tvar, CurrencyCodeTextG);
                AmountInWords := AmtInwrdArray1[1];
                IF AmountInWords = '' THEN
                    AmountInWords := 'ZERO';
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, TotalAmt, CurrencyCodeTextG);
                AmountInWords2 := AmtInwrdArray2[1];
                //AmountText1 := Text + ' ' + CurrCode + ' AND ' + AmtInwrdArray2 + ' ' + DecimalDec + ' ONLY';
                AmountText := CurrencyCodeTextG + ' ' + AmountInWords2;//+ ' AND ' + AmountInWords + ' ONLY';
                                                                       // if  DimensionG.Get("G/L Entry"."Global Dimension 1 Code")then


                UsersG.SetRange("User Name", "User ID");
                if UsersG.FindFirst() then;
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
                myInt: Integer;
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
        UserSetUpG: Record "User Setup";
        UsersG: Record "User";
        CustomerG: Record Customer;
        PaymentMethodG: Record "Payment Method";
        CompanyInfo: Record "Company Information";
        Users: Record User;
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