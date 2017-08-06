unit NiceCustomPanelList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  LCLType;

type
  TPanelLine = class(TPanel)

  end;

  TNiceCustomPanelList = class(TScrollBox)
  private
    { Private declarations }
    FList: TList;
    FComponent: TCustomControl;
  protected
    { Protected declarations }
  public
    { Public declarations }

    procedure SetComponent(AVal: TCustomControl);
    function CreateComponent: TCustomControl;
  published
    { Published declarations }
    constructor Create(AOwner: TComponent);
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('priyatna.org',[TNiceCustomPanelList]);
end;

constructor TNiceCustomPanelList.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  fCompStyle:= csScrollBox;
  ControlStyle := ControlStyle + [csCaptureMouse];
  AutoScroll := True;
  BorderStyle := bsSingle;

  FList := TList.Create;
  FComponent := nil;
end;

procedure TNiceCustomPanelList.SetComponent(AVal: TCustomControl);
begin
  FComponent := AVal;
end;

function TNiceCustomPanelList.CreateComponent: TCustomControl;
begin
  Result := FComponent.Create(self);
  if FList.Count = 0 then Result.Top := 0
  else Result.Top := TCustomControl(FList[FList.Count - 1]).Top +
                     TCustomControl(FList[FList.Count - 1]).Height + 1;
  Result.Left := 0;
  Result.Align := alTop;
  Result.Parent := self;
  Result.Show;
  FList.Add(Result);
end;

end.
