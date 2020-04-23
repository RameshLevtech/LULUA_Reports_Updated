// report 50102 "Sales Credit Note"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = 'Reports\Credit Note\Credit Note.rdl';
//     Caption = 'Sales Credit Note';
//     PreviewMode = PrintLayout;
//     ApplicationArea = All;
//     UsageCategory = ReportsAndAnalysis;

//     dataset
//     {
//         dataitem("Sales Header"; "Sales Cr.Memo Header")
//         {
//             DataItemTableView = SORTING("No.")
//                                 ORDER(Ascending);
//             RequestFilterFields = "No.", "Sell-to Customer No.";
//             column(CompanyName; CompanyInfo."Long Name")
//             {
//             }
//             column(CompanyAddress1; CompanyInfo.Address)
//             {

//             }
//             column(CompanyAddress2; CompanyInfo."Address 2")
//             {

//             }
//             column(CompanyCity; CompanyInfo.City)
//             {

//             }
//             column(Shortcut_Dimension_1_Code; GlobalDimension1Desc)//"Shortcut Dimension 1 Code")
//             {

//             }
//             column(UserName; UserName)
//             {

//             }
//             column(CompanyPostcode; CompanyInfo."Post Code")
//             {

//             }
//             column(CompanyCountry; CompanyInfo."Country/Region Code")
//             {

//             }
//             column(CompanyEmail; CompanyInfo."E-Mail")
//             {

//             }
//             column(CompanyLogo; RecDimValues.Logo)//.Picture)
//             {

//             }
//             column(CompanyPhone; CompanyInfo."Phone No.")
//             {

//             }
//             column(CompanyHompage; CompanyInfo."Home Page")
//             {

//             }
//             column(CompanyVAT; CompanyInfo."VAT Registration No.")
//             {

//             }
//             column(Company_BankAccNo; RecBankAcc."Bank Account No.")//CompanyInfo."Bank Account No.")
//             {

//             }
//             column(Company_BankName; RecBankAcc.Name)//CompanyInfo."Bank Name")
//             {

//             }
//             column(BankSortCode; RecBankAcc."Bank Clearing Code")
//             {

//             }
//             column(Company_SWIFT; RecBankAcc."SWIFT Code")//CompanyInfo."SWIFT Code")
//             {

//             }
//             column(Company_IBAN; RecBankAcc.IBAN)//CompanyInfo.IBAN)
//             {

//             }
//             column(Bill_to_Address; RecCust.Address)//"Bill-to Address")
//             {

//             }
//             column(Bill_to_Address_2; RecCust."Address 2")//"Bill-to Address 2")
//             {

//             }
//             column(Bill_to_City; RecCust.City)//"Bill-to City")
//             {

//             }
//             column(Bill_to_Contact; RecCust.Contact)//"Bill-to Contact")
//             {

//             }
//             column(Bill_to_Country_Region_Code; RecCust."Country/Region Code")//"Bill-to Country/Region Code")
//             {

//             }
//             column(Bill_to_Post_Code; RecCust."Post Code")//"Bill-to Post Code")
//             {
//             }
//             column(Ship_to_Address; "Ship-to Address")
//             {
//             }
//             column(Ship_to_Address_2; "Ship-to Address 2")
//             {
//             }
//             column(Order_Date; "Document Date")
//             {
//             }
//             column(Ship_to_City; "Ship-to City")
//             {

//             }
//             column(Ship_to_Name; "Ship-to Name")
//             {

//             }
//             column(Bill_to_Name; RecCust.Name)//"Bill-to Name")
//             {

//             }
//             column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
//             {

//             }
//             column(Ship_to_Post_Code; "Ship-to Post Code")
//             {

//             }
//             column(SalesOrderNo_; "No.")
//             {

//             }
//             column(Your_Reference; "Your Reference")
//             {

//             }

//             column(Document_Date; "Document Date")
//             {

//             }
//             column(Payment_Terms_Code; "Payment Terms Code")
//             {

//             }
//             column(AmountInWords; AmountText)
//             {

//             }
//             column(Header_Amount_Including_VAT; "Amount Including VAT")
//             {

//             }
//             column(Currency_Code; "Currency Code")
//             {

//             }
//             dataitem("Sales Line"; "Sales Cr.Memo Line")
//             {
//                 DataItemLink = "Document No." = FIELD("No.");
//                 DataItemTableView = SORTING("Document No.", "Line No.")
//                                     ORDER(Ascending);
//                 column(SalesLine_No_; "No.")
//                 {
//                 }
//                 column(SLNo; SLNo)
//                 {

//                 }
//                 column(Line_No_; "Line No.")
//                 {

//                 }
//                 column(Description; Description)
//                 {

//                 }
//                 column(Description_2; "Description 2")
//                 {

//                 }
//                 column(Quantity; Quantity)
//                 {

//                 }
//                 column(Line_Amount_Including_VAT; "Amount Including VAT")
//                 {

