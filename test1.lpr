program test1;

uses
  dbManager, srvConsts, srvVars, sysutils, classes, accManager, connMgr;

begin
  /// TODO: say 'Hello', show version, licence and other stuff
  WriteLn('Network testing suit: Test1');
  WriteLn('More info at https://github.com/flydyman/pascal-net-tests');
  dbm.LoadConfig;
end.

