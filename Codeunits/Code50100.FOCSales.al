codeunit 50100 "FOC Sales Subscriber"
{
    SingleInstance = true;
    //FOC Item

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterValidateEvent', 'FOC Sales', true, true)]
    local procedure FOCSalesOnAfterValidate(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    begin
        Rec.TestField(Type, Rec.Type::Item);
        // if Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Invoice] then begin
        SalesReceivableSetup.Get();
        SalesReceivableSetup.TestField("FOC Gen.Prod.Posting Group");
        if Rec."FOC Sales" then begin
            Rec.Validate("Gen. Prod. Posting Group", SalesReceivableSetup."FOC Gen.Prod.Posting Group");
            Rec.Validate("Unit Price", 0);
        end
        //end;
    end;

    //FOC Item UnitPrice Validation
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeValidateEvent', 'Unit Price', true, true)]
    local procedure UnitPriceValidationBeforeValidateEvent(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        if CurrFieldNo = Rec.FieldNo("Unit Price") then
            if Rec."FOC Sales" = true then
                Error(CannotEnterUnitPriceLbl);
    end;

    //FOC Item Gen.Prod.Posting.Group Validation
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Gen. Prod. Posting Group', true, true)]
    local procedure GenProdPostingValidationOnBeforeEvent(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        if CurrFieldNo = Rec.FieldNo("Gen. Prod. Posting Group") then
            if Rec."FOC Sales" = true then
                Error(CannotEnterGenProPostingValueLbl);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeValidatePostingAndDocumentDate', '', true, true)]
    local procedure InvoicehasFOCItem(var SalesHeader: Record "Sales Header")
    var
        SalesLineL: Record "Sales Line";
    begin
        SalesLineL.SetRange("Document Type", SalesHeader."Document Type");
        SalesLineL.SetRange("Document No.", SalesHeader."No.");
        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
        SalesLineL.SetRange("FOC Sales", true);
        if not SalesLineL.IsEmpty() then
            if not Confirm(StrSubstNo(FOCItemConfirmationLbl, SalesHeader."Document Type")) then
                Error('');
    end;

    //FOC SO Cancellation

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeActionEvent', 'Cancel SalesOrder', true, true)]
    local procedure OrderCancel(var Rec: Record "Sales Header")
    var
        SalesLineL: Record "Sales Line";
    begin
        UsersetupRecG.Get(UserId);
        if not UsersetupRecG."Can Cancel & Shortclose orders" then
            Error(PermissionForCancelLbl, Rec."Document Type");

        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField("Remarks For Cancellation");

        SalesLineL.SetRange("Document Type", Rec."Document Type");
        SalesLineL.SetRange("Document No.", Rec."No.");
        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
        SalesLineL.SetFilter("Quantity Shipped", '>%1', 0);
        if not SalesLineL.IsEmpty() then
            Error(CanNotCancelSOLbl, 'Sales', Rec."Document Type");

        ReOpenG := true;
        Rec."Cancel SO" := true;
        Rec."Cancelled UserID" := UserId();
        Rec."Cancelled DateTime" := CurrentDateTime();

        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterActionEvent', 'Cancel SalesOrder', true, true)]
    local procedure OnAfterSOCancel(var Rec: Record "Sales Header")
    begin
        Clear(ReOpenG);
    end;

    //FOC SO Short Close

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnbeforeActionEvent', 'Order Short Close', true, true)]
    local procedure OrderSortClose(var Rec: Record "Sales Header")
    var
        SalesLineL: Record "Sales Line";
    begin
        UsersetupRecG.Get(UserId);
        if not UsersetupRecG."Can Cancel & Shortclose orders" then
            Error(PermissionForShortCloseLbl, Rec."Document Type");

        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField("Remarks For Short Close");

        SalesLineL.SetRange("Document Type", Rec."Document Type");
        SalesLineL.SetRange("Document No.", Rec."No.");
        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
        SalesLineL.SetFilter("Quantity Shipped", '>%1', 0);
        if SalesLineL.FindSet() then
            repeat
                if SalesLineL."Quantity Shipped" > SalesLineL."Quantity Invoiced" then
                    Error(InvoiceTheReceivedQtySOShortCloseLbl, Rec."Document Type");
            until SalesLineL.Next() = 0;

        SalesLineL.SetFilter("Quantity Invoiced", '>%1', 0);
        if SalesLineL.FindFirst() then
            Error(CanNotShortCloseSOLbl, Rec."Document Type");


        ReOpenG := true;
        Rec."Short Close" := true;
        Rec."Short Close Cancelled User ID" := UserId();
        Rec."Short Close Cancelled DateTime" := CurrentDateTime();

        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterActionEvent', 'Order Short Close', true, true)]
    local procedure OnAfterOrderSortClose(var Rec: Record "Sales Header")
    begin
        Clear(ReOpenG);
    end;

    //PO Cancellation
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'Cancel PurchaseOrder', true, true)]
    local procedure CancelPurchaseOrderOnBeforeAction(var Rec: Record "Purchase Header")
    var
        PurchaseLineL: Record "Purchase Line";
    begin
        UsersetupRecG.Get(UserId);
        if not UsersetupRecG."Can Cancel & Shortclose orders" then
            Error(PermissionForCancelLbl, Rec."Document Type");

        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField("Remarks For Cancellation");

        PurchaseLineL.SetRange("Document Type", Rec."Document Type");
        PurchaseLineL.SetRange("Document No.", Rec."No.");
        PurchaseLineL.SetRange(Type, PurchaseLineL.Type::Item);
        PurchaseLineL.SetFilter("Quantity Received", '>%1', 0);
        if not PurchaseLineL.IsEmpty() then
            Error(CanNotCancelPOLbl, Rec."Document Type");

        ReOpenG := true;
        Rec."Cancel PO" := true;
        Rec."Cancelled UserID" := UserId();
        Rec."Cancelled DateTime" := CurrentDateTime();

        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnAfterActionEvent', 'Cancel PurchaseOrder', true, true)]
    local procedure CancelPurchaseOrderOnafterAction(var Rec: Record "Purchase Header")
    begin
        Clear(ReOpenG);
    end;

    //PO Short Close
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'Order Short Close', true, true)]
    local procedure PurchaseOrderShortClose(var Rec: Record "Purchase Header")
    var
        PurchaseLineL: Record "Purchase Line";
    begin
        UsersetupRecG.Get(UserId);
        if not UsersetupRecG."Can Cancel & Shortclose orders" then
            Error(PermissionForShortCloseLbl, Rec."Document Type");

        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField("Remarks For Short Close");

        PurchaseLineL.SetRange("Document Type", Rec."Document Type");
        PurchaseLineL.SetRange("Document No.", Rec."No.");
        PurchaseLineL.SetRange(Type, PurchaseLineL.Type::Item);
        PurchaseLineL.SetFilter("Quantity Received", '>%1', 0);
        if PurchaseLineL.FindSet() then
            repeat
                if PurchaseLineL."Quantity Received" > PurchaseLineL."Quantity Invoiced" then
                    Error(InvoiceTheReceivedQtyPOShortCloseLbl, Rec."Document Type");
            until PurchaseLineL.Next() = 0;

        PurchaseLineL.SetFilter("Quantity Invoiced", '>%1', 0);
        if PurchaseLineL.FindFirst() then
            Error(CanNotShortClosePOLbl, Rec."Document Type");


        ReOpenG := true;
        Rec."Short Close" := true;
        Rec."Short Close Cancelled User ID" := UserId();
        Rec."Short Close Cancelled DateTime" := CurrentDateTime();

        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnAfterActionEvent', 'Order Short Close', true, true)]
    local procedure OnAfterPOShortClose(var Rec: Record "Purchase Header")
    begin
        Clear(ReOpenG);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnAfterModifyEvent', '', true, true)]
    local procedure RestrictUserToModifyRecord(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    begin
        if not ReOpenG then
            if Rec.Status = Rec.Status::Released then begin
                if Rec."Cancel SO" then
                    Error(CannotModifyOrderLbl);
                if rec."Short Close" then
                    Error(CannotModifyOrderShortClose);
            end;
        //Clear(ReOpenG);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterModifyEvent', '', true, true)]
    local procedure RestrictUserToModifyPurchaseOrder(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header")
    begin
        if not ReOpenG then
            if Rec.Status = Rec.Status::Released then begin
                if Rec."Cancel PO" then
                    Error(CannotModifyOrderLbl);
                if Rec."Short Close" then
                    Error(CannotModifyOrderShortClose);
            end;
        //Clear(ReOpenG);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeActionEvent', 'Reopen', true, true)]
    local procedure ClearValueWHenReopenSO(var Rec: Record "Sales Header")
    begin
        ReOpenG := true;
        Rec."Cancel SO" := false;
        Rec."Cancelled UserID" := '';
        Rec."Cancelled DateTime" := 0DT;
        Rec."Short Close" := false;
        Rec."Short Close Cancelled User ID" := '';
        Rec."Short Close Cancelled DateTime" := 0DT;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterActionEvent', 'Reopen', true, true)]
    local procedure OnAfterClearValueWHenReopenSO(var Rec: Record "Sales Header")
    begin
        Clear(ReOpenG);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'Reopen', true, true)]
    local procedure ClearValueWHenReopenPO(var Rec: Record "Purchase Header")
    begin
        ReOpenG := true;
        Rec."Cancel PO" := false;
        Rec."Cancelled UserID" := '';
        Rec."Cancelled DateTime" := 0DT;
        Rec."Short Close" := false;
        Rec."Short Close Cancelled User ID" := '';
        Rec."Short Close Cancelled DateTime" := 0DT;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnAfterActionEvent', 'Reopen', true, true)]
    local procedure OnAfterClearValueWHenReopenPO(var Rec: Record "Purchase Header")
    begin
        Clear(ReOpenG);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', true, true)]
    local procedure OnAfterInitVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."Cash/Cheque Number" := GenJournalLine."Cash/Cheque Number";
        VendorLedgerEntry."Cheque Date" := GenJournalLine."Cheque Date";
        VendorLedgerEntry."Bank Name" := GenJournalLine."Bank Name";
        VendorLedgerEntry."Pay to the order of" := GenJournalLine."Pay to the order of";
        VendorLedgerEntry."Bank Charges" := GenJournalLine."Bank Charges";
        VendorLedgerEntry.Signatory := GenJournalLine.AdditionalSignatory;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    local procedure GLEntry_OnAfterInit(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."Cash/Cheque Number" := GenJournalLine."Cash/Cheque Number";
        GLEntry."Cheque Date" := GenJournalLine."Cheque Date";
        GLEntry."Bank Name" := GenJournalLine."Bank Name";
        GLEntry."Bank Charges" := Format(GenJournalLine."Bank Charges");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', true, true)]
    local procedure OnAfterInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry."Bank Charges" := GenJournalLine."Bank Charges";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesLines', '', true, true)]
    local procedure OnBeforePostSalesLines(var SalesHeader: Record "Sales Header"; var TempSalesLineGlobal: Record "Sales Line"; var TempVATAmountLine: Record "VAT Amount Line")
    var
        ItemL: Record Item;
        SalesLineL: Record "Sales Line";
    begin
        //if (TempSalesLineGlobal."Document Type" = TempSalesLineGlobal."Document Type"::Invoice) AND (TempSalesLineGlobal."Parent Item" = '') then begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesLineL.SetRange("Document Type", SalesHeader."Document Type");
            SalesLineL.SetRange("Document No.", SalesHeader."No.");
            SalesLineL.SetRange(Type, TempSalesLineGlobal.Type::Item);
            if SalesLineL.FindSet() then
                repeat
                    if ItemL.Get(SalesLineL."No.") AND ItemL."Check Parent Item" then
                        if Not SalesLineL."Additional Parent Item" AND (SalesLineL."Parent Item" = '') then
                            Error('Please Specify The Parent Item For %1', SalesLineL."No.");
                until SalesLineL.Next() = 0;
        end;
    end;

    var
        UsersetupRecG: Record "User Setup";
        SalesReceivableSetup: Record "Sales & Receivables Setup";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReOpenG: Boolean;
        PermissionForCancelLbl: Label 'You Don`t Have Permission To Cancel %1';
        PermissionForShortCloseLbl: Label 'You Don`t Have Permission To Short Close %1';
        CannotEnterUnitPriceLbl: Label 'You Cannot Enter Value In Unit Price, Until FOC Item is UnTicked';
        CannotEnterGenProPostingValueLbl: Label 'You Cannot Enter Value In Gen.Pro.Posting.Group, Until FOC Item is UnTicked';
        FOCItemConfirmationLbl: Label '%1 has FOC Item Do you want to post the transaction?';
        CanNotCancelPOLbl: Label '%1 can not be cancelled as Quantity received/invoiced is not equal to zero';
        CanNotCancelSOLbl: Label '%1 can not be cancelled as Quantity Shipped/invoiced is not equal to zero';
        CanNotShortClosePOLbl: Label 'You can not short close %1 with No invoiced and Received Quantity please Cancel';
        CanNotShortCloseSOLbl: Label 'You can not short close %1 with No invoiced and Shipped Quantity please Cancel';
        CannotModifyOrderLbl: Label 'You cannot Modify the Order, The Order is already Canceled';
        CannotModifyOrderShortClose: Label 'You cannot Modify the Order, The Order is already Closed';
        InvoiceTheReceivedQtyPOShortCloseLbl: Label 'Invoice the Received quantity then only purchase %1 can be short closed';
        InvoiceTheReceivedQtySOShortCloseLbl: Label 'Invoice the Shipped quantity then only purchase %1 can be short closed';

}