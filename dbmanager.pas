unit dbManager;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql57conn, srvConsts, srvVars, db, sqldb;

type
  TDBMgr = class
  protected
    fConn: TSQLConnector;
    fQuery: TSQLQuery;
    fField: TField;
  public
    procedure LoadConfig;
    procedure LoadAccounts;
    constructor Create;
    destructor Destroy;
  end;

var
  dbm: TDBMgr;

implementation

procedure TDBMgr.LoadConfig;
var
  i,j: longint;
begin
  // Load Config
  fQuery.SQL.Text:='select * from '+db_conf;
  fQuery.Open;
  i:=0;
  // Fetching
  /// TODO: try/except must be added
  SetLength(ConfigLines,fQuery.RecordCount);
  while not fQuery.EOF do begin
    j:=0;
    for fField in fQuery.Fields do begin
      if fField.IsNull then ConfigLines[i,j]:='NULL'
        else ConfigLines[i,j]:=fField.Value;
      Inc(j);
      end;
    fQuery.Next;
    Inc(i);
  end;
  // Close Query
  fQuery.Close;

  // Fill up variables
  // 1. Mail verification fields
  with VerifyMail do begin
    Subject:=GetConfigValue(cfg_Verify_Subject);
    Lines[1]:=GetConfigValue(cfg_Verify_Line1);
    Lines[2]:=GetConfigValue(cfg_Verify_Line2);
    Lines[3]:=GetConfigValue(cfg_Verify_Line3);
    Url:=GetConfigValue(cfg_verify_url);
  end;
end;

procedure TDBMgr.LoadAccounts;
var
  i,j: longint;
  acc: TAccount;
  pacc: PAccount;
begin
  fQuery.SQL.Text:='select * from '+db_accs;
  fQuery.Open;
  // Fetching
  /// TODO: try/except must be added
  while not fQuery.EOF do begin
    Acc.id:=0;
    Acc.acLevel:=0;
    acc.isBanned:=false;
    acc.isBlocked:=false;
    acc.isOnline:=false;
    acc.isVerified:=false;
    acc.LastDate:='';
    acc.LastIP:='';
    acc.mail:='';
    acc.pass:='';
    acc.RegDate:='';

    //@Acc:=nil;
    for fField in fQuery.Fields do begin
    // if not(fField.IsNull) then
    //  if fField.IsNull then tmp[i,j]:='NULL'
    //    else tmp[i,j]:=fField.Value;
      Case fField.FieldName of
        acc_ID: if not(fField.IsNull) then acc.id:=fField.Value;
        acc_Mail:  if not(fField.IsNull) then acc.mail:=fField.Value;
        acc_Pass: if not(fField.IsNull) then acc.pass:=fField.Value;
        acc_isBanned: if not(fField.IsNull) then acc.isBanned:=ffield.Value;
        acc_isBlocked: if not(fField.IsNull) then acc.isBlocked:=fField.value;
        acc_isVerified: if not(fField.IsNull) then acc.isVerified:=ffield.Value;
        acc_isOnline: if not(fField.IsNull) then acc.isOnline:=ffield.Value;
        acc_LastLogin: if not(fField.IsNull) then acc.LastDate:=fField.Value;
        acc_LastIP: if not(fField.IsNull) then acc.LastIP:=Ffield.Value;
        acc_Registered: if not(fField.IsNull) then acc.RegDate:=fField.Value;
      end;
    end;
    pacc^:=acc;
    Accounts.Add(pAcc);
    fQuery.Next;
  end;
  // Close Query
  fQuery.Close;

  // Fill up variables
  // Accounts
  for i:=0 to Accounts.Count-1 do
  begin
    WriteLn(Accounts.Items[i]^.mail);
  end;
end;

constructor TDBMgr.Create;
var
  i: word;
begin
  fConn := TSQLConnector.Create(nil);
  with fConn do begin
    ConnectorType := 'mysql 5.7';
    HostName := db_host;
    DatabaseName:= db_Name;
    UserName:=db_user;
    Password:=db_pass;
    Transaction:=TSQLTransaction.Create(nil);
  end;
  WriteLn('Connected');
  fQuery:=TSQLQuery.Create(nil);
  fQuery.Database:=fConn;
end;

destructor TDBMgr.Destroy;
begin
  fQuery.free;
  fConn.Free;
  inherited Destroy;
end;

initialization
  dbm:=TDBMgr.Create;

finalization
  dbm.Free;

end.

