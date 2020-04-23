pageextension 50158 "Ext Posted Sales Credit Memos" extends "Posted Sales Credit Memos"
{
    layout
    {
        // Add changes to page layout here
    }

    // actions
    // {
    //     addafter(ActivityLog)
    //     {
    //         group("Print Report")
    //         {
    //             action("CreditNoteWithVAT")
    //             {
    //                 ApplicationArea = All;
    //                 trigger OnAction()
    //                 var
    //                 begin
    //                     Report.Run(Report::"Credit Note With VAT");
    //                 end;
    //             }
    //             action("CreditNoteWithoutVAT")
    //             {
    //                 ApplicationArea = All;
    //                 trigger OnAction()
    //                 var
    //                 begin
    //                     Report.Run(Report::"Credit Note_WithoutVAT");
    //                 end;
    //             }
    //         }
    //     }
    // }

}