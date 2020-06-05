codeunit 50101 "Check Report Lulua"
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeValidateEvent', 'Account No.', true, true)]
    local procedure AutoFillVendorNameOnValidate(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    var
        VendorRecL: Record Vendor;
    begin
        if VendorRecL.Get(Rec."Account No.") then
            Rec."Pay to the order of" := VendorRecL."Pay to the order of";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnBeforeInsertEvent', '', true, true)]
    local procedure UpdatePaytoOrderOf(var Rec: Record "Vendor Ledger Entry")
    var
        VendorL: Record Vendor;
    begin
        if VendorL.Get(Rec."Vendor No.") then
            Rec."Pay to the order of" := VendorL.Name;
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterValidateEvent', 'Name', true, true)]
    local procedure UpdatePayToOrderOfName(var Rec: Record Vendor; var xRec: Record Vendor; CurrFieldNo: Integer)
    begin
        Rec."Pay to the order of" := Rec.Name;
    end;


    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure CopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")

    begin
        GLEntry."Cash/Cheque Number" := GenJournalLine."Cash/Cheque Number";
        GLEntry."Cheque Date" := GenJournalLine."Cheque Date";
        GLEntry."Bank Name" := GenJournalLine."Bank Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', true, true)]
    local procedure OnAfterInitCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."Cash/Cheque Number" := GenJournalLine."Cash/Cheque Number";
        CustLedgerEntry."Cheque Date" := GenJournalLine."Cheque Date";
        CustLedgerEntry."Bank Name" := GenJournalLine."Bank Name";
    end;
}