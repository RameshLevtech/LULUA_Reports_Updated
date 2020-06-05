tableextension 50106 "Lulua Gen.JnL" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Pay to the order of"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Shortcut Dimension 3 Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(50002; "Cash/Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cash/Cheque Number';
        }
        field(50003; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Date';
        }
        field(50004; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Bank Name';
        }
        field(50005; "Bank Charges"; Option)
        {
            Caption = 'Bank Charges';
            OptionCaption = ',Ours,Shared,Beneficiary';
            OptionMembers = ,Ours,"Shared",Beneficiary;
        }
        field(50006; "AdditionalSignatory"; Text[50])
        {
            Caption = 'Signatory';
            DataClassification = ToBeClassified;
            TableRelation = Signatory.Name;
        }
    }
}