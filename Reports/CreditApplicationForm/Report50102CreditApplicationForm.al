report 50131 "Credit Application Form"
{
    Caption = 'Credit Application Form';
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/CreditApplicationForm/CreditApplicationForm.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            column(Name; Name)
            { }
            column(Address; Address)
            { }
            column(E_Mail; "E-Mail")
            { }
            column(Phone_No_; "Phone No.")
            { }
            column(Credit_Limit__LCY_; "Credit Limit (LCY)")
            { }
            column(Payment_Terms_Code; "Payment Terms Code")
            { }
            column(Fax_No_; "Fax No.")
            { }
            column(Partner_Type; "Partner Type")
            { }
            column(Company_Picture; CompanyInfoRecLbl.Picture)
            { }
            column(Company_Name; CompanyInfoRecLbl.Name)
            { }
            column(Company_Add1; CompanyInfoRecLbl.Address)
            { }
            column(Company_Add2; CompanyInfoRecLbl."Address 2")
            { }
            column(Company_City; CompanyInfoRecLbl.City)
            { }
            column(Company_Country; CompanyInfoRecLbl."Country/Region Code")
            { }
            column(Company_Phone; CompanyInfoRecLbl."Phone No.")
            { }
            column(CustomerNoLbl; CustomerNoLbl) { }
            column(CustomerNameLbl; CustomerNameLbl) { }
            column(CreditApplicationFormLbl; CreditApplicationFormLbl) { }
            column(NameofCompany; NameofCompany) { }
            column(TypeOfComapnyLbl; TypeOfComapnyLbl) { }
            column(PostalAddressLbl; PostalAddressLbl) { }
            column(OfficeLocationLbl; OfficeLocationLbl) { }
            column(EmailLbl; EmailLbl) { }
            column(WebLbl; WebLbl) { }
            column(YearEstablishedLbl; YearEstablishedLbl) { }
            column(OwenerPartnersLbl; OwenerPartnersLbl) { }
            column(LocalSponsorLbl; LocalSponsorLbl) { }
            column(AssociateCompaniesLbl; AssociateCompaniesLbl) { }
            column(CompaniesGivingLbl; CompaniesGivingLbl) { }
            column(IndividualLbl; IndividualLbl) { }
            column(PartnershipLbl; PartnershipLbl) { }
            column(LimitedLiabilityCompanyLbl; LimitedLiabilityCompanyLbl) { }
            column(LocalLbl; LocalLbl) { }
            column(FZEFZCLbl; FZEFZCLbl) { }
            column(ForeginLbl; ForeginLbl) { }
            column(JointVentureLbl; JointVentureLbl) { }
            column(RegistrationLbl; RegistrationLbl) { }
            column(SalesTurnoverLbl; SalesTurnoverLbl) { }
            column(NumberofEmployeesLbl; NumberofEmployeesLbl) { }
            column(DesignationLbl; DesignationLbl) { }
            column(AddressLbl; AddressLbl) { }
            column(CreditLimitLbl; CreditLimitLbl) { }
            column(TelephoneNoLbl; TelephoneNoLbl) { }
            column(FaxNumberLbl; FaxNumberLbl) { }
            column(NationalityLbl; NationalityLbl) { }
            column(PaymentTermsLbl; PaymentTermsLbl) { }
            column(CreditRequiredLbl; CreditRequiredLbl) { }
            column(CreditvalueLbl; CreditvalueLbl) { }
            column(CreditPeriodLbl; CreditPeriodLbl) { }
            column(CreditModeLbl; CreditModeLbl) { }
            column(BankDetailsLbl; BankDetailsLbl) { }
            column(DepartmentLbl; DepartmentLbl) { }
            column(PurchaseLbl; PurchaseLbl) { }
            column(AccountsPayableLbl; AccountsPayableLbl) { }
            column(MaterialControllerLbl; MaterialControllerLbl) { }
            column(PersonAuthorisedLbl1; PersonAuthorisedLbl1) { }
            column(PersonAuthorisedLb2; PersonAuthorisedLb2) { }
            column(PersonAuthorizedBankLbl2; PersonAuthorizedBankLbl2) { }
            column(PersonAuthorizedBankLbl1; PersonAuthorizedBankLbl1) { }
            column(NameLbl; NameLbl) { }
            column(ContactPersonLbl; ContactPersonLbl) { }
            column(BranchLbl; BranchLbl) { }
            column(AccountNumberLbl; AccountNumberLbl) { }
            column(TelephoneExtensionLbl; TelephoneExtensionLbl) { }
            column(SignatureLbl; SignatureLbl) { }
            column(SinglyLbl; SinglyLbl) { }
            column(DeclerationLbl; DeclerationLbl) { }
            column(PrintNameLbl; PrintNameLbl) { }
            column(SignLbl; SignLbl) { }
            column(DateLbl; DateLbl) { }
            column(KindlyLbl; KindlyLbl) { }
            column(TradeLbl; TradeLbl) { }
            column(ChamberLbl; ChamberLbl) { }
            column(PartnersCertificateLbl; PartnersCertificateLbl)
            { }
            column(OwnersPassportLbl; OwnersPassportLbl) { }


        }
    }

    labels
    {
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfoRecLbl.Get();
        CompanyInfoRecLbl.CalcFields(Picture);
    end;

    var
        CompanyInfoRecLbl: Record "Company Information";
        CreditApplicationFormLbl: Label 'CREDIT APPLICATION FORM';
        CustomerNoLbl: Label 'Company Number';
        CustomerNameLbl: Label 'Customer Name';
        NameofCompany: Label 'Name Of Company';
        TypeOfComapnyLbl: Label 'Type Of Company';
        PostalAddressLbl: Label 'PostalAddress';
        OfficeLocationLbl: Label 'Office Location';
        EmailLbl: Label 'Email';
        WebLbl: Label 'Web';
        YearEstablishedLbl: Label 'Year Established';
        OwenerPartnersLbl: Label 'Owners/Partners Directors';
        LocalSponsorLbl: Label 'Local Sponsor';
        AssociateCompaniesLbl: Label 'Associate Companies';
        CompaniesGivingLbl: Label 'Companies Giving Credit';
        IndividualLbl: Label 'Individual';
        PartnershipLbl: Label 'Partnership';
        LimitedLiabilityCompanyLbl: Label 'Limited Liability Company';
        LocalLbl: Label 'Local';
        FZEFZCLbl: Label 'FZE/FZC';
        ForeginLbl: Label 'Foregin';
        JointVentureLbl: Label 'Joint Venture';
        TelephoneNoLbl: Label 'Telephone No.';
        FaxNumberLbl: Label 'Fax Number';
        NationalityLbl: Label 'Nationality';
        AddressLbl: Label 'Address';
        CreditLimitLbl: Label 'Credit Limit(AED)';
        PaymentTermsLbl: Label 'Payment Terms';
        RegistrationLbl: Label 'Registration/License No';
        SalesTurnoverLbl: Label 'Sales Turnover(AED)';
        NumberofEmployeesLbl: Label 'Number Of Employees';
        DesignationLbl: Label 'Designation';
        CreditRequiredLbl: Label 'Credit Required';
        CreditvalueLbl: Label 'Credit Value(AED)';
        CreditPeriodLbl: Label 'Credit Period';
        CreditModeLbl: Label 'Credit Mode';
        BankDetailsLbl: Label 'Bank Details';
        DepartmentLbl: Label 'Department';
        PurchaseLbl: Label 'Purchase';
        AccountsPayableLbl: Label 'Accounts Payable';
        MaterialControllerLbl: Label 'Material Controller';
        PersonAuthorisedLbl1: Label 'Person Authorized To';
        PersonAuthorisedLb2: Label 'Sign Purchase Orders';
        PersonAuthorizedBankLbl1: Label 'Person Authorized To';
        PersonAuthorizedBankLbl2: Label 'Sign With Banks';
        NameLbl: Label 'Name';
        BranchLbl: Label 'Branch';
        AccountNumberLbl: Label 'Account Number';
        ContactPersonLbl: Label 'Contact Person';
        TelephoneExtensionLbl: Label 'Telephone No. & Extension';
        SignatureLbl: Label 'Signature';
        SinglyLbl: Label 'Singly/Jointly';
        DeclerationLbl: Label 'We/ I hereby apply for a Credit Limit and agree to pay to the terms of my account and being an authorized person of the applicant company, jointly and Serverally guarantee performance of all the Companys financial obligations to ALHI General Trading L.L.C. We aslo acknowledge and accept your terms and conditions of sale.';
        PrintNameLbl: Label 'Print Name:';
        SignLbl: Label 'Sign:';
        DateLbl: Label 'Date:';
        KindlyLbl: Label 'Kindly attach following documents with credit application form:';
        TradeLbl: Label 'Trade Licence Copy';
        ChamberLbl: Label 'Chamber Of Commerece Certificate';
        PartnersCertificateLbl: Label 'Partners Certificate';
        OwnersPassportLbl: Label 'Owners Passport Copies';

}