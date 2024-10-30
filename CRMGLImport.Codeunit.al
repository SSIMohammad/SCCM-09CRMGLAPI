codeunit 50200 CRMGLAPIIntegration
{
    [ServiceEnabled]
    procedure CRMGLAPIIntegration(data: text): Text
    var
        generalJournalBatch: Record "Gen. Journal Batch";
        Jtoken, RequestToken : JsonToken;
        SSIJsonHelper: Codeunit SSIJsonHelper;
        PostingDate: date;
        AccountNo: text;
        Description: Text;
        CreditAmount: Decimal;
        DebitAmount: Decimal;
        CRMBatchNo: text;
        CRMBatchURL: Text;
        CRMGUID: text;
        genJournal, genJournalOLD, genJournalCheckUsed : Record "Gen. Journal Line";
        GenLedgerEntries: Record "G/L Entry";
        GUIDL: Guid;
        AccountMain, AcountSub : text;
        noseriesMan: Codeunit "No. Series";
        noseries: text;
    begin
        if data = '' then
            exit;
        noseries := noseriesMan.GetNextNo('CRMIMPORT');
        if RequestToken.ReadFrom(data) then
            if RequestToken.IsArray then
                foreach jtoken in requesttoken.AsArray() do begin
                    clear(PostingDate);
                    clear(AccountNo);
                    clear(CreditAmount);
                    clear(DebitAmount);
                    clear(CRMBatchNo);
                    clear(CRMBatchURL);
                    clear(CRMGUID);

                    PostingDate := SSIJsonHelper.GetValueAsDate(jtoken, 'PostingDate');

                    AccountNo := SSIJsonHelper.GetValueAsText(jtoken, 'GLAccountNo');

                    Description := SSIJsonHelper.GetValueAsText(jtoken, 'Description');
                    //   exit(StrSubstNo('%1', AccountNo));
                    CreditAmount := SSIJsonHelper.GetValueAsDecimal(jtoken, 'CreditAmount');
                    DebitAmount := SSIJsonHelper.GetValueAsDecimal(jtoken, 'DebitAmount');
                    CRMBatchNo := SSIJsonHelper.GetValueAsText(jtoken, 'CRMBatchNo');
                    CRMBatchURL := SSIJsonHelper.GetValueAsText(jtoken, 'CRMBatchURL');
                    CRMGUID := SSIJsonHelper.GetValueAsText(jtoken, 'CRMGUID');

                    if not generalJournalBatch.get('GENERAL', 'CRMIMPORT') then begin
                        generalJournalBatch.Init();
                        generalJournalBatch.Validate("Journal Template Name", 'GENERAL');
                        generalJournalBatch.Validate("Name", 'CRMIMPORT');
                        generalJournalBatch.Insert(true);
                    end;
                    genJournal.Init();

                    genJournalold.SetRange("Journal Template Name", 'GENERAL');
                    genJournalold.SetRange("Journal Batch Name", 'CRMIMPORT');
                    if genJournalold.FindLast() then
                        genJournal."Line No." := genJournalold."Line No." + 10000
                    else
                        genJournal."Line No." := 10000;

                    genJournal."Journal Template Name" := 'GENERAL';
                    genJournal."Journal Batch Name" := 'CRMIMPORT';
                    genJournal."Document No." := noseries;
                    genJournal."Account Type" := genJournal."Account Type"::"G/L Account";
                    genJournal."Source Code" := 'GENJNL';

                    AccountMain := CopyStr(AccountNo, 1, 4);
                    AcountSub := CopyStr(AccountNo, 6, 7);
                    genJournal.Validate("Account No.", AccountMain);
                    genJournal.validate("Shortcut Dimension 2 Code", AcountSub);

                    genJournal.validate("Posting Date", PostingDate);
                    genJournal.validate("Debit Amount", DebitAmount);
                    genJournal.Validate(Description, Description);
                    genJournal.validate("Credit Amount", CreditAmount);
                    genJournal.Validate("SSI CRM Batch No.", CRMBatchNo);
                    genJournal.Validate("SSI CRM Batch URL", CRMBatchURL);
                    Evaluate(GUIDL, CRMGUID);
                    genJournalCheckUsed.SetRange("SSI CRM Guid", GUIDL);
                    if genJournalCheckUsed.FindFirst() then
                        exit(StrSubstNo('Error GUID %1 is found  %2', GUIDL, genJournalCheckUsed.RecordId));

                    GenLedgerEntries.SetRange("SSI CRM Guid", GUIDL);
                    if GenLedgerEntries.FindFirst() then
                        exit(StrSubstNo('Error GUID %1 is found %2', GUIDL, GenLedgerEntries.RecordId));
                    genJournal.validate("Shortcut Dimension 1 Code", 'BA');

                    genJournal.validate("SSI CRM Guid", GUIDL);
                    genJournal.insert(true);

                end
            else
                exit('Requested Data Should be in a form of array');
        exit(StrSubstNo('Imported Successfully'));
    end;
}
