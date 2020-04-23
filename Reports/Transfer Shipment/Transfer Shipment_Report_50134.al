report 50114 "Transfer Shipment Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Transfer Shipment\Transfer Shipment.rdl';
    Caption = 'Posted Transfer Shipment';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Posting Date";
            column(CompanyName; CompanyInfo."Long Name")
            {
            }
            column(Transfer_to_Address; "Transfer-to Address")
            {
            }
            column(Transfer_to_Address_2; "Transfer-to Address 2")
            {

            }
            column(Transfer_to_City; "Transfer-to City")
            {

            }
            column(Transfer_to_Code; "Transfer-to Code")
            {

            }
            column(Transfer_to_Contact; "Transfer-to Contact")
            {

            }
            column(Transfer_to_County; "Transfer-to County")
            {

            }
            column(Transfer_to_Name; "Transfer-to Name")
            {

            }
            column(Transfer_to_Name_2; "Transfer-to Name 2")
            {

            }
            column(Transfer_to_Post_Code; "Transfer-to Post Code")
            {

            }
            column(Trsf__to_Country_Region_Code; "Trsf.-to Country/Region Code")
            {

            }
            column(Trsf__from_Country_Region_Code; "Trsf.-from Country/Region Code")
            {

            }
            column(Transfer_from_Address; "Transfer-from Address")
            {
            }
            column(Receipt_Date; "Receipt Date")
            {

            }
            column(Transfer_from_Address_2; "Transfer-from Address 2")
            {
            }
            column(Transfer_from_City; "Transfer-from City")
            {
            }
            column(Transfer_from_Code; "Transfer-from Code")
            {

            }
            column(Transfer_from_Contact; "Transfer-from Contact")
            {

            }
            column(Transfer_from_County; "Transfer-from County")
            {

            }
            column(Transfer_from_Name; "Transfer-from Name")
            {

            }
            column(Transfer_from_Name_2; "Transfer-from Name 2")
            {

            }
            column(Transfer_from_Post_Code; "Transfer-from Post Code")
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
            column(Posting_Date; "Posting Date")
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
            column(CompanyPhone; 'T: ' + CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoFaxNo; 'F: ' + CompanyInfo."Fax No.")
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
            column(Order_No_; "No.")
            {

            }
            column(Bill_to_Post_Code; RecCust."Post Code")//"Bill-to Post Code")
            {
            }

            column(Bill_to_Name; RecCust.Name)//"Bill-to Name")
            {

            }
            column(SalesOrderNo_; "No.")
            {

            }

            column(AmountInWords; AmountText)
            {

            }

            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);

                column(SLNo; SLNo)
                {

                }
                column(SalesLine_No_; "Item No.")
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

                column(IsComment; IsComment)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }



                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                    IF "Transfer Shipment Line"."Item No." <> '' THEN
                        SLNo += 1;

                    IsComment := false;
                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SLNo := 0;
                end;

            }


            dataitem("Inventory Comment Line"; "Inventory Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Transfer Shipment Header";
                DataItemTableView = SORTING("Document Type", "No.", "Line No.") WHERE("Document Type" = CONST("Posted Transfer Shipment"));
                column(Comment_SalesCommentLine; "Inventory Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                sales: Page "Sales Order Subform";
                RecGenLedSetup: Record "General Ledger Setup";
                Sheader: Record "Sales Header";
            begin
                RecGenLedSetup.GET;
                Clear(RecDimValues);
                RecDimValues.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Shortcut Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    GlobalDimension1Desc := RecDimValues.Name;
                end;

                Clear(RecBankAcc);
                if RecBankAcc.GET(Bank) then;
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
        RecLocation: Record Location;
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
        AmtInwrdArray1: array[2] of Text;
        AmtInwrdArray2: array[2] of Text;
        AmountText: Text;
}