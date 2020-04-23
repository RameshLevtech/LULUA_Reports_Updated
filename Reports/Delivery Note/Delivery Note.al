report 50103 "Delivery Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Delivery Note\DeliveryNote.rdl';
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
            column(CompanyAddress2; CompanyInfo."Address 2")
            {

            }
            column(CompanyCity; CompanyInfo.City)
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(LPOReference; LPOReference)
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
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Bill_to_Name; RecCust.Name)//"Bill-to Name")
            {

            }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
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
            column(CountryNameG; CountryNameG)
            { }

            dataitem("Sales Line"; "Sales Shipment Line")
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
                column(Line_Discount__; "Line Discount %")
                {

                }
                column(IsComment; IsComment)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
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
                column(VAT_Amount; ("VAT Base Amount" * "VAT %") / 100)
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
                CountryL: Record "Country/Region";

            begin
                RecGenLedSetup.GET;
                Clear(RecDimValues);
                RecDimValues.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Shortcut Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    GlobalDimension1Desc := RecDimValues.Name;
                end;

                //Start Ramesh
                // CountryL.SetRange(Code, "Sales Header"."Sell-to Country/Region Code");
                // if CountryL.FindSet() then
                if CountryL.Get("Sales Header"."Sell-to Country/Region Code") then
                    CountryNameG := CountryL."County Name";
                //Stop Ramesh


                Clear(RecBankAcc);
                if RecBankAcc.GET(Bank) then;

                Clear(RecCust);
                IF RecCust.GET("Sell-to Customer No.") then;

                Clear(Sheader);
                Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
                Sheader.SetRange("No.", "Order No.");
                if Sheader.FindFirst() then begin
                    LPOReference := Sheader."Your Reference";
                end;


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


            end;
        }
    }

    requestpage
    {
    }


    var
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
        AmountInWords2: Text;
        CountryNameG: Text;
        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
        CheckList: List of [Text];

}