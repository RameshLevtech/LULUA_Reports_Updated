report 50118 JournalVoucher
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\GeneralVoucherGL_LT\GeneralVoucherGL_LT.rdl';
    Caption = 'Journal Voucher';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                ORDER(Ascending);
            RequestFilterFields = "Document No.";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Dimension; DimensionValueNameG)
            { }
            column(CompanyName; CompanyInfo."Long Name")
            {
            }
            column(CompanyAddress1; CompanyInfo.Address)
            {

            }
            column(CompanyPostcode; CompanyInfo."Post Code")
            {

            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {

            }
            column(CountryNameG; CountryNameG)
            { }
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

            column(CompanyAddress2; CompanyInfo."Address 2")
            {

            }
            column(CompanyCity; CompanyInfo.City)
            {

            }


            column(CompanyTelAndFax; CompanyTelAndFax)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(CompanyInfoHomPage; CompanyInfo."Home Page")
            {

            }
            column(CompanyInfo_Name2; CompanyInfo."Name 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(UserName; UserName)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyDisplayName; CompanyInfo."Name")
            { }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_vatRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_PhoneNol; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            /* column(DebitAmount; DebitAmount)
             {
             }*/
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            /* column(PaymentDesc; PaymentDesc)
             {
             }
             column(SourceNo; SourceNo)
             {
             }*/
            column(SourceNo; AccountNo)//"G/L Account No.")
            {

            }
            column(PaymentDesc; AccountName)//"G/L Account Name")
            {

            }
            column(Narration_GLEntry; "G/L Entry".Description)// Removed Desc as 
            {
            }
            column(DepartmentName; DepartmentName)
            {

            }
            column(BranchName; BranchName)
            {

            }
            column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
            {
            }
            column(Credit_Amount; "Credit Amount")
            {

            }


            trigger OnAfterGetRecord()
            VAR
                RecGLEntry: Record "G/L Entry";
                CountryL: Record "Country/Region";
            begin
                CalcFields("G/L Account Name");
                GenLedSetup.GET;

                GenLedSetup.GET;
                Clear(RecDimValues);
                RecDimValues.SetRange("Dimension Code", GenLedSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Global Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    GlobalDimension1Desc := RecDimValues.Name;
                end;


                Clear(BranchName);
                Clear(DepartmentName);
                Clear(DimensionSetEntry);
                DimensionSetEntry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", GenLedSetup."Shortcut Dimension 1 Code");
                if DimensionSetEntry.FindFirst() then
                    BranchName := DimensionSetEntry."Dimension Value Code";


                Clear(DimensionSetEntry);
                DimensionSetEntry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", GenLedSetup."Shortcut Dimension 5 Code");
                if DimensionSetEntry.FindFirst() then
                    DepartmentName := DimensionSetEntry."Dimension Value Code";

                // Clear(IsSameSource);
                Clear(RecGLEntry);
                RecGLEntry.SetRange("Document No.", "Document No.");
                if RecGLEntry.FindSet() then begin
                    repeat
                        if ("Source Type" = RecGLEntry."Source Type") AND ("Source No." = RecGLEntry."Source No.") then
                            IsSameSource := true
                        else
                            IsSameSource := false;
                    until RecGLEntry.Next() = 0;
                end;

                // If not IsSameSource then begin

                Clear(AccountNo);
                if "Source No." <> '' then begin
                    if AccountNoTest = "Source No." then
                        AccountNo := "Bal. Account No."
                    else
                        AccountNo := "Source No.";
                    AccountNoTest := "Source No.";
                end else
                    AccountNo := "G/L Account No.";

                Clear(AccountName);
                if "Source Type" = "Source Type"::" " then begin
                    CalcFields("G/L Account Name");
                    AccountName := "G/L Account Name";
                end else
                    if "Source Type" = "Source Type"::"Bank Account" then begin
                        Clear(RecBankAccount);
                        RecBankAccount.GET("Source No.");
                        AccountName := RecBankAccount.Name;
                    end else
                        if "Source Type" = "Source Type"::Customer then begin
                            Clear(RecCustomer);
                            RecCustomer.GET("Source No.");
                            AccountName := RecCustomer.Name;
                        end else
                            if "Source Type" = "Source Type"::Vendor then begin
                                Clear(RecVendor);
                                RecVendor.GET("Source No.");
                                AccountName := RecVendor.Name;
                            end else
                                if "Source Type" = "Source Type"::Vendor then begin
                                    Clear(RecVendor);
                                    RecVendor.GET("Source No.");
                                    AccountName := RecVendor.Name;
                                end else
                                    if "Source Type" = "Source Type"::"Fixed Asset" then begin
                                        Clear(RecFixedAsset);
                                        RecFixedAsset.GET("Source No.");
                                        AccountName := RecFixedAsset.Description;
                                    end else
                                        if "Source Type" = "Source Type"::Employee then begin
                                            Clear(RecEmployee);
                                            RecEmployee.GET("Source No.");
                                            AccountName := RecEmployee."First Name";
                                        end;


                //Start Ramesh
                // CountryL.SetRange(Code, "Sales Header"."Sell-to Country/Region Code");
                // if CountryL.FindSet() then
                if CountryL.Get(CompanyInfo."Country/Region Code") then
                    CountryNameG := CountryL."County Name";

                Clear(DimensionValueNameG);
                DimSetEntryG.SetAutoCalcFields("Dimension Value Name");
                DimSetEntryG.SetRange("Dimension Set ID", RecGLEntry."Dimension Set ID");
                if DimSetEntryG.FindSet() then begin
                    repeat
                        DimensionValueNameG += DimSetEntryG."Dimension Code" + ' - ' + DimSetEntryG."Dimension Value Name" + '<br/>'
                    until DimSetEntryG.Next() = 0;
                end;
                //Stop Ramesh


                /*end else begin
                    AccountNo := "G/L Account No.";
                    AccountName := "G/L Account Name";
                end;*/
            end;

            trigger OnPreDataItem()
            VAR

            begin
                // "G/L Entry".SETFILTER("G/L Entry"."Source Code", '%1', 'GENJNL');
                CompanyInfo.GET;
                Clear(CompanyAddress);
                Clear(CompanyTelAndFax);
                if CompanyInfo.Address <> '' then
                    CompanyAddress := CompanyInfo.Address + ', ';

                if CompanyInfo."Address 2" <> '' then
                    CompanyAddress += CompanyInfo."Address 2" + ', ';

                if CompanyInfo."Post Code" <> '' then
                    CompanyAddress += 'P.O. Box ' + CompanyInfo."Post Code" + ', ';

                if CompanyInfo.City <> '' then
                    CompanyAddress += CompanyInfo.City + ' - ';

                if CompanyInfo."Country/Region Code" <> '' then
                    CompanyAddress += CompanyInfo."Country/Region Code";
                if CompanyInfo."Phone No." <> '' then
                    CompanyTelAndFax := 'T. ' + CompanyInfo."Phone No." + ', ';
                if CompanyInfo."Fax No." <> '' then
                    CompanyTelAndFax += 'F. ' + CompanyInfo."Fax No.";


                Clear(Users);
                Clear(UserName);
                Users.SetCurrentKey("User Name");
                Users.SetRange("User Name", "User ID");
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
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

    end;

    var

        DimSetEntryG: Record "Dimension Set Entry";
        CompanyInfo: Record 79;
        //CreditAmount: Text;
        //DebitAmount: Text;
        AccountNo: Text;
        RecDimValues: Record "Dimension Value";
        AccountNoTest: Text;
        GlobalDimension1Desc: Text;
        AccountName: Text;
        RecBankAccount: Record "Bank Account";
        RecVendor: Record Vendor;
        RecCustomer: Record Customer;
        RecFixedAsset: Record "Fixed Asset";
        RecEmployee: Record Employee;
        FixedAssetRec: Record 5600;
        GenLedSetup: Record "General Ledger Setup";
        CustomerRec: Record 18;
        CompanyAddress: Text;
        CompanyTelAndFax: Text;
        CountryNameG: Text;
        VendorRec: Record 23;
        GLAcctRec: Record 15;
        Employee: Record 5200;
        BranchName: Text;
        DimensionCodeG: Code[250];
        DimensionValueNameG: Text;
        DepartmentName: Text;
        SourceNo: Code[20];
        PaymentDesc: Text[100];
        Custledentry_Rec: Record 21;
        Users: Record User;
        UserName: Text;
        DimensionSetEntry: Record "Dimension Set Entry";
        IsSameSource: Boolean;
}

