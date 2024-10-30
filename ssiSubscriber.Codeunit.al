codeunit 50202 ssiSubscriber
{
    [EventSubscriber(ObjectType::Table, database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', true, true)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry.Validate("SSI CRM Batch No.", GenJournalLine."SSI CRM Batch No.");
        GLEntry.Validate("SSI CRM Batch URL", GenJournalLine."SSI CRM Batch URL");
        GLEntry.Validate("SSI CRM Guid", GenJournalLine."SSI CRM Guid");
    end;
}
