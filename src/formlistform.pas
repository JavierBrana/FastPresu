unit formListForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil,
  BGRABitmapTypes, BCTypes, BCPanel, BCButton,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, contnrs;

type

  { TListForm }

  TListForm = class(TForm)
  private
    { private declarations }
    bNew: TBCButton;
    bEdit: TBCButton;
    bDuplicate: TBCButton;
    bDelete: TBCButton;
    bPrint: TBCButton;
    bClose: TBCButton;
    SeparatorBevel: TBevel;
  public
    { public declarations }
    constructor Create(TheOwner: TComponent); override;
    procedure CreateToolBar(Panel: TBCPanel); virtual;
    procedure DestroyToolBar;
    procedure New(Sender: TObject); virtual;
    procedure Edit(Sender: TObject); virtual;
    procedure Duplicate(Sender: TObject); virtual;
    procedure Print(Sender: TObject); virtual;
    procedure Delete(Sender: TObject); virtual;
    procedure CloseWindow(Sender: TObject); virtual;
  end;

//var ListForm: TListForm;

implementation
uses
  formMainWindow;
{$R *.lfm}

{ TListForm }
constructor TListForm.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  bNew := nil;
  bEdit := nil;
  bDuplicate := nil;
  bDelete := nil;
  bPrint := nil;
  Visible := false;
end;

