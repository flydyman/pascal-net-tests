# pascal-net-tests
Pascal Net Tests<br>
This was Initial commit, so there is nothing to do atm. Just keep in mind: I've just started.<br>
furaidi<br>

What does it contain:
 - srvVars.pas - server variables
 - srvConsts.pas - server constants
 - dbManager.pas - custom DB manager with MySQL 5.7 support (other DBs will be added ASAP (or never))
 - test1.lpr - initial tests (connect to db etc)
 - dump-testdb.sql - dump of test DB
 - accManager.pas - account management
 - connMgr.pas - serverside socket manager

Requirements:
 - lnet v0.6 - place in upper directory out of source, f.e. if you cloned this repository in
 ~/scr/pascal-net-tests, place lnet like ~/src/lnet
 - you can modify all pathes in Lazarus IDE (Project settings, Ctrl+Shift+F11)

Is it builds?
 - yes (linux-i386, linux-x86_64, win32, win64)
 
Is it tested somehow?
 - yes (linux-i386, linux-x86_64)
 - no (win32, win64) - reason: I don't have any atm
