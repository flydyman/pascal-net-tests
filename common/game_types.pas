unit game_types;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
    // Message system
    TMessage = record
      id: string[3];
      arg_s: array of string;
    end;

    // Coordinate system
    TVector2D = record
      X, Y: int64;
    end;

    TVector3D = record
      X, Y, Z: int64;
    end;

    TVector4D = record
      X, Y, Z, T: int64;
    end;

implementation

end.

