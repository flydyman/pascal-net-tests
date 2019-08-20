unit srvVars;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  // x - rows
  // y - cols
  TConfigLines = array of array [0..1] of string;

  TVerifyMail = record
    Subject: string;
    Lines: array [1..3] of string;
    URL: string;
  end;

var
  VerifyMail: TVerifyMail;
  ConfigLines: TConfigLines;
implementation

end.

