program test6;

{$mode objfpc}{$M+}{$H+}
uses
  {$IFDEF UNIX}
  CTHREADS, CMEM,
  {$ENDIF}
  classes, sysutils, crt, lnet, base64;

type
  TServer = class
  private
    procedure Receive(s: TLSocket);
    procedure Error(const m: string; s: TLSocket);
  end;

var
  Conn: TLTCP;
  q: boolean = false;
  Server: TServer;

procedure TServer.Error(const m: string; s: TLSocket);
begin
  WriteLn('[ERR] <',s.PeerAddress,'> ',m);
end;

procedure TServer.Receive(s: TLSocket);
var
  m: string;
begin
  if s.GetMessage(m)>0 then begin
    Writeln('[REC] <', s.PeerAddress,'> ', m);
    m:=EncodeStringBase64(m);
    s.SendMessage(m);
  end else writeln('[REC] is null');
end;

begin
  Server:= TServer.Create;
  Conn:= TLTCP.Create(nil);
  Conn.OnReceive:=@Server.Receive;
  Conn.OnError:=@Server.Error;

  if Conn.Listen(1366) then begin
    WriteLn('Listening...');
    repeat
      Conn.CallAction;
      if KeyPressed then
      case ReadKey of
        'q': q:=true;
      end;
    until q;
  end;
  WriteLn('Stopped!');
  conn.Free;
  Server.Free;
end.

