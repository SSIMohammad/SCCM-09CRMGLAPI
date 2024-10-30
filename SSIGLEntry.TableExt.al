tableextension 50201 SSIGLEntry extends "G/L Entry"
{
    fields
    {

        field(50200; "SSI CRM Batch No."; Code[50])
        {
            Caption = 'CRM Batch No.';
            DataClassification = CustomerContent;
        }
        field(50201; "SSI CRM Batch URL"; Text[250])
        {
            Caption = 'CRM Batch URL';
            DataClassification = CustomerContent;
        }
        field(50202; "SSI CRM Guid"; Guid)
        {
            Caption = 'CRM Guid';
            DataClassification = CustomerContent;
        }
    }
}
