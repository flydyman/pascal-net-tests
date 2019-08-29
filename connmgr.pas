unit connMgr;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF UNIX}
  cthreads, cmem,
  {$ENDIF} Classes, SysUtils, srvVars, srvConsts, lnet, crt,
  game_types;

type

  TServer = class
  private
    //fConn: TLTCP;
    procedure OnAccept(s: TLSocket);
    procedure OnReceive(s: TLSocket);
    procedure OnDisconnect(s :TLSocket);
    procedure OnError(const msg: string; s: TLSocket);
  public
    constructor Create; //override;
    destructor Destroy; override;
    //function Run(p:pointer):ptrint;
  end;

var
  Server: TServer;
  Connection: TLTCP;

implementation

{function TServer.Run(p:pointer):ptrint;
Begin
  // Has self loop, cause that will be a thread
  /// TODO: that's not work, need to rewrite something
  {ServerStatus:=ss_Run;
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
  EndThread(Run);}

  // ...Changing to external connection need to call from main thread
end;     }

procedure TServer.OnAccept(s: TLSocket);
begin
  WriteLn('[CONN] <',s.PeerAddress,'> ');
end;

procedure TServer.OnReceive(s: TLSocket);
var
  message, s1: string;
  msg: TMessage;
  i: integer;
begin
  if s.GetMessage(message)>0 then begin
    // who is it and what he wants?
    /// TODO: check'n'parse
    msg := Decode(message);
    case msg.id of
      msg_Idle: begin
        // Idling
      end;
      msg_Move: begin
        // Moving
      end;
    end;
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
  // Internal Connection
  {fConn := TLTCP.Create(nil);
  fConn.OnAccept:=@OnAccept;
  fConn.OnDisconnect:=@OnDisconnect;
  fConn.OnError:=@OnError;
  FConn.OnReceive:=@OnReceive;
  fConn.Timeout:=10;}

  // External connection
  Connection := TLTCP.Create(nil);
  Connection.OnAccept:=@OnAccept;
  Connection.OnDisconnect:=@OnDisconnect;
  Connection.OnError:=@OnError;
  Connection.OnReceive:=@OnReceive;
  Connection.Timeout:=10;

end;

destructor TServer.Destroy;
begin
  /// TODO: Close all connections
  //fConn.Free;
  Connection.Free;
  inherited Destroy;
end;

initialization
  Server:=TServer.Create;

finalization
  Server.Free;

end.