//                 }
//                 column(Line_Discount__; "Line Discount %")
//                 {

//                 }
//                 column(Type; Type)
//                 {

//                 }
//                 column(IsComment; IsComment)
//                 {
//                 }
//                 column(Unit_Price; "Unit Price")
//                 {

//                 }
//                 column(VAT__; FORMAT("VAT %"))
//                 {

//                 }
//                 column(VATPercentage; "VAT %")
//                 {

//                 }
//                 column(Inv__Discount_Amount; "Inv. Discount Amount")
//                 {

//                 }
//                 column(Line_Discount_Amount; "Line Discount Amount")
//                 {

//                 }
//                 column(VAT_Amount; ("VAT Base Amount" * "VAT %") / 100)
//                 {

//                 }
//                 trigger OnAfterGetRecord()
//                 var
//                     myInt: Integer;
//                 begin
//                     IF "Sales Line".Type <> "Sales Line".Type::" " THEN
//                         SLNo += 1;

//                     if Type = Type::" " then
//                         IsComment := true
//                     else
//                         IsComment := false;
//                 end;

//                 trigger OnPreDataItem()
//                 var
//                     myInt: Integer;
//                 begin
//                     SLNo := 0;
//                 end;

//             }
//             dataitem("Sales Comment Line"; "Sales Comment Line")
//             {
//                 DataItemLink = "No." = FIELD("No.");
//                 DataItemLinkReference = "Sales Header";
//                 DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Credit Memo"));
//                 column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
//                 {
//                 }
//             }


//             trigger OnAfterGetRecord()
//             var
//                 myInt: Integer;
//                 sales: Page "Sales Order Subform";
//                 RecGenLedSetup: Record "General Ledger Setup";
//             begin
//                 Clear(RecDimValues);
//                 Clear(GlobalDimension1Desc);
//                 RecDimValues.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 1 Code");
//                 RecDimValues.SetRange(Code, "Shortcut Dimension 1 Code");
//                 if RecDimValues.FindFirst() then begin
//                     RecDimValues.CalcFields(Logo);
//                     GlobalDimension1Desc := RecDimValues.Name;
//                 end;

//                 CalcFields("Amount Including VAT");

//                 Clear(RecBankAcc);
//                 if RecBankAcc.GET(Bank) then;

//                 Clear(RecCust);
//                 IF RecCust.GET("Sell-to Customer No.") then;
//                 "Sales Header".CalcFields("Amount Including VAT");
//                 TotalAmt := "Sales Header"."Amount Including VAT";
//                 tvar := (ROUND(TotalAmt) MOD 1 * 100);
//                 ConvertAmountInWord.InitTextVariable;
//                 ConvertAmountInWord.FormatNoText(AmtInwrdArray1, tvar, '');
//                 AmountInWords := AmtInwrdArray1[1];
//                 IF AmountInWords = '' THEN
//                     AmountInWords := 'ZERO';
//                 ConvertAmountInWord.InitTextVariable;
//                 ConvertAmountInWord.FormatNoText(AmtInwrdArray2, TotalAmt, '');
//                 AmountInWords2 := AmtInwrdArray2[1];
//                 //AmountText1 := Text + ' ' + CurrCode + ' AND ' + AmtInwrdArray2 + ' ' + DecimalDec + ' ONLY';
//                 AmountText := "Sales Header"."Currency Code" + AmountInWords2;//+ ' AND ' + AmountInWords + ' ONLY';


//             end;

//             trigger OnPreDataItem()
//             var

//             begin
//                 Clear(TotalAmt);
//                 Clear(tvar);
//                 CompanyInfo.GET;
//                 CompanyInfo.CalcFields(Picture);

//                 Users.SetCurrentKey("User Name");
//                 Users.SetRange("User Name", UserId);
//                 IF Users.FindFirst() then begin
//                     if Users."Full Name" <> '' then
//                         UserName := Users."Full Name"
//                     else
//                         UserName := UserId;
//                 end;


//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(General)
//                 {
//                     field(Bank; Bank)
//                     {
//                         ApplicationArea = All;
//                         TableRelation = "Bank Account"."No.";
//                     }
//                 }
//             }
//         }
//     }


//     var
//         CompanyInfo: Record "Company Information";
//         GlobalDimension1Desc: Text;
//         IsComment: Boolean;
//         RecDimValues: Record "Dimension Value";
//         Users: Record User;
//         UserName: Text;
//         Bank: Text;
//         RecBankAcc: Record "Bank Account";
//         SLNo: Integer;
//         TotalAmt: Decimal;
//         tvar: Decimal;
//         RecCust: Record Customer;
//         ConvertAmountInWord: Codeunit 50150;
//         AmountInWords: Text;
//         AmountInWords2: Text;
//         AmtInwrdArray1: array[2] of Text;
//         AmtInwrdArray2: array[2] of Text;
//         AmountText: Text;
// }