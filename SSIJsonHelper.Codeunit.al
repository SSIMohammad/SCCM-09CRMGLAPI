codeunit 50201 SSIJsonHelper
{

    procedure GetValueAsBoolean(JToken: JsonToken; ParamString: Text): Boolean
    var
        JObject: JsonObject;
        JValueToken: JsonToken;
    begin
        JObject := JToken.AsObject();
        if JObject.SelectToken(ParamString, JValueToken) then
            if not JValueToken.AsValue().IsNull() then
                exit(JValueToken.AsValue().AsBoolean());
    end;

    procedure GetValueAsDate(JToken: JsonToken; ParamString: Text): Date
    var
        JObject: JsonObject;
        JValueToken: JsonToken;
    begin
        JObject := JToken.AsObject();
        if JObject.SelectToken(ParamString, JValueToken) then
            if not JValueToken.AsValue().IsNull() then
                exit(JValueToken.AsValue().AsDate());
    end;

    procedure GetValueAsDatetime(JToken: JsonToken; ParamString: Text): DateTime
    var
        JObject: JsonObject;
        JValueToken: JsonToken;
    begin
        JObject := JToken.AsObject();
        if JObject.SelectToken(ParamString, JValueToken) then
            if not JValueToken.AsValue().IsNull() then
                exit(JValueToken.AsValue().AsDateTime());
    end;

    procedure GetValueAsDecimal(JToken: JsonToken; ParamString: Text): Decimal
    var
        JObject: JsonObject;
        JValueToken: JsonToken;
    begin
        JObject := JToken.AsObject();
        if JObject.SelectToken(ParamString, JValueToken) then
            if not JValueToken.AsValue().IsNull() then
                exit(JValueToken.AsValue().AsDecimal());
    end;

    procedure GetValueAsInteger(JToken: JsonToken; ParamString: Text): Integer
    var
        JObject: JsonObject;
        JValueToken: JsonToken;
    begin
        JObject := JToken.AsObject();
        if JObject.SelectToken(ParamString, JValueToken) then
            if not JValueToken.AsValue().IsNull() then
                exit(JValueToken.AsValue().AsInteger());
    end;

    procedure GetValueAsText(JToken: JsonToken; ParamString: Text): Text
    var
        JObject: JsonObject;
        JValueToken: JsonToken;
    begin
        JObject := JToken.AsObject();
        if JObject.SelectToken(ParamString, JValueToken) then
            if not JValueToken.AsValue().IsNull() then
                exit(JValueToken.AsValue().AsText());
        exit('');
    end;

    procedure GetValueAsTime(JToken: JsonToken; ParamString: Text): Time
    var
        JObject: JsonObject;
        JValueToken: JsonToken;
    begin
        JObject := JToken.AsObject();
        if JObject.SelectToken(ParamString, JValueToken) then
            if not JValueToken.AsValue().IsNull() then
                exit(JValueToken.AsValue().AsTime());
    end;

    procedure SelectJsonToken(JObject: JsonObject; Path: Text): Text
    var
        JToken: JsonToken;
    begin
        if JObject.SelectToken(Path, JToken) then
            if not JToken.AsValue().IsNull() then
                exit(JToken.AsValue().AsText());
    end;
}