pageextension 50200 "SSI General Journal" extends "General Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("SSI CRM Batch No."; rec."SSI CRM Batch No.")
            {

                ApplicationArea = all;
                Visible = true;
            }
            field("SSI CRM Batch URL"; rec."SSI CRM Batch URL")
            {

                ApplicationArea = all;
                Visible = false;
                ExtendedDatatype = URL;
            }
            field("SSI CRM Guid"; rec."SSI CRM Guid")
            {

                ApplicationArea = all;
                Visible = false;
            }
        }

    }
}
