unit dbManager;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql57dyn, srvConsts, srvVars, db, sqldb;

type
  TDBMgr = class
  protected
    fConn: TSQLConnector;
    fQuery: TSQLQuery;
    fField: TField;
    fList: Tstrings;
    //fDBCon : integer;
  public
    procedure LoadConfig;
    constructor Create;
    destructor Destroy;
  end;

implementation

procedure TDBMgr.LoadConfig;
var
  // Counters
  i,j: longint;
begin
  // Load Config
  fQuery.SQL.Text:='select * from '+db_conf;
  fQuery.Open;
  i:=0;
  // Fetching
  SetLength(ConfigLines,fQuery.RecordCount);
  while not fQuery.EOF do begin
    j:=0;
    for fField in fQuery.Fields do begin
      // Fetch rows to tty (for testing)
      Write (fField.FieldName, ' = ');
      if fField.IsNull then write ('NULL')else write(fField.Value);
      // Now the same rows into variable
      if fField.IsNull then ConfigLines[i,j]:='NULL'
        else ConfigLines[i,j]:=fField.Value;
      Inc(j);
    end;
    writeLn;
    fQuery.Next;
    Inc(i);
  end;
  // Close Query
  fQuery.Close;
end;

constructor TDBMgr.Create;
var
  i: word;
begin
  //InitialiseMySQL;
  fList:= TStrings.Create;
  //GetConnectionList(fList);
  //for i:= 0 to fList.Count do WriteLn(FList.Text[i]);
  //fList.Free;
  fConn := TSQLConnector.Create(nil);
  with fConn do begin
    // How to point to mysql5.7 ?
    ConnectorType := 'libmysql';
    HostName := db_host;
    DatabaseName:= db_Name;
    UserName:=db_user;
    Password:=db_pass;
    Transaction:=TSQLTransaction.Create(nil);
  end;
  fQuery:=TSQLQuery.Create(nil);
  fQuery.Database:=fConn;
end;

destructor TDBMgr.Destroy;
begin
  //ReleaseMySQL;
  fQuery.free;
  fConn.Free;
  inherited Destroy;
end;

end.

