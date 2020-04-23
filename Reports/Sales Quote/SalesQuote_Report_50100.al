report 50104 "Sales Quote Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Sales Quote\SalesQuote.rdl';
    Caption = 'Sales Quote';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(No_; "No.")
            {

            }
            column(CompanyName; CompanyInfo."Long Name")
            {
            }
            column(QuoteDocument_Date; "Document Date")
            {

            }
            column(Quote_No_; "Quote No.")
            {

            }
            column(CountryNameG; CountryNameG)
            {

            }
            column(CompanyAddress1; CompanyInfo.Address)
            {
            }
            column(HasVAT; HasVAT)
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
            column(Shortcut_Dimension_1_Code; GlobalDimension1Desc)
            {
            }
            column(GlobalDimension1Desc; GlobalDimension1Desc)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyLogo; RecDimValues.Logo)//CompanyInfo.Picture)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyHompage; CompanyInfo."Home Page")
            {
            }
            column(CompanyVAT; CompanyInfo."VAT Registration No.")
            {
            }
            column(Company_BankAccNo; CompanyInfo."Bank Account No.")
            {
            }
            column(Company_BankName; CompanyInfo."Bank Name")
            {
            }
            column(Status; Status)
            {

            }
            column(Company_SWIFT; CompanyInfo."SWIFT Code")
            {
            }
            column(Company_IBAN; CompanyInfo.IBAN)
            {
            }
            column(Bill_to_Address; "Bill-to Address")
            {
            }
            column(Bill_to_Address_2; "Bill-to Address 2")
            {
            }
            column(Bill_to_City; "Bill-to City")
            {
            }
            column(Bill_to_Contact; "Bill-to Contact")
            {
            }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code")
            {
            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {
            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {
            }
            column(SalesOrderNo_; "No.")
            {
            }
            column(Your_Reference; "Your Reference")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(IsReleased; IsReleased)
            {

            }
            column(Payment_Terms_Code; PaymentTermsDesc)
            {
            }
            column(AmountInWords; AmountText)
            {
            }
            column(Header_Amount_Including_VAT; "Amount Including VAT")
            {
            }
            column(Currency_Code; CurrencyCode)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending);
                column(SalesLine_No_; "No.")
                {
                }
                column(SLNo; SLNo)
                {
                }
                column(Line_No_; "Line No.")
                {
                }
                column(Description; Description)
                {
                }
                column(VAT_Base_Amount; "VAT Base Amount")
                {
                }
                column(IsComment; IsComment)
                {

                }
                column(Description_2; "Description 2")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Line_Amount_Including_VAT; "Amount Including VAT")
                {
                }
                column(Line_Discount__; "Line Discount %")
                {
                }
                column(Type; Type)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(VAT__; FORMAT(VAT_Pr))
                {
                }
                column(VATPercentage; VAT_Pr)
                {

                }
                column(Inv__Discount_Amount; "Inv. Discount Amount")
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {
                }
                column(VAT_Amount; ("VAT Base Amount" * "VAT %") / 100)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Sline: Record "Sales Line";
                begin
                    IF "Sales Line".Type <> "Sales Line".Type::" " THEN
                        SLNo += 1;

                    if Type = Type::" " then
                        IsComment := true
                    else
                        IsComment := false;

                    Clear(Sline);
                    Sline.SetRange("Document Type", "Document Type");
                    Sline.SetRange("Document No.", "Document No.");
                    Sline.SetFilter("VAT %", '<>%1', 0);
                    if Sline.FindFirst() then
                        VAT_Pr := Sline."VAT %"
                    else
                        VAT_Pr := 0;

                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SLNo := 0;
                    IsComment := false;
                end;

            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Quote));
                column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                RecGlSetup: Record "General Ledger Setup";
                Dimension: Record Dimension;
                RecPT: Record "Payment Terms";
                CountryL: Record "Country/Region";
            begin
                RecGlSetup.GET;
                Clear(RecDimValues);
                Clear(GlobalDimension1Desc);
                RecDimValues.SetRange("Dimension Code", RecGlSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Shortcut Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    GlobalDimension1Desc := RecDimValues.Name;
                end;
                Clear(CurrencyCode);
                if "Sales Header"."Currency Code" <> '' then
                    CurrencyCode := "Sales Header"."Currency Code"
                else
                    CurrencyCode := RecGlSetup."LCY Code";

                Clear(RecPT);
                if RecPT.GET("Payment Terms Code") then begin
                    PaymentTermsDesc := RecPT.Description;
                end;

                if Status = Status::Released then
                    IsReleased := true
                else
                    IsReleased := false;
                CalcFields("Amount Including VAT");
                "Sales Header".CalcFields("Amount Including VAT");
                TotalAmt := "Sales Header"."Amount Including VAT";
                tvar := (ROUND(TotalAmt) MOD 1 * 100);
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray1, tvar, '');
                AmountInWords := AmtInwrdArray1[1];
                IF AmountInWords = '' THEN
                    AmountInWords := 'ZERO';
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, TotalAmt, CurrencyCode);
                AmountInWords2 := AmtInwrdArray2[1];
                AmountText := AmountInWords2 + ' ' + CurrencyCode;//+ ' AND ' + AmountInWords + ' ONLY';

                //Start Ramesh
                // CountryL.SetRange(Code, "Sales Header"."Sell-to Country/Region Code");
                // if CountryL.FindSet() then
                if CountryL.Get("Sales Header"."Sell-to Country/Region Code") then
                    CountryNameG := CountryL."County Name";
                //Stop Ramesh


            end;

            trigger OnPreDataItem()
            begin
                Clear(TotalAmt);
                Clear(tvar);
                Clear(PaymentTermsDesc);
                CompanyInfo.GET;
                CompanyInfo.CalcFields(Picture);
                Users.SetCurrentKey("User Name");
                Users.SetRange("User Name", UserId);
                IF Users.FindFirst() then begin
                    if Users."Full Name" <> '' then
                        UserName := Users."Full Name"
                    else
                        UserName := UserId;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(HasVAT; HasVAT)
                    {
                        ApplicationArea = All;
                        Caption = 'VAT';
                    }
                }
            }
        }
    }


    var
        CompanyInfo: Record "Company Information";
        RecDimValues: Record "Dimension Value";
        Users: Record User;
        UserName: Text;
        SLNo: Integer;
        TotalAmt: Decimal;
        tvar: Decimal;
        ConvertAmountInWord: Codeunit 50150;
        AmountInWords: Text;
        AmountInWords2: Text;
        CountryNameG: Text;

        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
        HasVAT: Boolean;
        CurrencyCode: Text;
        IsComment: Boolean;
        VAT_Pr: Decimal;
        GlobalDimension1Desc: Text;
        PaymentTermsDesc: Text;
        IsReleased: Boolean;
}