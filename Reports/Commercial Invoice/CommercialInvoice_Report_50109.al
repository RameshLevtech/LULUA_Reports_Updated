report 50109 "Commercial Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Commercial Invoice\Commercial Invoice.rdl';
    Caption = 'Commercial Invoice';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(CompanyName; CompanyInfo."Long Name")//Name)
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
            column(CompanyCountry; CompCountry)//CompanyInfo."Country/Region Code")
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
            column(Bill_to_Country_Region_Code; BillToCountry)//"Bill-to Country/Region Code")
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
            column(Ship_to_Country_Region_Code; ShipToCountry)//"Ship-to Country/Region Code")
            {
            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Shortcut_Dimension_1_Code; GlobalDimension1Desc)//"Shortcut Dimension 1 Code")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {
            }
            column(SalesOrderNo_; "No.")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column(External_Document_No_; "External Document No.")
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
            column(Payment_Terms_Code; PaymentTermsDesc)//"Payment Terms Code")
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
            column(SubCurrCode; SubCurrCode) { }
            dataitem("Sales Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
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
                column(VAT__; FORMAT("VAT %"))
                {
                }
                column(VatPercentage; "VAT %")
                {

                }
                column(IsComment; IsComment)
                {
                }
                column(Inv__Discount_Amount; "Inv. Discount Amount")
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {
                }
                column(IsFOC; "FOC Sales")
                {
                }
                column(FOCQty; FOCQty)
                {

                }
                column(NormalQty; NormalQty)
                {

                }
                column(VAT_Amount; ("VAT Base Amount" * "VAT %") / 100)
                {
                }
                column(VendorNo; RecItem."Vendor No.")
                {
                }
                column(Vendors; Vendors)
                {
                }
                column(TariffNo; RecItem."Tariff No.")
                {
                }
                column(CountryFromItem; ItemCountry)//RecItem."Country/Region of Origin Code")
                {
                }

                trigger OnAfterGetRecord()
                var
                    XRec: Record "Sales Invoice Line";
                //SerialNo2: Integer;
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
                    Clear(FOCQty);
                    Clear(NormalQty);
                    if "FOC Sales" then
                        FOCQty := Quantity
                    else
                        NormalQty := Quantity;

                    Clear(RecItem);
                    Clear(ItemCountry);
                    if (Type = Type::Item) AND ("No." <> '') then begin
                        if RecItem.GET("No.") then;

                        if RecItem."Vendor No." <> '' then begin
                            if not VendorList.Contains(RecItem."Vendor No.") then begin
                                VendorList.Add(RecItem."Vendor No.");
                                Vendors += RecItem."Vendor No." + '|';
                            end;
                            Clear(RecCountry);
                            if RecCountry.GET(RecItem."Country/Region of Origin Code") then
                                ItemCountry := RecCountry.Name;
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SLNo := 0;
                    Clear(CheckList);
                end;

            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"));
                column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                {
                }
            }
            dataitem(Vendor; Vendor)
            {
                //DataItemTableView = sorting("No.") order(ascending);
                DataItemLinkReference = "Sales Header";
                column(VendorNo_; Vendor."No.")
                {
                }
                column(VendorName; Vendor.Name)
                {
                }
                column(VendorAddress; Vendor.Address)
                {
                }
                column(VendorAddress_2; Vendor."Address 2")
                {

                }
                column(VendorCity; Vendor.City)
                {
                }
                column(VendorPost_Code; Vendor."Post Code")
                {
                }
                column(VSLNo; VSLNo)
                {

                }
                column(VendorCountry_Region_Code; CountryName)//Vendor."Country/Region Code")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    VSLNo += 1;
                    Clear(RecCountry);
                    Clear(CountryName);
                    if RecCountry.GET(Vendor."Country/Region Code") then
                        CountryName := RecCountry.Name;
                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    if Vendors <> '' then begin
                        Vendors := CopyStr(Vendors, 1, StrLen(Vendors) - 1);
                        SetFilter("No.", Vendors);
                        VSLNo := 0;
                    end else
                        SetFilter("No.", '=%1', '');
                end;
            }


            trigger OnAfterGetRecord()
            var
                RecPT: Record "Payment Terms";
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
                Clear(RecBankAcc);
                if RecBankAcc.GET(Bank) then;

                Clear(PaymentTermsDesc);
                Clear(RecPT);
                if RecPT.GET("Payment Terms Code") then begin
                    PaymentTermsDesc := RecPT.Description;
                end;
                Clear(CurrencyCode);
                if "Sales Header"."Currency Code" <> '' then
                    CurrencyCode := "Sales Header"."Currency Code"
                else
                    CurrencyCode := RecGlSetup."LCY Code";

                CalcFields("Amount Including VAT");

                "Sales Header".CalcFields("Amount Including VAT");
                TotalAmt := "Sales Header"."Amount Including VAT";
                tvar := (ROUND(TotalAmt) MOD 1 * 100);
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray1, tvar, "Sales Header"."Currency Code");
                AmountInWords := AmtInwrdArray1[1];
                IF AmountInWords = '' THEN
                    AmountInWords := 'ZERO';
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, TotalAmt, "Sales Header"."Currency Code");
                AmountInWords2 := AmtInwrdArray2[1];
                AmountText := "Sales Header"."Currency Code" + ' ' + AmountInWords2;

                Clear(RecCountry);
                Clear(ShipToCountry);
                if RecCountry.GET("Ship-to Country/Region Code") then
                    ShipToCountry := RecCountry.Name;

                Clear(RecCountry);
                Clear(BillToCountry);
                if RecCountry.GET("Bill-to Country/Region Code") then
                    BillToCountry := RecCountry.Name;
            end;

            trigger OnPreDataItem()
            var

            begin
                Clear(TotalAmt);
                Clear(tvar);
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
                Clear(RecCountry);
                Clear(CompCountry);
                if RecCountry.GET(CompanyInfo."Country/Region Code") then
                    CompCountry := RecCountry.Name;

            end;
        }
    }

    requestpage
    {
    }


    var
        CurrencyG: Record Currency;
        CheckList: List of [Text];
        CompanyInfo: Record "Company Information";
        RecGlSetup: Record "General Ledger Setup";
        FOCQty: Decimal;
        NormalQty: Decimal;
        RecItem: Record Item;
        Bank: Text;
        RecBankAcc: Record "Bank Account";
        RecDimValues: Record "Dimension Value";
        GlobalDimension1Desc: Text;
        Users: Record User;
        IsComment: Boolean;
        UserName: Text;
        SLNo: Integer;
        TotalAmt: Decimal;
        tvar: Decimal;
        ConvertAmountInWord: Codeunit 50150;
        AmountInWords: Text;
        AmountInWords2: Text;
        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
        CurrencyCode: Text;
        VendorList: List of [Text];
        Vendors: Text;
        VSLNo: Integer;
        SubCurrCode: Code[20];
        RecCountry: Record "Country/Region";
        CountryName: Text;
        ItemCountry: Text;
        CompCountry: Text;
        BillToCountry: Text;
        ShipToCountry: Text;
        PaymentTermsDesc: Text;

}