unit dbManager;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql57dyn, srvConsts, srvVars;

type
  TDBMgr = class
  private
    fDBCon : integer;
  public
    procedure LoadConfig;
    constructor Create;
    destructor Destroy;
  end;

implementation

procedure TDBMgr.LoadConfig;
begin
  // Load
end;

constructor TDBMgr.Create;
begin
  InitialiseMySQL;
end;

destructor TDBMgr.Destroy;
begin
  ReleaseMySQL;
  inherited Destroy;
end;

end.

