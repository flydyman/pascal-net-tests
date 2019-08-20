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



implementation

end.

