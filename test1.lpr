program test1;

uses
  {$IFDEF UNIX}
  cthreads, cmem,
  {$ENDIF}
  dbManager, srvConsts, srvVars, sysutils, classes, accManager, connMgr, game_types;

var
  srv_Thread: word;
  msg: TMessage;
  i: byte;

begin
  /// TODO: say 'Hello' and other stuff
  WriteLn('Network testing suit: Test1');
  WriteLn('More info at https://github.com/flydyman/pascal-net-tests');
  dbm.LoadConfig;

  // Uncomment to test parsing functions
  {msg.id:=msg_Idle;
  SetLength(msg.arg_s, 5);
  for i:= 0 to 4 do
    msg.arg_s[i]:='aabbccc';
  WriteLn(Encode(Decode(Encode(Decode(Encode(msg))))));
  }

  ServerStatus := ss_Run;
  if Connection.Listen(srv_Port) then begin
    while ServerStatus = ss_Run do begin
      // Eventizing connection
      Connection.CallAction;
      /// TODO: World NPCs actions

      /// TODO: Other stuff

    end;
  end else begin
    WriteLn('[NET] Cannot start listener on port ', srv_Port);
    ServerStatus:=ss_Exiting;
  end;
end.

