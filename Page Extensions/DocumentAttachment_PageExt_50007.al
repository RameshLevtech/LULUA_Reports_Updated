pageextension 50007 DocAttachment extends "Document Attachment Details"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        if POCallType then begin
            // "Table ID" := 38;
            "Document Type" := "Document Type"::Order;
            "Vendor Line No." := VendorLineNo;
            "No." := DocNo;
        end;

    end;

    procedure SetData(VLineNoP: Integer; DocNoP: code[20]; TableIdP: Integer; POCallP: Boolean)
    begin
        Clear(VendorLineNo);
        Clear(POCallType);
        Clear(TableId);
        Clear(DocNo);

        POCallType := POCallP;
        VendorLineNo := VLineNoP;
        DocNo := DocNoP;
        TableId := TableIdP;
    end;

    var
        VendorLineNo: Integer;
        POCallType: Boolean;
        DocNo: Code[20];
        TableId: Integer;
}
