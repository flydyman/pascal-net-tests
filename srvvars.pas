unit srvVars;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, srvConsts;

type
  // x - rows
  // y - cols
  TConfigLines = array of array [0..2] of string;

  TAccount = packed record
    id: int64;
    mail: string;
    pass: string;
    isVerified:boolean;
    isBanned:boolean;
    isBlocked:boolean;
    isOnline:boolean;
    acLevel: integer;
    LastIP:string;
    RegDate: string;
    LastDate: string;
  end;
  PAccount = ^TAccount;

  TAccList = class (TList)
  private
    function Get(i: integer):PAccount;
  public
    destructor Destroy; override;
    function Add(p: PAccount): integer;
    property Items [i:integer]: PAccount read Get; default;
  end;

  TVerifyMail = record
    Subject: string;
    Lines: array [1..3] of string;
    URL: string;
  end;
  //TDBLList = array of array of string;
  //PDBLList = ^TDBLList;

var
  VerifyMail: TVerifyMail;
  ConfigLines: TConfigLines;
  ServerStatus: byte = 0;
  Accounts: TAccList;

function GetConfigValue(Parameter: string):string;

implementation

function TAccList.Get(i:integer):PAccount;
begin
  Result:= PAccount (inherited Get(i));
end;

function TAccList.Add(p:PAccount):integer;
begin
  Result := inherited Add(p);
end;

destructor TAccList.Destroy;
var
  i: integer;
begin
  for i:=0 to Count -1 do
    Freemem(Items[i]);
  inherited Destroy;
end;

function GetConfigValue(Parameter: string):string;
var
  i: longint;
  res: string;
begin
  res:='';
  for i:= 0 to High(ConfigLines) do
    if ConfigLines[i,1] = Parameter then res:= ConfigLines[i,2];

  GetConfigValue:=res;
end;

end.

