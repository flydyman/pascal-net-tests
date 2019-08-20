program test1;

uses dbManager, srvConsts, srvVars;

var
  db: TDBMgr;
begin
  db:=TDBMgr.Create;
  db.LoadConfig;
  db.free;
end.

