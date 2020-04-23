report 50119 "IOU Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\IOU Report\IOULayout.rdl';
    Caption = 'IOU Report';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            column(Posting_Date; "Posting Date")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(BusinessType; GlobalDimension1Desc)
            {
            }
            column(EmployeeDesc; GlobalDimension2Desc)
            {
            }
            column(Document_No_; "Document No.")
            {

            }
            column(Line_No_; "Line No.")
            {

            }
            column(CompanyLogo; RecDimValues.Logo)//CompanyInfo.Picture)
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Debit_Amount; "Debit Amount")
            {
            }
            column(Credit_Amount; "Credit Amount")
            {
            }
            column(EmployeeNameG; EmployeeNameG)
            {
            }
            trigger OnAfterGetRecord()
            var
                RecGenLedSetup: Record "General Ledger Setup";
                DimensionValueL: Record "Dimension Value";
            begin
                RecGenLedSetup.GET;
                Clear(RecDimValues);
                Clear(RecDimValues2);
                Clear(GlobalDimension1Desc);
                RecDimValues.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 1 Code");
                RecDimValues.SetRange(Code, "Shortcut Dimension 1 Code");
                if RecDimValues.FindFirst() then begin
                    RecDimValues.CalcFields(Logo);
                    GlobalDimension1Desc := RecDimValues.Name;
                end;

                Clear(GlobalDimension2Desc);
                RecDimValues2.SetRange("Dimension Code", RecGenLedSetup."Global Dimension 2 Code");
                RecDimValues2.SetRange(Code, "Shortcut Dimension 2 Code");
                if RecDimValues2.FindFirst() then begin
                    GlobalDimension2Desc := RecDimValues2.Name;
                end;

                //Start Ramesh
                // RecGenLedSetup.Get();
                DimensionG.SetRange("Employee Dimension", true);
                if DimensionG.FindFirst() then
                    if DimSetEntryG.Get("Dimension Set ID", DimensionG.Code) then begin
                        DimSetEntryG.CalcFields("Dimension Value Name");
                        EmployeeNameG := DimSetEntryG."Dimension Value Name";
                    end;
                //Stop Ramesh
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        RecDimValues: Record "Dimension Value";
        GlobalDimension1Desc: Text;
        EmployeeNameG: Text;
        RecDimValues2: Record "Dimension Value";
        GlobalDimension2Desc: Text;
        RECGLENTRIES: Record "G/L Entry";
        DimensionG: Record Dimension;
        DimensionValueG: Record "Dimension Value";
        DimSetEntryG: Record "Dimension Set Entry";

}