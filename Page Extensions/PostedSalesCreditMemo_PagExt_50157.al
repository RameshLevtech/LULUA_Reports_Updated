pageextension 50157 "Ext Post Sales CreditMemo" extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Cr. Memo")
        {
            group("Print Report")
            {
                action("Credit Note With VAT")
                {
                    ApplicationArea = All;
                    Image = PrintCover;
                    trigger OnAction()
                    var
                        CrReport: Report "Credit Note With VAT";
                        RecSCM: Record "Sales Cr.Memo Header";
                    begin
                        Clear(RecSCM);
                        RecSCM.SetFilter("No.", '=%1', Rec."No.");
                        CrReport.SetTableView(RecSCM);
                        CrReport.Run();
                    end;
                }
                action("Credit Note Without VAT")
                {
                    ApplicationArea = All;
                    Image = PrintAcknowledgement;
                    trigger OnAction()
                    var
                        CrReport: Report "Credit Note_WithoutVAT";
                        RecSCM: Record "Sales Cr.Memo Header";
                    begin
                        Clear(RecSCM);
                        RecSCM.SetFilter("No.", '=%1', Rec."No.");
                        CrReport.SetTableView(RecSCM);
                        CrReport.Run();
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}