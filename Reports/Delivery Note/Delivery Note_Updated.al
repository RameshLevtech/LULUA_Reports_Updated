report 50103 "Delivery Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Delivery Note\DeliveryNote_Updated.rdl';
    Caption = 'Delivery Note';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(CompanyName; CompanyInfo."Long Name")
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {

            }
            column(CompanyAddress1; CompanyInfo.Address)
            {

            }
            column(ShipmentNo_; "No.")
            {

            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {

            }
            column(CompanyCity; CompanyInfo.City)
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(Shortcut_Dimension_1_Code; GlobalDimension1Desc)//"Shortcut Dimension 1 Code")
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

            column(CompanyEmail; CompanyInfo."E-Mail")
            {

            }
            column(CompanyLogo; RecDimValues.Logo)//.Picture)
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
            column(Bill_to_Address; RecCust.Address)//"Bill-to Address")
            {

            }
            column(Bill_to_Address_2; RecCust."Address 2")//"Bill-to Address 2")
            {

            }
            column(Bill_to_City; RecCust.City)//"Bill-to City")
            {

            }
            column(Bill_to_Contact; RecCust.Contact)//"Bill-to Contact")
            {

            }
            column(Bill_to_Country_Region_Code; RecCust."Country/Region Code")//"Bill-to Country/Region Code")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column(Bill_to_Post_Code; RecCust."Post Code")//"Bill-to Post Code")
            {
            }
            column(Ship_to_Address; DelAddress)//"Ship-to Address")
            {
            }
            column(Ship_to_Address_2; DelAddress2)//"Ship-to Address 2")
            {
            }
            column(Order_Date; Format("Order Date", 0, '<Day,2>-<Month Text,3>-<Year4>'))
            {
            }
            column(Ship_to_City; DelCity)//"Ship-to City")
            {

            }
            column(Ship_to_Name; DelName)//"Ship-to Name")
            {

            }
            column(Bill_to_Name; RecCust.Name)//"Bill-to Name")
            {

            }
            column(Sell_to_Phone_No_; DelPhone)//"Sell-to Phone No.")
            {

            }
            column(Ship_to_Country_Region_Code; DelCountry)//"Ship-to Country/Region Code")
            {

            }
            column(Ship_to_Post_Code; DelZipCode)//"Ship-to Post Code")
            {

            }
            column(SalesOrderNo_; "No.")
            {

            }
            column(Your_Reference; "Your Reference")
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
            column(Currency_Code; "Currency Code")
            {

            }
            column(SalesPersonName; SalesPersonName)
            {

            }
            column(SalesPersonPhone; SalesPersonPhone)
            {

            }
            column(CountryNameG; CountryNameG)
            { }

            dataitem("Sales Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) where(Type = filter(Item));
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
                column(Line_Discount__; "Line Discount %")
                {

                }
                column(IsComment; IsComment)
                {
                }
                column(Unit_of_Measure; "Unit of Measure Code")
                {

                }
                column(Type; Type)
                {

                }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                    "Sales Line".SetFilter(Quantity, '>%1', 0);
                    "Sales Line".SetFilter(Type, '<>%1', Type::"G/L Account");
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
                    Clear(CheckList);
                end;

            }


            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment));
                column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                sales: Page "Sales Order Subform";
                RecGenLedSetup: Record "General Ledger Setup";
                Sheader: Record "Sales Header";
                RecShipToAdd: Record "Ship-to Address";
                RecSalesPerson: Record "Salesperson/Purchaser";
            begin
                RecGenLedSetup.GET;
                Clear(RecDimValues);
                RecDimValues.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Shortcut Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    GlobalDimension1Desc := RecDimValues.Name;
                end;
                if "Sales Header"."Salesperson Code" <> '' then begin
                    if RecSalesPerson.GET("Sales Header"."Salesperson Code") then begin
                        SalesPersonName := RecSalesPerson.Name;
                        SalesPersonPhone := RecSalesPerson."Phone No.";
                    end;
                end;

                Clear(RecBankAcc);
                if RecBankAcc.GET(Bank) then;

                Clear(RecCust);
                IF RecCust.GET("Sell-to Customer No.") then;

                /*   Clear(Sheader);
                   Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
                   Sheader.SetRange("No.", "Order No.");
                   if Sheader.FindFirst() then begin
                       LPOReference := Sheader."Your Reference";
                   end;*/

                if "Sales Header"."Ship-to Code" <> '' then begin
                    Clear(RecShipToAdd);
                    RecShipToAdd.SetRange("Customer No.", "Sales Header"."Bill-to Customer No.");
                    RecShipToAdd.SetRange(Code, "Sales Header"."Ship-to Code");
                    if RecShipToAdd.FindFirst() then begin
                        DelName := RecShipToAdd.Name;
                        DelAddress := RecShipToAdd.Address;
                        DelAddress2 := RecShipToAdd."Address 2";
                        DelCity := RecShipToAdd.City;
                        DelZipCode := RecShipToAdd."Post Code";
                        DelCountry := RecShipToAdd."Country/Region Code";
                        DelPhone := RecShipToAdd."Phone No.";
                    end;
                end else begin
                    DelName := "Sell-to Customer Name";
                    DelAddress := "Sell-to Address";
                    DelAddress2 := "Sell-to Address 2";
                    DelCity := "Sell-to City";
                    DelZipCode := "Sell-to Post Code";
                    DelCountry := "Sell-to Country/Region Code";
                    DelPhone := "Sell-to Phone No.";
                end;

            end;

            trigger OnPreDataItem()
            var
                CountryL: Record "Country/Region";
            begin
                Clear(TotalAmt);
                Clear(tvar);
                CompanyInfo.GET;
                CompanyInfo.CalcFields(Picture);
                if CountryL.Get(CompanyInfo."Country/Region Code") then
                    CountryNameG := CountryL.Name;

                Users.SetCurrentKey("User Name");
                Users.SetRange("User Name", UserId);
                IF Users.FindFirst() then begin
                    if Users."Full Name" <> '' then
                        UserName := Users."Full Name"
                    else
                        UserName := UserId;
                end;
                Clear(DelName);
                Clear(DelAddress2);
                Clear(DelAddress);
                Clear(DelCity);
                Clear(DelZipCode);
                Clear(DelCountry);
                Clear(DelPhone);
            end;
        }
    }

    requestpage
    {
    }


    var
        PageCaptionCap: Label 'Page %1 of %2';
        CompanyInfo: Record "Company Information";
        RecDimValues: Record "Dimension Value";
        IsComment: Boolean;
        GlobalDimension1Desc: Text;
        Users: Record User;
        LPOReference: Text;
        UserName: Text;
        Bank: Text;
        RecBankAcc: Record "Bank Account";
        SLNo: Integer;
        TotalAmt: Decimal;
        tvar: Decimal;
        RecCust: Record Customer;
        ConvertAmountInWord: Codeunit 50150;
        AmountInWords: Text;
        SalesPersonName: Text;
        SalesPersonPhone: Text;
        AmountInWords2: Text;
        CountryNameG: Text;
        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
        CheckList: List of [Text];
        DelName: Text;
        DelAddress: Text;
        DelAddress2: Text;
        DelCity: Text;
        DelCountry: Text;
        DelZipCode: Text;
        DelPhone: Text;
        PrevDocumentNoG: Code[20];

}