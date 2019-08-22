unit accManager;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, md5, srvVars, srvConsts, dbManager;

type
  TAccMgr = class
  protected
    //Accounts: TList;
  public
    procedure Run;
    constructor Create;
    destructor Destroy; override;
  end;

var
  AccountManager: TAccMgr;

implementation

// TAccMgr
procedure TAccMgr.Run;
var
  I: longInt;
  acc: TAccount;
begin
  //init

  //loop
  while ServerStatus = ss_Run do begin
    // Check accounts online
    // if not -> Save 'LastLogin' to DB
    for i:= 0 to Accounts.count-1 do
    begin

      Sleep (0); // Switch threads
    end;

    //Switch to another thread
    /// TODO: need to test "ms" value to reduce CPU usage issue
    Sleep(10);
  end;
  //discard

end;

constructor TAccMgr.Create;
begin
  Accounts := TAccList.Create;
  //Load accounts from DB
  dbm.LoadAccounts;
end;

destructor TAccMgr.Destroy;
begin

  Accounts.Free;
  inherited Destroy;
end;

initialization
  AccountManager := TAccMgr.Create;

finalization
  AccountManager.Free;

end.

