program test6cli;
{$mode objfpc}{$M+}{$H+}
uses
  {$IFDEF UNIX}
  CTHREADS, CMEM,
  {$ENDIF}
  classes, sysutils, crt, lnet, base64;

type
  TClient = class
  private
    procedure Receive(s: TLSocket);
    procedure Error(const m: string; s: TLSocket);
  end;

var
  Conn: TLTCP;
  Client: TClient;
  q: boolean = false;
  msg: string;

procedure TClient.Error(const m: string; s: TLSocket);
begin
  Writeln('Error: ',m);
  q:=true;
end;

procedure TClient.Receive(s :TLSocket);
var
  m: string;
begin
  if s.GetMessage(m)>0 then begin
    WriteLn('[REC] <',s.peerAddress,'> ', m);
    m:= DecodeStringBase64(m);
    WriteLn('[REC] ->', m);
  end;
end;

procedure ReadM;
var
  c: char;
begin
  //ReadLn(msg);
  ReadLn(msg);
  if msg = '' then q:=true else Conn.SendMessage(msg);
  //EndThread(ReadM);
end;

begin
  Client:= TClient.Create;
  Conn := TLTCP.Create(nil);
  Conn.OnReceive:=@Client.Receive;
  Conn.OnError:=@Client.Error;
  if Conn.Connect('localhost',1366) then
  //BeginThread(@ReadM);
  repeat
    Conn.CallAction;
    ReadM;
    Conn.CallAction;
  until q else WriteLn('Not connected');
  if Conn.Connected then Conn.Disconnect;
  conn.Free;
  Client.Free;
end.

