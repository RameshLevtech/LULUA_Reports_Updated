report 50116 "Sales Invoice Intisar"
{
    DefaultLayout = RDLC;
    Caption = 'Sales Invoice Pre-Prined';
    RDLCLayout = 'Reports\SI -Intisar Pre-printed Stationary\Sales Invoice Intisar.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(SalesOrderNo; "Sales Header"."No.")
            {
            }
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<Year4>'))
            {

            }
            column(AmountInWords; AmountText)
            {

            }
            column(recCust; recCust."Customer ID")
            {

            }
            dataitem(CopyLoop; Integer)
            {

                DataItemTableView = sorting(Number);
                dataitem(PageLoop; Integer)
                {

                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(AddtionalCopyText; AddtionalCopyText)
                    {
                    }
                    column(DocumentCaptionCopyText; StrSubstNo(DocumentCaption, CopyText))
                    {
                    }
                    column(CompanyName; CompanyInfo."Long Name")
                    {
                    }
                    column(CompanyAddress1; CompanyInfo.Address)
                    {
                    }
                    column(SellToCustomerNo; "Sales Header"."Sell-to Customer No.")
                    {

                    }
                    column(SellToCustomerName; "Sales Header"."Sell-to Customer Name")
                    {

                    }
                    column(CompanyAddress2; CompanyInfo."Address 2")
                    {
                    }
                    column(CompanyCity; CompanyInfo.City)
                    {

                    }
                    column(Salesperson_Code; "Sales Header"."Salesperson Code")
                    {

                    }
                    column(UserName; UserName)
                    {

                    }
                    column(Sell_to_Contact; "Sales Header"."Sell-to Contact")
                    {

                    }
                    column(CompanyPostcode; CompanyInfo."Post Code")
                    {

                    }
                    column(CompanyCountry; CompanyInfo."Country/Region Code")
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
                    column(Bill_to_Address; "Sales Header"."Bill-to Address")
                    {

                    }
                    column(Bill_to_Address_2; "Sales Header"."Bill-to Address 2")
                    {

                    }
                    column(Bill_to_City; "Sales Header"."Bill-to City")
                    {

                    }
                    column(BillToVAT; BillToVAT)
                    {

                    }
                    column(Bill_to_Contact; "Sales Header"."Bill-to Contact")
                    {

                    }
                    column(Bill_to_Customer_No_; "Sales Header"."Bill-to Customer No.")
                    {

                    }
                    column(Bill_to_Country_Region_Code; "Sales Header"."Bill-to Country/Region Code")
                    {

                    }
                    column(Bill_to_Post_Code; "Sales Header"."Bill-to Post Code")
                    {

                    }
                    column(Ship_to_Address; "Sales Header"."Ship-to Address")
                    {

                    }
                    column(Ship_to_Address_2; "Sales Header"."Ship-to Address 2")
                    {

                    }
                    column(Ship_to_City; "Sales Header"."Ship-to City")
                    {

                    }
                    column(Ship_to_Name; "Sales Header"."Ship-to Name")
                    {

                    }
                    column(Bill_to_Name; "Sales Header"."Bill-to Name")
                    {

                    }
                    column(Ship_to_Country_Region_Code; "Sales Header"."Ship-to Country/Region Code")
                    {
                    }
                    column(Posting_Date_Formatted; Format("Sales Header"."Posting Date", 0, '<Weekday Text>') + ', ' + Format("Sales Header"."Posting Date", 0, '<Month Text> <Day,2>, <year4>'))
                    {

                    }

                    column(Shortcut_Dimension_1_Code; GlobalDimension1Desc)//"Shortcut Dimension 1 Code")
                    {

                    }
                    column(Ship_to_Post_Code; "Sales Header"."Ship-to Post Code")
                    {
                    }
                    column(SalesOrderNo_; "Sales Header"."No.")
                    {

                    }
                    column(External_Document_No_; "Sales Header"."External Document No.")
                    {

                    }
                    column(Your_Reference; "Sales Header"."Your Reference")
                    {

                    }
                    column(Order_Date; "Sales Header"."Order Date")
                    {

                    }
                    column(Document_Date; "Sales Header"."Document Date")
                    {

                    }
                    column(Payment_Terms_Code; PaymentTermsDesc)//"Payment Terms Code")
                    {

                    }
                    column(Header_Amount_Including_VAT; "Sales Header"."Amount Including VAT")
                    {
                    }
                    column(Currency_Code; CurrencyCode)
                    {
                    }
                    column(Invoice_Discount_Amount; "Sales Header"."Invoice Discount Amount")
                    {

                    }
                    dataitem("Sales Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        column(SalesLine_No_; "Sales Line"."No.")
                        {
                        }
                        column(SLNo; SLNo)
                        {

                        }
                        column(Line_No_; "Sales Line"."Line No.")
                        {

                        }
                        column(Description; LineDescription)//Description)
                        {

                        }
                        column(LimitedEditionValue; LimitedEditionValue)
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
                        column(VAT_Base_Amount; "VAT Base Amount")
                        {
                        }
                        column(VAT_Amount; ("VAT Base Amount" * "VAT %") / 100)
                        {
                        }
                        trigger OnAfterGetRecord()
                        var
                            RecSalesLine: Record "Sales Invoice Line";
                            ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                            RecSalesNRecSetup: Record "Sales & Receivables Setup";
                            RecItemAttValue: Record "Item Attribute Value";
                            ItemAttributeValueSelectionL: Record "Item Attribute Value Selection";
                            ItemAttributeL: Record "Item Attribute";
                            ItemL: Record "Item";
                        begin

                            if ("Sales Line".Type = "Sales Line".Type::Item) AND ("Sales Line"."Parent Item" <> '') then
                                CurrReport.Skip();

                            IF "No." <> '' THEN
                                SLNo += 1;

                            RecSalesNRecSetup.GET;

                            if Type = Type::" " then
                                IsComment := true
                            else
                                IsComment := false;
                            // Clear(LineDescription);
                            // LineDescription := "Sales Line".Description;

                            Clear(LimitedEditionValue);
                            if Type = Type::Item then begin

                                Clear(ItemAttributeValueMapping);
                                ItemAttributeValueMapping.SETRANGE("Table ID", DATABASE::Item);
                                ItemAttributeValueMapping.SETRANGE("No.", "No.");
                                ItemAttributeValueMapping.SETRANGE("Item Attribute ID", RecSalesNRecSetup."Limited Edition Attribute ID");
                                if ItemAttributeValueMapping.FindFirst() then begin
                                    Clear(RecItemAttValue);
                                    RecItemAttValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                                    RecItemAttValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                                    if RecItemAttValue.FindFirst() then begin
                                        LimitedEditionValue := RecItemAttValue.Value;
                                    end;
                                end;
                            end;
                            // if Type = Type::Item then begin
                            //     Clear(ItemAttributeValueMapping);
                            //     ItemAttributeValueMapping.SETRANGE("Table ID", DATABASE::Item);
                            //     ItemAttributeValueMapping.SETRANGE("No.", "No.");
                            //     // ItemAttributeValueMapping.SETRANGE("Item Attribute ID", RecSalesNRecSetup."Limited Edition Attribute ID");
                            //     if ItemAttributeValueMapping.FindSet() then
                            //         repeat
                            //             Clear(RecItemAttValue);
                            //             RecItemAttValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                            //             RecItemAttValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                            //             if RecItemAttValue.FindFirst() then
                            //                 LimitedEditionValue += RecItemAttValue.Value;
                            //         until ItemAttributeValueMapping.Next() = 0
                            // end;


                            Clear(RecSalesLine);
                            RecSalesLine.SetRange("Document No.", "Sales Line"."Document No.");
                            RecSalesLine.SetRange(Type, Type::Item);
                            RecSalesLine.SetRange("Parent Item", "Sales Line"."No.");
                            if RecSalesLine.FindSet() then begin
                                LineDescription := "Sales Line".Description;
                                repeat
                                    LineDescription += ' ' + RecSalesLine.Description;


                                    if LimitedEditionValue = '' then begin

                                        Clear(ItemAttributeValueMapping);
                                        ItemAttributeValueMapping.SETRANGE("Table ID", DATABASE::Item);
                                        ItemAttributeValueMapping.SETRANGE("No.", RecSalesLine."No.");
                                        ItemAttributeValueMapping.SETRANGE("Item Attribute ID", RecSalesNRecSetup."Limited Edition Attribute ID");
                                        if ItemAttributeValueMapping.FindFirst() then begin
                                            Clear(RecItemAttValue);
                                            RecItemAttValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                                            RecItemAttValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                                            if RecItemAttValue.FindFirst() then begin
                                                LimitedEditionValue := RecItemAttValue.Value;
                                            end;
                                        end;

                                    end;
                                until RecSalesLine.Next() = 0;
                            end else
                                LineDescription := Description;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                var
                begin
                    Clear(LineDescription);
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                        AddtionalCopyText := 'Office Copy';
                    end;

                end;


                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                    AddtionalCopyText := 'Client Copy';
                end;
            }



            trigger OnAfterGetRecord()//sales header
            VAR
                RecPT: Record "Payment Terms";
                RecGlSetup: Record "General Ledger Setup";
            begin
                recCust.GET("Sales Header"."Sell-to Customer No.");
                CustAddr[1] := recCust."No.";
                CustAddr[2] := recCust.Name;
                CustAddr[3] := recCust.Address;
                CustAddr[4] := recCust."Address 2";
                CustAddr[5] := recCust.City;
                CustAddr[6] := recCust."Post Code";

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

                Clear(RecPT);
                if RecPT.GET("Payment Terms Code") then
                    PaymentTermsDesc := RecPT.Description;
                Clear(BillToVAT);
                if RecCust.GET("Bill-to Customer No.") then
                    BillToVAT := RecCust."VAT Registration No.";
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
                if CurrencyG."Subsidary Currency" <> '' then
                    AmountInWords2 := AmountInWords2.Replace(CurrencyG."Subsidary Currency", '');
                if (CurrencyG."Currency Fractional Value" > 0) AND (DecimalAmountG > 0) then
                    AmountText := CurrencyCode + ' ' + AmountInWords2 + 'AND ' + Format(DecimalAmountG) + '/' + Format(CurrencyG."Currency Fractional Value") + ' ' + CurrencyG."Subsidary Currency" + '' + ' ONLY'
                else
                    AmountText := CurrencyCode + ' ' + AmountInWords2 + '' + 'ONLY';
            end;

            trigger OnPreDataItem()
            begin
                //FormatAddr.SalesHeaderShipTo(CustAddr,"Sales Header");

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
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                }
            }
        }
        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        FormatAddr.Company(CompanyAddr, CompanyInfo);
    end;

    var
        RecCust: Record Customer;
        Cust: Record Customer;
        CompanyInfo: Record 79;
        FormatAddr: Codeunit 365;
        FormatDocument: Codeunit "Format Document";
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;

        CustAddr: array[8] of Text;
        CompanyAddr: array[8] of Text;
        RecGlSetup: Record "General Ledger Setup";
        Bank: Text;
        LPONo: Text;
        LimitedEditionValue: Text;
        PaymentTermsDesc: Text;
        BillToVAT: Text;
        RecBankAcc: Record "Bank Account";
        RecDimValues: Record "Dimension Value";
        GlobalDimension1Desc: Text;
        Users: Record User;
        IsComment: Boolean;
        UserName: Text;
        SLNo: Integer;
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
        NoOfRows: Integer;
        NoOfRecords: Integer;
        AddtionalCopyText: Text;
        LineDescription: Text;
        Text010: Label 'Sales - Prepayment Invoice %1';
        Text004: Label 'Sales - Invoice %1', Comment = '%1 = Document No.';

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption("Sales Header", DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        if "Sales Header"."Prepayment Invoice" then
            exit(Text010);
        exit(Text004);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesInvoiceHeader: Record "Sales Invoice Header"; var DocCaption: Text)
    begin
    end;
}

