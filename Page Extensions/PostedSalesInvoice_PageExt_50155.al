pageextension 50155 "Posted sales invoice" extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Invoice)
        {
            group("Print&")
            {
                Caption = 'Print Reports';

                action("Commercial Invoice")
                {
                    ApplicationArea = All;
                    Image = PrintDocument;
                    trigger OnAction()
                    VAR
                        ReportSalesInvoice: Report "Commercial Invoice";
                        RecSalesInvheader: Record "Sales Invoice Header";
                    begin
                        Clear(RecSalesInvheader);
                        RecSalesInvheader.SetRange("No.", "No.");
                        if RecSalesInvheader.FindSet() then begin
                            ReportSalesInvoice.SetTableView(RecSalesInvheader);
                            ReportSalesInvoice.Run();
                        end;
                    end;
                }



                action("Sales Invoice Without VAT")
                {
                    ApplicationArea = All;
                    Image = SalesInvoice;
                    trigger OnAction()
                    VAR
                        RecSalesInvheader: Record "Sales Invoice Header";
                    begin
                        RecSalesInvheader.SetRange("No.", "No.");
                        RecSalesInvheader.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                        Report.Run(Report::"Sales Invoice Report", true, true, RecSalesInvheader);
                    end;

                }
                action("Sales Invoice with VAT")
                {
                    ApplicationArea = All;
                    Image = CoupledSalesInvoice;
                    trigger OnAction()
                    VAR
                        RecSalesInvheader: Record "Sales Invoice Header";
                    begin
                        RecSalesInvheader.SetRange("No.", "No.");
                        RecSalesInvheader.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                        Report.Run(Report::"Sales Invoice With VAT", true, true, RecSalesInvheader);
                    end;
                }
                action("ALHI Pre Printed Stationary")
                {
                    ApplicationArea = All;
                    Image = PrintForm;
                    trigger OnAction()
                    VAR
                        ReportSalesInvoice: Report "Sales Invoice ALHI";
                        RecSalesInvheader: Record "Sales Invoice Header";
                    begin
                        Clear(RecSalesInvheader);
                        RecSalesInvheader.SetRange("No.", "No.");
                        if RecSalesInvheader.FindSet() then begin
                            ReportSalesInvoice.SetTableView(RecSalesInvheader);
                            ReportSalesInvoice.Run();
                        end;
                    end;
                }

                action("Intisar Pre Printed Stationary")
                {
                    ApplicationArea = All;
                    Image = PrintAcknowledgement;
                    trigger OnAction()
                    VAR
                        ReportSalesInvoice: Report "Sales Invoice Intisar";
                        RecSalesInvheader: Record "Sales Invoice Header";
                    begin
                        Clear(RecSalesInvheader);
                        RecSalesInvheader.SetRange("No.", "No.");
                        if RecSalesInvheader.FindSet() then begin
                            ReportSalesInvoice.SetTableView(RecSalesInvheader);
                            ReportSalesInvoice.Run();
                        end;
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}