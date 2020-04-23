pageextension 50112 "EXt Customer Card" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Sales Journal")
        {
            action("Credit Application Form")
            {
                Caption = 'Credit Application Form';
                ApplicationArea = ALL;
                Image = Print;
                trigger OnAction()
                var
                    ReportCreditAppl: report "Credit Application Form";
                    RecCust: Record Customer;
                begin
                    Clear(RecCust);
                    RecCust.SetRange("No.", "No.");
                    if RecCust.FindFirst() then begin
                        ReportCreditAppl.SetTableView(RecCust);
                        ReportCreditAppl.Run();
                    end;
                end;
            }
        }
    }

    var
        CreditAppl: Report "Credit Application Form";
}