unit srvVars;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, srvConsts;

type
  // x - rows
  // y - cols
  TConfigLines = array of array [0..2] of string;

  TAccount = class
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

  TVerifyMail = record
    Subject: string;
    Lines: array [1..3] of string;
    URL: string;
  end;

var
  VerifyMail: TVerifyMail;
  ConfigLines: TConfigLines;
  ServerStatus: byte = 0;
  Accounts: TList;
  //Server: TServer;

function GetConfigValue(Parameter: string):string;

implementation

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

