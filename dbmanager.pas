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
    //fList: Tstrings;
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
  /// TODO: try/except must be added
  SetLength(ConfigLines,fQuery.RecordCount);
  while not fQuery.EOF do begin
    j:=0;
    for fField in fQuery.Fields do begin
      /// TODO: output must be removed after tests
      // Fetch rows to tty (for testing)
      //Write (fField.FieldName, ' = ');
      //if fField.IsNull then write ('NULL')else write(fField.Value);
      // Now the same rows into variable
      if fField.IsNull then ConfigLines[i,j]:='NULL'
        else ConfigLines[i,j]:=fField.Value;
      Inc(j);
      //write ('   ||   ');
    end;
    //writeLn;
    fQuery.Next;
    Inc(i);
  end;
  // Close Query
  fQuery.Close;
  /// TODO: Theese lines must be removed after tests
  // Little test: Displaying array
  WriteLn('Displaying ConfigLines:');
  for i:=0 to High(ConfigLines) do begin
    for j:=0 to High(ConfigLines[i]) do
      Write(ConfigLines[i,j],'  |  ');
    WriteLn;
  end;
end;

constructor TDBMgr.Create;
var
  i: word;
begin
  //InitialiseMySQL;
  //fList:= TStrings.Create;
  //GetConnectionList(fList);
  //for i:= 0 to fList.Count do WriteLn(FList.Text[i]);
  //fList.Free;
  fConn := TSQLConnector.Create(nil);
  with fConn do begin
    // How to point to mysql5.7 ?
    //ConnectorType := mysqlvlib;
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
  //ReleaseMySQL;
  fQuery.free;
  fConn.Free;
  inherited Destroy;
end;

end.

