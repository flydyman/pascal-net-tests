unit srvConsts;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  // Here will be stored our server constants
  // 1. DB constants
  db_host = 'localhost';//that is my home server: '192.168.1.7';
  db_port = '3306';
  db_name = 'testdb';//That is my another chema: 'dev_testo';
  db_user = 'test';
  db_pass = 'testtest';
  db_conf = 'config';
  db_accs = 'accounts';


  // 2. Config values to simplify searching
  cfg_Verify_Subject = 'VerifySubject';
  cfg_Verify_URL = 'VerifyUrl';
  cfg_Verify_Line1 = 'Verify01';
  cfg_Verify_Line2 = 'Verify02';
  cfg_Verify_Line3 = 'Verify03';

  // 3. Server statuses
  ss_Init = 0;
  ss_Run = 1;
  ss_Exiting = 2;

  // 4. Accounts values
  acc_ID = 'id';
  acc_Mail = 'email';
  acc_Pass = 'pass';
  acc_isVerified = 'isVerified';
  acc_isBlocked = 'isBlocked';
  acc_isBanned = 'isBanned';
  acc_acLevel = 'acc_Level';
  acc_Registered = 'reg_date';
  acc_LastLogin = 'last_login';
  acc_LastIP = 'last_ip';
  acc_isOnline = 'isOnline';

  // 5. Server settings
  srv_port = 54312;

  // 6. Parser-to-server commands
  /// TODO: move to DB cause it's MMORPG relevant
  msg_Idle = 'idl';
  msg_Move = 'mov';
  msg_Attack = 'att';
  msg_Skill = 'skl';
  msg_Interract = 'int';
  msg_Teleport = 'tel';
  msg_Say = 'say';
  msg_Talk = 'tal';
  msg_Send = 'sen';
  msg_BroadCast = 'bct';
  msg_MakeParty = 'mpt';
  msg_JoinParty = 'jpt';
  msg_LeaveParty = 'lpt';
  msg_DisbandParty = 'dpt';
  msg_GetItem = 'git';
  msg_DropItem = 'dit';
  msg_UseItem = 'uit';
  msg_MoveItem = 'mit';

  msg_Login = 'lin';
  msg_logout = 'lou';
  msg_Unknown = '';
  msg_Quit = 'qui';

implementation

end.

