unit srvVars;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, srvConsts, strings;

type
  // Message system
  TMessage = record
    id: string[3];
    arg_s: array of string;
  end;

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
  //Srv_Thread: word;

function GetConfigValue(Parameter: string):string;
function Encode(msg: TMessage): string;
function Decode(input: string): TMessage;

implementation

function Encode(msg: TMessage): string;
var
  tmp: TStringList;
  i: byte;
begin
  tmp:=TStringList.Create;
  tmp.Delimiter:='|';
  tmp.Add(msg.id);
  for i:= 0 to high(msg.arg_s) do tmp.Add(msg.arg_s[i]);
  result:=tmp.DelimitedText;
  //WriteLn('[DBG] Encoded: ',result);
  tmp.Free;
end;

function Decode(input: string): TMessage;
var
  tmp:TStringList;
  i: byte;
  msg: TMessage;
begin
  tmp:= TStringList.Create;
  tmp.Delimiter:='|';
  tmp.DelimitedText:=input;
  msg.id:=tmp.Strings[0];
  SetLength(msg.arg_s,tmp.Count-1); // cause [0] is a command byte
  for i:=1 to tmp.Count-1 do begin
    msg.arg_s[i-1]:=tmp.Strings[i];
  end;
  result:=msg;
  tmp.Free;
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

