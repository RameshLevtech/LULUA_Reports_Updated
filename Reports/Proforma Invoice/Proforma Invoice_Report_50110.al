report 50110 "Proforma Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Proforma Invoice\Proforma Invoice.rdl';
    Caption = 'Proforma Invoice';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(CompanyName; CompanyInfo."Long Name")
            {
            }
            column(CountryNameG; CountryNameG)
            {

            }
            column(BillToCountryNameG; BillToCountryNameG)
            {

            }
            column(CompanyAddress1; CompanyInfo.Address)
            {
            }
            column(Sell_to_Contact_No_; "Sell-to Contact No.")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_Contact; "Sell-to Contact")
            {

            }
            column(Sell_to_Address; "Sell-to Address")
            {

            }
            column(Sell_to_Address_2; "Sell-to Address 2")
            {
            }
            column(Sell_to_City; "Sell-to City")
            {
            }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {
            }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            {
            }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
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
            column(Company_BankAccNo; RecBankAcc."Bank Account No.")//CompanyInfo."Bank Account No.")
            {

            }
            column(Company_BankName; RecBankAcc.Name)//CompanyInfo."Bank Name")
            {

            }
            column(BankSortCode; RecBankAcc."Bank Clearing Code")
            {

            }
            column(Company_SWIFT; RecBankAcc."SWIFT Code")//CompanyInfo."SWIFT Code")
            {

            }
            column(Company_IBAN; RecBankAcc.IBAN)//CompanyInfo.IBAN)
            {
            }
            column(Status; Status)
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
            column(Bill_to_Contact_Number; "Bill-to Contact Number")
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
            column(Ship_to_Contact; "Ship-to Contact")
            {
            }
            column(Ship_to_Contact_Number; "Ship-to Contact Number")
            {

            }
            column(ContactPerson; RecContact.Name)
            {
            }
            column(ContactTel; RecContact."Phone No.")
            {
            }
            column(CustomerBillToPhoneG; CustomerBillToG."Phone No.")
            {

            }
            column(Bill_to_ContactName; "Bill-to Contact")
            {

            }
            column(External_Document_No_; "External Document No.")
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
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(VAT__; FORMAT("VAT %"))
                {
                }
                column(VATPercentage; "VAT %")
                {

                }
                column(Inv__Discount_Amount; "Inv. Discount Amount")
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {
                }
                //column(VAT_Amount; ("VAT Base Amount" * "VAT %") / 100)
                column(VAT_Amount; "Amount Including VAT" - Amount)
                {
                }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    IF (CheckList.Count = 0) AND ("Sales Line".Type <> "Sales Line".Type::" ") THEN
                        SLNo += 1;
                    if (CheckList.Count = 0) AND ("Sales Line".Type <> "Sales Line".Type::" ") then
                        CheckList.Add(FORMAT("Sales Line".Type) + "Sales Line"."No." + "Sales Line".Description);
                    if CheckList.Count <> 0 then begin
                        if not CheckList.Contains(FORMAT("Sales Line".Type) + "Sales Line"."No." + "Sales Line".Description) then begin
                            if "Sales Line".Type <> "Sales Line".Type::" " then begin
                                SLNo += 1;
                                CheckList.Add(FORMAT("Sales Line".Type) + "Sales Line"."No." + "Sales Line".Description);
                            end;
                        end;
                    end;

                    if Type = Type::" " then
                        IsComment := true
                    else
                        IsComment := false;
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
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.");
                column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                RecGenLedSetup: Record "General Ledger Setup";
                // Dimension: Record Dimension;
                RecPT: Record "Payment Terms";
                CountryL: Record "Country/Region";
            begin
                RecGenLedSetup.GET;
                Clear(RecDimValues);
                Clear(GlobalDimension1Desc);
                RecDimValues.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Shortcut Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    GlobalDimension1Desc := RecDimValues.Name;
                end;

                Clear(RecBankAcc);
                if RecBankAcc.GET(Bank) then;


                Clear(CurrencyCode);
                if "Sales Header"."Currency Code" <> '' then
                    CurrencyCode := "Sales Header"."Currency Code"
                else
                    CurrencyCode := RecGenLedSetup."LCY Code";
                Clear(RecContact);
                if RecContact.GET("Sell-to Contact No.") then;

                // Clear(Dimension);
                // IF Dimension.GET("Shortcut Dimension 1 Code") THEN BEGIN
                //     GlobalDimension1Desc := Dimension.Name;
                // END;

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
                ConvertAmountInWord.FormatNoText(AmtInwrdArray1, tvar, CurrencyCode);
                AmountInWords := AmtInwrdArray1[1];
                IF AmountInWords = '' THEN
                    AmountInWords := 'ZERO';
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, TotalAmt, CurrencyCode);
                AmountInWords2 := AmtInwrdArray2[1];
                AmountText := CurrencyCode + ' ' + AmountInWords2;//+ ' AND ' + AmountInWords + ' ONLY';

                //Start Ramesh
                // CountryL.SetRange(Code, "Sales Header"."Sell-to Country/Region Code");
                // if CountryL.FindSet() then
                if CountryL.Get("Sales Header"."Sell-to Country/Region Code") then
                    CountryNameG := CountryL."County Name";

                if CustomerBillToG.Get("Sales Header"."Bill-to Customer No.") then;
                if CountryL.Get("Sales Header"."Bill-to Country/Region Code") then
                    BillToCountryNameG := CountryL."County Name";
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
                    field(Bank; Bank)
                    {
                        ApplicationArea = All;
                        TableRelation = "Bank Account"."No.";
                    }
                }
            }
        }
    }


    var
        CompanyInfo: Record "Company Information";
        Users: Record User;
        CustomerBillToG: Record Customer;

        RecDimValues: Record "Dimension Value";
        RecBankAcc: Record "Bank Account";
        UserName: Text;
        BillToContactG: Record Contact;
        CheckList: List of [Text];
        SLNo: Integer;
        TotalAmt: Decimal;
        Bank: Text;
        CountryNameG: Text;
        BillToCountryNameG: Text;
        tvar: Decimal;
        RecContact: Record Contact;
        ConvertAmountInWord: Codeunit 50150;
        AmountInWords: Text;
        AmountInWords2: Text;
        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
        HasVAT: Boolean;
        CurrencyCode: Text;
        IsComment: Boolean;
        GlobalDimension1Desc: Text;
        PaymentTermsDesc: Text;
        IsReleased: Boolean;
}