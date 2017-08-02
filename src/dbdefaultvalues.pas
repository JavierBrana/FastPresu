unit dbDefaultValues;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, u_units;

const

  AdminUser = 'USERS,1,ADMIN,,ADMIN,,0,,0,,,ADMIN';

  DBValues: array[1..1] of string = (AdminUser);


implementation

end.

