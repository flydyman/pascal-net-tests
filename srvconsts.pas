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

implementation

end.

