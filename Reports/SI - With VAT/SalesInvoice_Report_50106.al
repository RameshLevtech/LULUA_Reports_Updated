report 50106 "Sales Invoice With VAT"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\SI - With VAT\Sales Invoice.rdl';
    Caption = 'Sales Invoice With VAT';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(CompanyName; CompanyInfo."Long Name")
            {
            }
            column(CustomerContact; CustomerG.Contact) { }
            column(CustomerPh; CustomerG."Phone No.") { }
            column(CustomerEmail; CustomerG."E-Mail") { }
            column(CustomerVAT; CustomerG."VAT Registration No.") { }
            column(ChecKFOCIsBoolean; ChecKFOCIsBoolean)
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
            column(BankSortCode; RecBankAcc."Sort Code")
            {

            }
            column(Company_SWIFT; RecBankAcc."SWIFT Code")//CompanyInfo."SWIFT Code")
            {

            }
            column(Company_IBAN; RecBankAcc.IBAN)//CompanyInfo.IBAN)
            {

            }
            column(Bill_to_Address; CustomerG.Address)
            {

            }
            column(Bill_to_Address_2; CustomerG."Address 2")
            {

            }
            column(Bill_to_City; CustomerG.City)
            {

            }
            column(Bill_to_Contact; CustomerG.Contact)
            {

            }
            column(Bill_to_Country_Region_Code; BillToCountry)//"Bill-to Country/Region Code")
            {

            }
            column(Bill_to_Post_Code; CustomerG."Post Code")
            {

            }
            column(Ship_to_Address; AdditionalShipAddr)
            {

            }
            column(Ship_to_Address_2; AdditionalShipAddr1)
            {

            }
            column(Ship_to_City; AdditionalShipCity)
            {

            }
            column(Ship_to_Name; AdditionalShipName)
            {

            }
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Ship_to_Country_Region_Code; ShipToCountry)// "Ship-to Country/Region Code")
            {
            }
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<Year4>'))
            {

            }
            column(Shortcut_Dimension_1_Code; GlobalDimension1Desc)//"Shortcut Dimension 1 Code")
            {

            }
            column(Ship_to_Post_Code; AdditionalShipPost)
            {
            }
            column(AdditionalShipContact; AdditionalShipContact) { }
            column(AdditionalShipPh; AdditionalShipPh) { }
            column(AdditionalShipEmail; AdditionalShipEmail) { }
            column(AdditionalShipVat; AdditionalShipVat) { }
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
            column(Payment_Terms_Code; "Payment Terms Code")
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
            dataitem("Sales Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = SORTING("Document No.", "Line No.");
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
                column(FOCQty; FOCQty)
                {

                }
                column(NormalQty; NormalQty)
                {

                }
                column(Cross_Reference_No_; "Cross-Reference No.")
                {

                }
                column(BarcodeLbl; BarcodeLbl)
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
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(VAT__; FORMAT("VAT %"))
                {
                }
                column(VATPercentage; "VAT %")
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
                column(VAT_Amount; ("VAT Base Amount" * "VAT %") / 100)
                {
                }
                column(VAT_Base_Amount; "VAT Base Amount")
                {

                }
                column(TotalQtySumG; TotalQtySumG) { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    // IF (CheckList.Count = 0) AND ("Sales Line".Type <> "Sales Line".Type::" ") THEN
                    //     SLNo += 1;
                    // if (CheckList.Count = 0) AND ("Sales Line".Type <> "Sales Line".Type::" ") then
                    //     CheckList.Add(FORMAT("Sales Line".Type) + "Sales Line"."No." + "Sales Line".Description);
                    // if CheckList.Count <> 0 then begin
                    //     if not CheckList.Contains(FORMAT("Sales Line".Type) + "Sales Line"."No." + "Sales Line".Description) then begin
                    //         if "Sales Line".Type <> "Sales Line".Type::" " then begin
                    //             SLNo += 1;
                    //             CheckList.Add(FORMAT("Sales Line".Type) + "Sales Line"."No." + "Sales Line".Description);
                    //         end;
                    //     end;
                    // end;
                    if "Sales Line".Type <> "Sales Line".Type::" " then
                        SLNo += 1;

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

                    // if "Sales Line".Type = "Sales Line".Type::Item then
                    //     TotalQtySumG += "Sales Line".Quantity;

                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SLNo := 0;
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


            trigger OnAfterGetRecord()
            var
                SalesInvoiceLineL: Record "Sales Invoice Line";
            begin
                TotalQtySumG := 0;
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

                Clear(CurrencyCode);
                if "Sales Header"."Currency Code" <> '' then
                    CurrencyCode := "Sales Header"."Currency Code"
                else
                    CurrencyCode := RecGlSetup."LCY Code";


                CalcFields("Amount Including VAT");

                "Sales Header".CalcFields("Amount Including VAT");
                TotalAmt := "Sales Header"."Amount Including VAT";
                IntegerAmountG := (TotalAmt DIV 1);
                DecimalAmountG := (ROUND(TotalAmt) MOD 1 * 100);
                ConvertAmountInWord.InitTextVariable;
                ConvertAmountInWord.FormatNoText(AmtInwrdArray2, IntegerAmountG, CurrencyCode);
                AmountInWords2 := AmtInwrdArray2[1];
                AmountInWords2 := CopyStr(AmountInWords2, 1, StrPos(AmountInWords2, 'ONLY') - 2);
                if CurrencyG.Get(CurrencyCode) then;
                //AmountInWords2 := DelChr(AmountInWords2, '=', CurrencyG."Subsidary Currency");
                if CurrencyG."Subsidary Currency" <> '' then
                    AmountInWords2 := AmountInWords2.Replace(CurrencyG."Subsidary Currency", '');
                if (CurrencyG."Currency Fractional Value" > 0) AND (DecimalAmountG > 0) then
                    AmountText := CurrencyCode + ' ' + AmountInWords2 + 'AND ' + Format(DecimalAmountG) + '/' + Format(CurrencyG."Currency Fractional Value") + ' ' + CurrencyG."Subsidary Currency" + '' + ' ONLY'
                else
                    AmountText := CurrencyCode + ' ' + AmountInWords2 + '' + 'ONLY';



                If CustomerG.Get("Sales Header"."Sell-to Customer No.") then;

                if "Sales Header"."Ship-to Code" <> '' then begin
                    AdditionalShipName := "Sales Header"."Ship-to Name";
                    AdditionalShipAddr := "Sales Header"."Ship-to Address";
                    AdditionalShipAddr1 := "Sales Header"."Ship-to Address 2";
                    AdditionalShipCity := "Sales Header"."Ship-to City";
                    AdditionalShipPost := "Sales Header"."Ship-to Post Code";
                    AdditionalShipCountry := "Sales Header"."Ship-to Country/Region Code";
                    AdditionalShipContact := "Sales Header"."Ship-to Contact";
                end else begin
                    AdditionalShipName := CustomerG.Name;
                    AdditionalShipAddr := CustomerG.Address;
                    AdditionalShipAddr1 := CustomerG."Address 2";
                    AdditionalShipCity := CustomerG.City;
                    AdditionalShipPost := CustomerG."Post Code";
                    AdditionalShipCountry := CustomerG."Country/Region Code";
                    AdditionalShipPh := CustomerG."Phone No.";
                    AdditionalShipContact := CustomerG.Contact;
                    AdditionalShipEmail := CustomerG."E-Mail";
                    AdditionalShipVat := CustomerG."VAT Registration No.";
                end;
                Clear(RecCountry);
                Clear(ShipToCountry);
                if RecCountry.GET(AdditionalShipCountry) then
                    ShipToCountry := RecCountry.Name;

                Clear(RecCountry);
                Clear(BillToCountry);
                if RecCountry.GET(CustomerG."Country/Region Code") then
                    BillToCountry := RecCountry.Name;

                SalesInvoiceLineL.SetRange("Document No.", "Sales Header"."No.");
                SalesInvoiceLineL.SetRange("FOC Sales", true);
                ChecKFOCIsBoolean := not SalesInvoiceLineL.IsEmpty;

                SalesInvoiceLineL.SetRange("FOC Sales", false);
                SalesInvoiceLineL.SetRange(Type, SalesInvoiceLineL.Type::Item);
                if SalesInvoiceLineL.FindSet() then
                    repeat
                        TotalQtySumG += SalesInvoiceLineL.Quantity;
                    until SalesInvoiceLineL.Next() = 0;
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
        ChecKFOCIsBoolean: Boolean;
        ShiptoAddrG: Record "Ship-to Address";
        CustomerG: Record Customer;
        CompanyInfo: Record "Company Information";
        RecGlSetup: Record "General Ledger Setup";
        Bank: Text;
        AdditionalShipName: Text;
        AdditionalShipAddr: Text;
        AdditionalShipAddr1: Text;
        AdditionalShipCity: Text;
        AdditionalShipPost: Text;
        AdditionalShipCountry: Text;
        AdditionalShipPh: Text;
        AdditionalShipContact: Text;
        AdditionalShipEmail: Text;
        AdditionalShipVat: Text;

        FOCQty: Decimal;
        NormalQty: Decimal;
        RecBankAcc: Record "Bank Account";
        RecDimValues: Record "Dimension Value";
        GlobalDimension1Desc: Text;
        Users: Record User;
        IsComment: Boolean;
        UserName: Text;
        SLNo: Integer;
        TotalQtySumG: Integer;
        DecimalAmountG: Decimal;
        IntegerAmountG: Integer;
        CurrencyG: Record Currency;
        TotalAmt: Decimal;
        tvar: Decimal;
        ConvertAmountInWord: Codeunit 50150;
        AmountInWords: Text;
        AmountInWords2: Text;
        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
        CurrencyCode: Text;
        BarcodeLbl: Label 'Barcode';
        CompCountry: Text;
        BillToCountry: Text;
        ShipToCountry: Text;
        RecCountry: Record "Country/Region";
        CheckList: List of [Text];

}