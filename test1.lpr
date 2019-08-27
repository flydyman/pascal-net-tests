program test1;

uses
  {$IFDEF UNIX}
  cthreads, cmem,
  {$ENDIF}
  dbManager, srvConsts, srvVars, sysutils, classes, accManager, connMgr;

var
  srv_Thread: word;
  msg: TMessage;
  i: byte;

begin
  /// TODO: say 'Hello', show version, licence and other stuff
  WriteLn('Network testing suit: Test1');
  WriteLn('More info at https://github.com/flydyman/pascal-net-tests');
  dbm.LoadConfig;
  //srv_Thread:=1;
  //BeginThread(@Server.Run,Pointer(srv_Thread));
  msg.id:=msg_Idle;
  SetLength(msg.arg_s, 5);
  for i:= 0 to 4 do
    msg.arg_s[i]:='aabbccc';
  WriteLn(Encode(Decode(Encode(Decode(Encode(msg))))));
  While ServerStatus = ss_Run do ;
end.