procedure TListForm.CreateToolBar(Panel: TBCPanel);
var
  i: integer;
  Functions: array [0..5] of procedure(Sender: TObject) of object;
  Buttons: TObjectList;

  procedure SetStyle(Button:TBCButton);
  begin
    with Button do
    begin
      Parent := Panel;
      Width := 40;
      Height := Panel.Height - 4;
      Top := 2;
      Align := alLeft;

      StateClicked.Background.Color := 15981500;
      StateClicked.Background.ColorOpacity := 255;
      StateClicked.Background.Gradient1.StartColor := 15981500;
      StateClicked.Background.Gradient1.StartColorOpacity := 255;
      StateClicked.Background.Gradient1.DrawMode := dmSet;
      StateClicked.Background.Gradient1.EndColor := 16312531;
      StateClicked.Background.Gradient1.EndColorOpacity := 255;
      StateClicked.Background.Gradient1.ColorCorrection := True;
      StateClicked.Background.Gradient1.GradientType := gtLinear;
      StateClicked.Background.Gradient1.Point1XPercent := 0;
      StateClicked.Background.Gradient1.Point1YPercent := 0;
      StateClicked.Background.Gradient1.Point2XPercent := 0;
      StateClicked.Background.Gradient1.Point2YPercent := 100;
      StateClicked.Background.Gradient1.Sinus := False;
      StateClicked.Background.Gradient2.StartColor := 16113605;
      StateClicked.Background.Gradient2.StartColorOpacity := 255;
      StateClicked.Background.Gradient2.DrawMode := dmSet;
      StateClicked.Background.Gradient2.EndColor := 15981500;
      StateClicked.Background.Gradient2.EndColorOpacity := 255;
      StateClicked.Background.Gradient2.ColorCorrection := True;
      StateClicked.Background.Gradient2.GradientType := gtLinear;
      StateClicked.Background.Gradient2.Point1XPercent := 0;
      StateClicked.Background.Gradient2.Point1YPercent := 0;
      StateClicked.Background.Gradient2.Point2XPercent := 0;
      StateClicked.Background.Gradient2.Point2YPercent := 100;
      StateClicked.Background.Gradient2.Sinus := False;
      StateClicked.Background.Gradient1EndPercent := 100;
      StateClicked.Background.Style := bbsColor;
      StateClicked.Border.Color := 15448451;
      StateClicked.Border.ColorOpacity := 255;
      StateClicked.Border.LightColor := 16312531;
      StateClicked.Border.LightOpacity := 255;
      StateClicked.Border.LightWidth := 0;
      StateClicked.Border.Style := bboSolid;
      StateClicked.Border.Width := 1;
      StateClicked.FontEx.Color := clBlack;
      StateClicked.FontEx.EndEllipsis := False;
      StateClicked.FontEx.FontQuality := fqSystemClearType;
      StateClicked.FontEx.Height := 11;
      StateClicked.FontEx.Name := 'Verdana';
      StateClicked.FontEx.SingleLine := True;
      StateClicked.FontEx.Shadow := False;
      StateClicked.FontEx.ShadowColor := clBlack;
      StateClicked.FontEx.ShadowColorOpacity := 255;
      StateClicked.FontEx.ShadowRadius := 5;
      StateClicked.FontEx.ShadowOffsetX := 5;
      StateClicked.FontEx.ShadowOffsetY := 5;
      StateClicked.FontEx.Style := [];
      StateClicked.FontEx.TextAlignment := bcaCenter;
      StateClicked.FontEx.WordBreak := False;
      StateHover.Background.Color := clBlack;
      StateHover.Background.ColorOpacity := 255;
      StateHover.Background.Gradient1.StartColor := 16577773;
      StateHover.Background.Gradient1.StartColorOpacity := 255;
      StateHover.Background.Gradient1.DrawMode := dmSet;
      StateHover.Background.Gradient1.EndColor := 16310217;
      StateHover.Background.Gradient1.EndColorOpacity := 255;
      StateHover.Background.Gradient1.ColorCorrection := True;
      StateHover.Background.Gradient1.GradientType := gtLinear;
      StateHover.Background.Gradient1.Point1XPercent := 0;
      StateHover.Background.Gradient1.Point1YPercent := 0;
      StateHover.Background.Gradient1.Point2XPercent := 0;
      StateHover.Background.Gradient1.Point2YPercent := 100;
      StateHover.Background.Gradient1.Sinus := False;
      StateHover.Background.Gradient2.StartColor := 16310217;
      StateHover.Background.Gradient2.StartColorOpacity := 255;
      StateHover.Background.Gradient2.DrawMode := dmSet;
      StateHover.Background.Gradient2.EndColor := 16577773;
      StateHover.Background.Gradient2.EndColorOpacity := 255;
      StateHover.Background.Gradient2.ColorCorrection := True;
      StateHover.Background.Gradient2.GradientType := gtLinear;
      StateHover.Background.Gradient2.Point1XPercent := 0;
      StateHover.Background.Gradient2.Point1YPercent := 0;
      StateHover.Background.Gradient2.Point2XPercent := 0;
      StateHover.Background.Gradient2.Point2YPercent := 100;
      StateHover.Background.Gradient2.Sinus := False;
      StateHover.Background.Gradient1EndPercent := 100;
      StateHover.Background.Style := bbsGradient;
      StateHover.Border.Color := 15515276;
      StateHover.Border.ColorOpacity := 255;
      StateHover.Border.LightColor := 16577773;
      StateHover.Border.LightOpacity := 255;
      StateHover.Border.LightWidth := 1;
      StateHover.Border.Style := bboSolid;
      StateHover.Border.Width := 1;
      StateHover.FontEx.Color := clBlack;
      StateHover.FontEx.EndEllipsis := False;
      StateHover.FontEx.FontQuality := fqSystemClearType;
      StateHover.FontEx.Height := 11;
      StateHover.FontEx.Name := 'Verdana';
      StateHover.FontEx.SingleLine := True;
      StateHover.FontEx.Shadow := False;
      StateHover.FontEx.ShadowColor := clBlack;
      StateHover.FontEx.ShadowColorOpacity := 255;
      StateHover.FontEx.ShadowRadius := 5;
      StateHover.FontEx.ShadowOffsetX := 5;
      StateHover.FontEx.ShadowOffsetY := 5;
      StateHover.FontEx.Style := [];
      StateHover.FontEx.TextAlignment := bcaCenter;
      StateHover.FontEx.WordBreak := False;
      StateNormal.Background.Color := clBlack;
      StateNormal.Background.ColorOpacity := 255;
      StateNormal.Background.Gradient1.StartColor := clWhite;
      StateNormal.Background.Gradient1.StartColorOpacity := 255;
      StateNormal.Background.Gradient1.DrawMode := dmSet;
      StateNormal.Background.Gradient1.EndColor := 15855597;
      StateNormal.Background.Gradient1.EndColorOpacity := 255;
      StateNormal.Background.Gradient1.ColorCorrection := True;
      StateNormal.Background.Gradient1.GradientType := gtLinear;
      StateNormal.Background.Gradient1.Point1XPercent := 0;
      StateNormal.Background.Gradient1.Point1YPercent := 0;
      StateNormal.Background.Gradient1.Point2XPercent := 0;
      StateNormal.Background.Gradient1.Point2YPercent := 100;
      StateNormal.Background.Gradient1.Sinus := False;
      StateNormal.Background.Gradient2.StartColor := 13137169;
      StateNormal.Background.Gradient2.StartColorOpacity := 255;
      StateNormal.Background.Gradient2.DrawMode := dmSet;
      StateNormal.Background.Gradient2.EndColor := 15722194;
      StateNormal.Background.Gradient2.EndColorOpacity := 255;
      StateNormal.Background.Gradient2.ColorCorrection := True;
      StateNormal.Background.Gradient2.GradientType := gtLinear;
      StateNormal.Background.Gradient2.Point1XPercent := 0;
      StateNormal.Background.Gradient2.Point1YPercent := 0;
      StateNormal.Background.Gradient2.Point2XPercent := 0;
      StateNormal.Background.Gradient2.Point2YPercent := 100;
      StateNormal.Background.Gradient2.Sinus := False;
      StateNormal.Background.Gradient1EndPercent := 100;
      StateNormal.Background.Style := bbsClear;
      StateNormal.Border.Color := 13816015;
      StateNormal.Border.ColorOpacity := 255;
      StateNormal.Border.LightColor := clWhite;
      StateNormal.Border.LightOpacity := 255;
      StateNormal.Border.LightWidth := 1;
      StateNormal.Border.Style := bboNone;
      StateNormal.Border.Width := 1;
      StateNormal.FontEx.Color := clBlack;
      StateNormal.FontEx.EndEllipsis := False;
      StateNormal.FontEx.FontQuality := fqSystemClearType;
      StateNormal.FontEx.Height := 11;
      StateNormal.FontEx.Name := 'Verdana';
      StateNormal.FontEx.SingleLine := True;
      StateNormal.FontEx.Shadow := False;
      StateNormal.FontEx.ShadowColor := clBlack;
      StateNormal.FontEx.ShadowColorOpacity := 255;
      StateNormal.FontEx.ShadowRadius := 5;
      StateNormal.FontEx.ShadowOffsetX := 5;
      StateNormal.FontEx.ShadowOffsetY := 5;
      StateNormal.FontEx.Style := [];
      StateNormal.FontEx.TextAlignment := bcaCenter;
      StateNormal.FontEx.WordBreak := False;
      BorderSpacing.Around := 2;
      Caption := 'Back;';
      Color := clNone;
      DropDownWidth := 16;
      DropDownArrowSize := 8;
      GlobalOpacity := 255;
      GlyphMargin := 4;
      ParentColor := False;
      Rounding.RoundX := 2;
      Rounding.RoundY := 2;
      Rounding.RoundOptions := [];
      RoundingDropDown.RoundX := 1;
      RoundingDropDown.RoundY := 1;
      RoundingDropDown.RoundOptions := [];
      TextApplyGlobalOpacity := False;
      Images := MainWindow.General_16;
      ShowCaption := False;
    end;
	end;

