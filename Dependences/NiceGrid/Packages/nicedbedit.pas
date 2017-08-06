unit NiceDBEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, DbCtrls;

type
  TNiceDBEdit = class(TDBEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property Align;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I nicedbedit_icon.lrs}
  RegisterComponents('priyatna.org',[TNiceDBEdit]);
end;

end.
