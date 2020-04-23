report 50111 "Goods Receipt Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Goods Receipt Note\Goods Receipt Note.rdl';
    Caption = 'Goods Receipt Note';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(CompanyName; CompanyInfo."Long Name")
            {
            }
            column(Company_Name; CompanyInfo.Name)
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
            column(Shortcut_Dimension_1_Code; GlobalDimension1Desc)//"Shortcut Dimension 1 Code")
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
            column(Bill_to_Address; RecVendor.Address)//"Bill-to Address")
            {

            }
            column(Bill_to_Address_2; RecVendor."Address 2")//"Bill-to Address 2")
            {

            }
            column(Bill_to_City; RecVendor.City)//"Bill-to City")
            {

            }
            column(Bill_to_Contact; RecVendor.Contact)//"Bill-to Contact")
            {

            }
            column(Bill_to_Country_Region_Code; VendorCountry)
            {

            }
            column(Bill_to_Post_Code; RecVendor."Post Code")//"Bill-to Post Code")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Order_Date; "Document Date")
            {
            }
            column(Order_No_; "Order No.")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Bill_to_Name; RecVendor.Name)//"Bill-to Name")
            {

            }
            column(Ship_to_Country_Region_Code; ShipToCountry)//"Ship-to Country/Region Code")
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
            column(Vendor_Order_No_; "Vendor Order No.")
            {

            }
            column(LocationName; RecLocation.Name)
            {

            }
            column(locationContact; RecLocation.Contact)
            {

            }
            column(LocationAddress; RecLocation.Address)
            {

            }
            column(LocationAddress2; RecLocation."Address 2")
            {

            }
            column(locationCity; RecLocation.City)
            {

            }
            column(LocationCountry; LocationCountry)// RecLocation."Country/Region Code")
            {

            }
            column(LocationPostcode; RecLocation."Post Code")
            {

            }
            column(LocationPhone; RecLocation."Phone No.")
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
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
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
                column(Unit_Cost; PurchaseLine."Unit Cost")
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
                column(remainingQty; PurchaseLine."Outstanding Quantity")
                {

                }
                column(ReceivedQuantity; Quantity)
                {

                }
                column(PurchQuantity; PurchaseLine.Quantity)
                {

                }
                column(QtyReceived; PurchaseLine."Quantity Received")
                {

                }
                column(Line_Discount__; "Line Discount %")
                {

                }
                column(Type; Type)
                {

                }
                column(IsComment; IsComment)
                {
                }
                column(VAT__; FORMAT("VAT %"))
                {

                }
                column(VATPercentage; "VAT %")
                {

                }
                column(VAT_Amount; ("VAT Base Amount" * "VAT %") / 100)
                {

                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    IF "Purch. Rcpt. Line".Type <> "Purch. Rcpt. Line".Type::" " THEN
                        SLNo += 1;

                    if Type = Type::" " then
                        IsComment := true
                    else
                        IsComment := false;

                    Clear(PurchaseLine);
                    if PurchaseLine.GET(PurchaseLine."Document Type"::Order, "Order No.", "Order Line No.") then;
                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SLNo := 0;
                end;

            }

            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Purch. Rcpt. Header";
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Receipt));
                column(Comment_SalesCommentLine; "Purch. Comment Line".Comment)
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                sales: Page "Sales Order Subform";
                RecGenLedSetup: Record "General Ledger Setup";
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

                Clear(RecCountry);
                Clear(ShipToCountry);
                if RecCountry.GET("Ship-to Country/Region Code") then
                    ShipToCountry := RecCountry.Name;

                Clear(RecVendor);
                IF RecVendor.GET("Buy-from Vendor No.") then begin
                    Clear(RecCountry);
                    Clear(VendorCountry);
                    if RecCountry.GET(RecVendor."Country/Region Code") then
                        VendorCountry := RecCountry.Name;
                end;

                if "Location Code" <> '' then begin
                    if RecLocation.GET("Location Code") then begin
                        Clear(RecCountry);
                        Clear(LocationCountry);
                        if RecCountry.GET(RecLocation."Country/Region Code") then
                            LocationCountry := RecCountry.Name;
                    end;
                end else begin
                    Clear(PurchRcpLine);
                    PurchRcpLine.SetRange("Document No.", "No.");
                    PurchRcpLine.SetFilter("Location Code", '<>%1', '');
                    if PurchRcpLine.FindFirst() then begin
                        if RecLocation.GET(PurchRcpLine."Location Code") then begin
                            Clear(RecCountry);
                            Clear(LocationCountry);
                            if RecCountry.GET(RecLocation."Country/Region Code") then
                                LocationCountry := RecCountry.Name;
                        end;
                    end;
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
                        Visible = false;
                    }
                }
            }
        }
    }


    var
        CompanyInfo: Record "Company Information";
        PurchRcpLine: Record "Purch. Rcpt. Line";
        GlobalDimension1Desc: Text;
        IsComment: Boolean;
        RecDimValues: Record "Dimension Value";
        Users: Record User;
        UserName: Text;
        Bank: Text;
        RecBankAcc: Record "Bank Account";
        SLNo: Integer;
        TotalAmt: Decimal;
        tvar: Decimal;
        PurchaseLine: Record "Purchase Line";
        RecVendor: Record Vendor;
        ConvertAmountInWord: Codeunit 50150;
        AmountInWords: Text;
        AmountInWords2: Text;
        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
        RecLocation: Record Location;

        CompCountry: Text;
        VendorCountry: Text;
        LocationCountry: Text;
        ShipToCountry: Text;
        RecCountry: Record "Country/Region";
}