program test1;

uses
  {$IFDEF UNIX}
  cthreads, cmem,
  {$ENDIF}
  dbManager, srvConsts, srvVars, sysutils, classes, accManager, connMgr;

var
  srv_Thread: word;

begin
  /// TODO: say 'Hello', show version, licence and other stuff
  WriteLn('Network testing suit: Test1');
  WriteLn('More info at https://github.com/flydyman/pascal-net-tests');
  dbm.LoadConfig;
  srv_Thread:=1;
  BeginThread(@Server.Run,Pointer(srv_Thread));
  While ServerStatus = ss_Run do ;
end.

