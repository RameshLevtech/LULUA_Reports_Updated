pageextension 50004 "Customer List Ext" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Workflow)
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
        myInt: Integer;
}