begin
  SeparatorBevel := TBevel.Create(Panel);
  SeparatorBevel.Parent := Panel;
  SeparatorBevel.Align:=alLeft;
  SeparatorBevel.Width:=5;
  SeparatorBevel.BorderSpacing.Left:=80;
  SeparatorBevel.BorderSpacing.Top := 2;
  SeparatorBevel.BorderSpacing.Bottom := 2;
  SeparatorBevel.Shape := bsLeftLine;


  Functions[0] := @New;
  Functions[1] := @Edit;
  Functions[2] := @Delete;
  Functions[3] := @Print;
  Functions[4] := @Duplicate;
  Functions[5] := @CloseWindow;

  bNew := TBCButton.Create(Panel);
  bEdit := TBCButton.Create(Panel);
  bDuplicate := TBCButton.Create(Panel);
  bDelete := TBCButton.Create(Panel);
  bPrint := TBCButton.Create(Panel);
  bClose := TBCButton.Create(Panel);

  Buttons := TObjectList.create(false);
  Buttons.Add(bNew);
  Buttons.Add(bEdit);
  Buttons.Add(bDelete);
  Buttons.Add(bPrint);
  Buttons.Add(bDuplicate);
  Buttons.Add(bClose);

  for i := 0 to 5 do
  begin
    SetStyle(TBCButton(Buttons[i]));
    with TBCButton(Buttons[i]) do
    begin
      Parent := Panel;
      OnClick := Functions[i];
      ImageIndex := i;
      Left := 150 + Width * i;
    end;
	end;

  bClose.Align:=alRight;
  bClose.ImageIndex:= 6;
end;


procedure TListForm.DestroyToolBar;
  procedure DeleteButton(Button: TObject);
  begin
    if not Assigned(Button) then exit;
    Button.Destroy;
    Button := nil;
  end;
begin
  DeleteButton(SeparatorBevel);
	DeleteButton(bNew);
  DeleteButton(bEdit);
  DeleteButton(bDuplicate);
  DeleteButton(bDelete);
  DeleteButton(bPrint);
  DeleteButton(bClose);
end;

procedure TListForm.New(Sender: TObject);
begin
end;

procedure TListForm.Edit(Sender: TObject);
begin
end;

procedure TListForm.Duplicate(Sender: TObject);
begin
end;

procedure TListForm.Delete(Sender: TObject);
begin
end;

procedure TListForm.Print(Sender: TObject);
begin
end;

procedure TListForm.CloseWindow(Sender: TObject);
begin
  Close;
end;
end.
