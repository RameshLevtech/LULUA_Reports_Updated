pageextension 50154 GenJlnPageExt extends "Payment Journal"
{
    layout
    {
        //Ramesh
        addafter("Account No.")
        {
            field("Pay to the order of"; "Pay to the order of")
            {
                ApplicationArea = All;
            }
            field("Cash/Cheque Number"; "Cash/Cheque Number")
            {
                ApplicationArea = All;
            }
            field("Cheque Date"; "Cheque Date")
            {
                ApplicationArea = All;
            }
            field("Bank Name"; "Bank Name")
            {
                ApplicationArea = All;
            }
        }
        //Ramesh
    }

    actions
    {
        // Add changes to page actions here
        addafter("F&unctions")
        {
            group(Print)
            {
                action("Petty Cash")
                {
                    ApplicationArea = All;
                    Image = PrintAcknowledgement;
                    trigger OnAction()
                    Var
                        PettycashReport: Report "Petty Cash";
                        RecGenJlnLine: Record "Gen. Journal Line";
                    begin
                        Clear(RecGenJlnLine);
                        RecGenJlnLine.SetRange("Journal Template Name", "Journal Template Name");
                        RecGenJlnLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        RecGenJlnLine.SetRange("Line No.", "Line No.");
                        if RecGenJlnLine.FindFirst() then begin
                            PettycashReport.SetTableView(RecGenJlnLine);
                            PettycashReport.Run();
                        end;
                    end;
                }

                action("Print IOU")
                {
                    ApplicationArea = All;
                    Image = PrintReport;
                    trigger OnAction()
                    Var
                        IOUReport: Report "IOU Report";
                        RecGenJlnLine: Record "Gen. Journal Line";
                    begin
                        Clear(RecGenJlnLine);
                        RecGenJlnLine.SetRange("Journal Template Name", "Journal Template Name");
                        RecGenJlnLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        RecGenJlnLine.SetRange("Line No.", "Line No.");
                        if RecGenJlnLine.FindFirst() then begin
                            IOUReport.SetTableView(RecGenJlnLine);
                            IOUReport.Run();
                        end;
                    end;
                }
                action("Print Check")
                {
                    ApplicationArea = All;
                    Image = PrintReport;
                    trigger OnAction()
                    Var
                        CheckReport: Report "Lulua Check";
                        RecGenJlnLine: Record "Gen. Journal Line";
                    begin
                        Clear(RecGenJlnLine);
                        RecGenJlnLine.SetRange("Journal Template Name", "Journal Template Name");
                        RecGenJlnLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        RecGenJlnLine.SetRange("Document No.", "Document No.");
                        report.Run(Report::"Lulua Check", true, true, RecGenJlnLine);
                        // if RecGenJlnLine.FindFirst() then begin
                        //     CheckReport.SetTableView(RecGenJlnLine);
                        //     CheckReport.Run();
                        // end;
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}