unit connMgr;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF UNIX}
  cthreads, cmem,
  {$ENDIF} Classes, SysUtils, srvVars, srvConsts, lnet, crt;

type
  TServer = class
  private
    fConn: TLTCP;
    procedure OnAccept(s: TLSocket);
    procedure OnReceive(s: TLSocket);
    procedure OnDisconnect(s :TLSocket);
    procedure OnError(const msg: string; s: TLSocket);
  public
    constructor Create; //override;
    destructor Destroy; override;
    function Run(p:pointer):ptrint;
  end;

var
  Server: TServer;

implementation

function TServer.Run(p:pointer):ptrint;
Begin
  // Has self loop, cause that will be a thread
  ServerStatus:=ss_Run;
  if fConn.Listen(srv_Port) then begin
    Writeln('[LNET] Waiting for connections');
    while ServerStatus = ss_Run do begin
        fConn.CallAction;
        if Keypressed then if ReadKey = 'q' then ServerStatus:=ss_Exiting;
        Sleep(0);
    end;
  end else begin
    WriteLn('[LNET] Port #',srv_Port,' is busy atm');
    ServerStatus:=ss_Exiting;
  end;
  Run:=0;
  EndThread(Run);
end;

procedure TServer.OnAccept(s: TLSocket);
begin
  WriteLn('[CONN] <',s.PeerAddress,'> ');
end;

procedure TServer.OnReceive(s: TLSocket);
var
  message: string;
  i: integer;
begin
  if s.GetMessage(message)>0 then begin
    // who is it and what he wants?
    /// TODO: check'n'parse
    // maybe even answer to him...
    /// TODO: send
  end;

end;

procedure TServer.OnDisconnect(s :TLSocket);
begin
  WriteLn('[DCONN] <',s.PeerAddress,'>');
end;

procedure TServer.OnError(const msg: string; s: TLSocket);
begin
  WriteLn('[ERROR] <',s.PeerAddress,'> : ', msg);
end;

constructor TServer.Create;
begin
  fConn := TLTCP.Create(nil);
  fConn.OnAccept:=@OnAccept;
  fConn.OnDisconnect:=@OnDisconnect;
  fConn.OnError:=@OnError;
  FConn.OnReceive:=@OnReceive;
  fConn.Timeout:=10;

end;

destructor TServer.Destroy;
begin
  /// TODO: Close all connections
  fConn.Free;
  inherited Destroy;
end;

initialization
  Server:=TServer.Create;

finalization
  Server.Free;

end.

