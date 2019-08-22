unit connMgr;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF UNIX}
  cthreads, cmem,
  {$ENDIF} Classes, SysUtils, srvVars, srvConsts, Sockets;

type
  TServer = class (TTCPServer)

  public
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Server: TServer;

implementation

constructor TServer.Create (AOWner: TComponent);
begin

end;

destructor TServer.Destroy;
begin

  inherited Destroy;
end;

initialization
  Server:=TServer.Create(nil);

finalization
  Server.Free;

end.

