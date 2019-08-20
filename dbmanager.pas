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
    constructor Create;
    destructor Destroy;
  end;

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
  with VerifyMail do begin
    Subject:=GetConfigValue(cfg_Verify_Subject);
    Lines[1]:=GetConfigValue(cfg_Verify_Line1);
    Lines[2]:=GetConfigValue(cfg_Verify_Line2);
    Lines[3]:=GetConfigValue(cfg_Verify_Line3);
    Url:=GetConfigValue(cfg_verify_url);
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

end.

