unit NicePageControl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ComCtrls;

type
  TOnAddTabSheet = procedure(Sender: TObject) of object;

  TNicePageControl = class(TPageControl)
  private
    { Private declarations }
    FOnAddTabSheet: TOnAddTabSheet;
  protected
    { Protected declarations }
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
  public
    { Public declarations }
    function AddTabSheet: TTabSheet; reintroduce;
  published
    { Published declarations }
    property OnAddTabSheet: TOnAddTabSheet read FOnAddTabSheet write FOnAddTabSheet;
    property Color;
    Property ParentColor;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I nicepagecontrol_icon.lrs}
  RegisterComponents('priyatna.org',[TNicePageControl]);
end;

procedure TNicePageControl.DoAddDockClient(Client: TControl; const ARect: TRect);
begin
  inherited DoAddDockClient(Client, ARect);
  if Assigned(FOnAddTabSheet) then
    FOnAddTabSheet(Self);
end;
function TNicePageControl.AddTabSheet: TTabSheet;
begin
  inherited AddTabSheet;
  if Assigned(FOnAddTabSheet) then
    FOnAddTabSheet(Self);
end;

end.
