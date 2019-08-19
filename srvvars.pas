unit srvVars;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TVerifyMail = record
    Subject: string;
    Lines: array [1..3] of string;
    URL: string;
  end;

var
  VerifyMail: TVerifyMail;

implementation

end.

