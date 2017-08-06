unit SpkRollPanel;

{$mode objfpc}{$H+}
interface

uses
    {$IFDEF MSWINDOWS}
  Windows,
    {$ELSE}
  LCLIntf, LCLType, LMessages,
    {$ENDIF}
  Classes, Graphics, Controls, Forms, ExtCtrls, Dialogs, spkdrawtools,
  StdCtrls, Buttons, SysUtils, Messages, Math, SpkAnimator, TypInfo;

type
  TGradientMode = (gmNone, gmUser, gmAuto);
  TGradientType = (gtVertical, gtHorizontal);
  TRollMode = (rmUnroll, rmRoll);
  TResizeMode = (rmNormal, rmResize);

type

  { TSpkRollPanel }

  TSpkRollPanel = class(TPanel)
  private
    // Pomocnicze
    FRollMode: TRollMode;
    FResizeMode: TResizeMode;
    FUnrollHeight: integer;
    FMouseDelta: integer;

    // W³aœciwoœci
    FMargin: integer;
    FMarginColor: TColor;
    FCaptionHeight: integer;
    FBorderColor: TColor;
    FAllowResize: boolean;
    FAnimate: boolean;
    FAnimator: TSpkAnimator;
    FHideChildren: boolean;
    FCanMove: boolean;
    down: boolean;
    mx, my: integer;

    FCaptionGradientMode: TGradientMode;
    FCaptionColorFrom, FCaptionColorTo: TColor;
    FCaptionGradientType: TGradientType;

    FPanelGradientMode: TGradientMode;
    FPanelColorFrom, FPanelColorTo: TColor;
    FPanelGradientType: TGradientType;
  protected
    procedure paint; override;

    procedure SetCaptionGradientMode(Value: TGradientMode);
    procedure SetCaptionColorFrom(Value: TColor);
    procedure SetCaptionColorTo(Value: TColor);
    procedure SetCaptionGradientType(Value: TGradientType);

    procedure SetPanelGradientMode(Value: TGradientMode);
    procedure SetPanelColorFrom(Value: TColor);
    procedure SetPanelColorTo(Value: TColor);
    procedure SetPanelGradientType(Value: TGradientType);

    procedure SetMargin(Value: integer);
    procedure SetMarginColor(Value: TColor);
    procedure SetCaptionHeight(Value: integer);
    procedure SetBorderColor(Value: TColor);
    procedure SetAllowResize(Value: boolean);
    procedure SetCanMove(Value: boolean);

    procedure MyOnLMouseButtonUp(
      var msg: TMessage) {$IFDEF MSWINDOWS} message WM_LBUTTONUP {$ELSE}
      message LM_LBUTTONUP {$ENDIF};
    procedure MyOnLMouseButtonDown(var msg: TMessage);
 {$IFDEF MSWINDOWS} message WM_LBUTTONDOWN {$ELSE} message LM_LBUTTONDOWN {$ENDIF};
    procedure MyOnMouseMove(var msg: TMessage);
 {$IFDEF MSWINDOWS} message WM_MOUSEMOVE {$ELSE} message LM_MOUSEMOVE {$ENDIF};

    procedure SetRollMode(ARollMode: TRollMode);

    procedure OnFinishAnimation(Sender: TObject);

    procedure HideComponents;
    procedure ShowComponents;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
  published
    property Margin: integer read FMargin write SetMargin;
    property MarginColor: TColor read FMarginColor write SetMarginColor;
    property CaptionHeight: integer read FCaptionHeight write SetCaptionHeight;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property AllowResize: boolean read FAllowResize write SetAllowResize;
    property Animate: boolean read FAnimate write FAnimate;
    property HideChildren: boolean read FHideChildren write FHideChildren;

    property RollMode: TRollMode read FRollMode write SetRollMode;

    property CaptionGradientMode: TGradientMode
      read FCaptionGradientMode write SetCaptionGradientMode;
    property CaptionColorFrom: TColor read FCaptionColorFrom
      write SetCaptionColorFrom;
    property CaptionColorTo: TColor read FCaptionColorTo write SetCaptionColorTo;
    property CaptionGradientType: TGradientType
      read FCaptionGradientType write SetCaptionGradientType;

    property PanelGradientMode: TGradientMode
      read FPanelGradientMode write SetPanelGradientMode;
    property PanelColorFrom: TColor read FPanelColorFrom write SetPanelColorFrom;
    property PanelColorTo: TColor read FPanelColorTo write SetPanelColorTo;
    property PanelGradientType: TGradientType
      read FPanelGradientType write SetPanelGradientType;
    property CanMove: boolean read FCanMove write SetCanMove;

  end;

procedure Register;

implementation
uses
  Themes;

{ TSpkRollPanel }

procedure Register;

begin
  RegisterComponents('SpookSoft', [TSpkRollPanel]);
end;

procedure TSpkRollPanel.SetCaptionGradientMode(Value: TGradientMode);

begin
  FCaptionGradientMode := Value;
  refresh;
end;

procedure TSpkRollPanel.SetCaptionColorFrom(Value: TColor);

begin
  FCaptionColorFrom := Value;
  refresh;
end;

procedure TSpkRollPanel.SetCaptionColorTo(Value: TColor);

begin
  FCaptionColorTo := Value;
  refresh;
end;

procedure TSpkRollPanel.SetCaptionGradientType(Value: TGradientType);

begin
  FCaptionGradientType := Value;
  refresh;
end;

procedure TSpkRollPanel.SetPanelGradientMode(Value: TGradientMode);

begin
  FPanelGradientMode := Value;
  refresh;
end;

procedure TSpkRollPanel.SetPanelColorFrom(Value: TColor);

begin
  FPanelColorFrom := Value;
  refresh;
end;

procedure TSpkRollPanel.SetPanelColorTo(Value: TColor);

begin
  FPanelColorTo := Value;
  refresh;
end;

procedure TSpkRollPanel.SetPanelGradientType(Value: TGradientType);

begin
  FPanelGradientType := Value;
  refresh;
end;

procedure TSpkRollPanel.SetMargin(Value: integer);

begin
  FMargin := Value;
  refresh;
end;

procedure TSpkRollPanel.SetMarginColor(Value: TColor);

begin
  FMarginColor := Value;
  refresh;
end;

procedure TSpkRollPanel.SetCaptionHeight(Value: integer);

begin
  FCaptionHeight := Value;
  refresh;
end;

procedure TSpkRollPanel.SetBorderColor(Value: TColor);

begin
  FBorderColor := Value;
  refresh;
end;

procedure TSpkRollPanel.SetAllowResize(Value: boolean);

begin
  FAllowResize := Value;
  refresh;
end;

procedure TSpkRollPanel.SetCanMove(Value: boolean);
begin
  FCanMove := Value;
  refresh;
end;

procedure TSpkRollPanel.MyOnLMouseButtonUp(var msg: TMessage);
var
  x, y: integer;
begin
  inherited;
  x := loword(msg.LParam);
  y := hiword(msg.LParam);
  down := False;
  if (x > Fmargin) and (x < self.Width - Fmargin - 1) and (y > Fmargin) and
    (y < Fmargin + CaptionHeight) then
  begin
    if (align in [alTop, alBottom, alNone]) then
    begin
      if FRollMode = rmUnroll then
        SetRollMode(rmRoll)
      else
        SetRollMode(rmUnroll);
    end;
  end;
end;

procedure TSpkRollPanel.SetRollMode(ARollMode: TRollMode);

begin
  if ARollMode = FRollMode then
    exit;
  if not (FAnimator.CanAnimate) then
    exit;
  if ARollMode = rmRoll then
  begin
    FUnrollHeight := self.Height;
    if FHideChildren then
      HideComponents;
    FRollMode := ARollMode;
    if FAnimate then
    begin
      FAnimator.Options.SquareMode := smMinus;
      FAnimator.animate(self.Height, 2 * FMargin + FCaptionHeight + 2);
    end
    else
      self.Height := 2 * FMargin + FCaptionHeight + 2;
  end
  else
  begin
    FRollMode := ARollMode;
    if FAnimate then
    begin
      FAnimator.Options.SquareMode := smMinus;
      FAnimator.animate(self.Height, FUnrollHeight);
    end
    else
    begin
      self.Height := FUnrollHeight;
      if FHideChildren then
        ShowComponents;
    end;
  end;

end;

procedure TSpkRollPanel.MyOnLMouseButtonDown(var msg: TMessage);
begin
  inherited;
  mx := msg.LParamLo;
  my := msg.LParamHi;
  down := True;
end;

procedure TSpkRollPanel.MyOnMouseMove(var msg: TMessage);
var
  x, y: integer;
  lmb: boolean;
  tp: TPoint;
begin
  inherited;
  x := msg.LParamLo;
  y := msg.LParamHi;
  lmb := (msg.WParam and MK_LBUTTON <> 0);
  if CanMove and down then
  begin
    //      self.Cursor:=crHourGlass;
    if x > mx then
      self.Left := self.left + (x - mx)
    else if x < mx then
      self.Left := self.left - (mx - x);
    if y > my then
      self.top := self.top + (y - my)
    else if y < my then
      self.top := self.top - (my - y);
    mx := x;
    my := y;
    Self.Refresh;
    //      exit;
  end;
  if (FRollMode = rmUnroll) and FAllowResize then
  begin
    if (x > FMargin) and (x < self.Width - FMargin - 1) and (y >= self.Height - FMargin - 4) and
      (y < self.Height - FMargin) then
      self.Cursor := crSizeNS
    else
      self.cursor := crDefault;

    // Jeœli u¿ytkownik w³aœnie skoñczy³ resize'owaæ
    if not (lmb) and (FResizeMode = rmResize) then
    begin
      // Zakoñcz resize
      FResizeMode := rmNormal;
    end;
    // Jeœli u¿ytkownik rozpoczyna resize
    if (y >= self.Height - FMargin - 4) and (y < self.Height - FMargin) and
      lmb and (FResizeMode = rmNormal) then
    begin
      // W³¹cz tryb resize
      FResizeMode := rmResize;
      // Oblicz zale¿noœæ pomiêdzy pozycj¹ gryzonia i wysokoœci¹ pane'a
      FMouseDelta := mouse.cursorpos.Y - self.Height;
    end;
    // Jeœli trwa resize
    if FResizeMode = rmResize then
    begin
      // Ustaw odpowiedni¹ wysokoœæ w zale¿noœci od pozycji gryzonia
      // self.Height:=max(FMinHeight,mouse.cursorpos.Y-FMouseDelta) else
      self.Height := max(mouse.cursorpos.Y - FMouseDelta, FCaptionHeight + 2 * FMargin + 2 + 10);
      self.refresh;
    end;
  end;
  inherited;
end;

constructor TSpkRollPanel.Create(AOwner: TComponent);

begin
  inherited;// create(AOwner);
  FRollMode := rmUnroll;
  FResizeMode := rmNormal;

  FMargin := 2;
  FMarginColor := clWhite;
  FCaptionHeight := 16;
  FBorderColor := clBtnFace;
  FAnimate := False;
  FHideChildren := False;
  FAnimator := TSpkAnimator.Create;
  with FAnimator.Options do
  begin
    AnimationTime := 200;
    AnimationType := atHeight;
    Square := True;
    SquareMode := smPlus;
    Target := self;
  end;
  FAnimator.OnFinishAnimation := @self.OnFinishAnimation;

  DoubleBuffered := True;

  font.Style := [fsBold];

  FCaptionGradientMode := gmNone;
  FCaptionColorFrom := clBtnFace;
  FCaptionColorTo := clBtnFace;
  FCaptionGradientType := gtVertical;

  FPanelGradientMode := gmNone;
  FPanelColorFrom := clWhite;
  FPanelColorTo := clBtnFace;
  FPanelGradientType := gtVertical;

  FAllowResize := True;
end;

destructor TSpkRollPanel.Destroy;

begin
  inherited;
end;

procedure TSpkRollPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  with Rect do
  begin
    Top := Top + 4 + FMargin + FCaptionHeight;
    Bottom := Bottom - 4;
    Left := Left + 4;
    Right := Right - 4;
  end;
  inherited AlignControls(AControl, Rect);
end;

procedure TSpkRollPanel.paint;
const
  PlusMinusDetail: array[Boolean {Hot}, Boolean {Expanded}] of TThemedTreeview =
  (
    (ttGlyphClosed, ttGlyphOpened),
    (ttHotGlyphClosed, ttHotGlyphOpened)
  );

  ArrowColor = TColor($8D665A);

var
  drawrect: TRect;
  textheight: integer;

  procedure DrawGlyph(aOpened: boolean);
  var
    h: integer;
  begin
    h := trunc(textheight / 2);
    Canvas.Pen.Color := ArrowColor;
    Canvas.Brush.Color := ArrowColor;
    {Canvas.Polygon([Point(3, 4),
                    Point(4, 3),
                    Point(6, 5),
                    Point(8, 3),
                    Point(9, 4),
                    Point(6, 7)]);}
    if aOpened then
      Canvas.Polygon([Point(6, 7),
                      Point(7, 6),
                      Point(12, 11),
                      Point(17, 6),
                      Point(18, 7),
                      Point(12, 13)])
    else
      Canvas.Polygon([Point(9, 4),
                      Point(15, 10),
                      Point(9, 16)]);
  end;
begin
  // Margines

  Drawrect.top := FMargin;
  Drawrect.left := FMargin;
  Drawrect.Right := self.Width - 1 - FMargin;
  Drawrect.Bottom := self.Height - 1 - FMargin;

  self.canvas.brush.color := FMarginColor;
  self.canvas.brush.style := bsSolid;
  self.canvas.FillRect(rect(0, 0, Width, Height));

  // Caption panela
  // Ramka

  self.canvas.pen.color := FBorderColor;
  rectangle(self.canvas, drawrect.left, drawrect.top, drawrect.right,
    drawrect.top + FCaptionHeight + 1);

  // T³o

  case FCaptionGradientMode of
    gmNone:
    begin
      self.canvas.brush.color := FCaptionColorFrom;
      self.canvas.brush.style := bsSolid;
      self.canvas.FillRect(
        rect(drawrect.left + 1, drawrect.top + 1, drawrect.right - 1 + 1, drawrect.top + FCaptionheight + 1));
    end;
    gmUser:
    begin
      case FCaptionGradientType of
        gtVertical: VGradient(self.canvas, FCaptionColorFrom,
            FCaptionColorTo, drawrect.left + 1, drawrect.top + 1, drawrect.right - 1,
            drawrect.top + FCaptionheight);
        gtHorizontal: HGradient(self.canvas, FCaptionColorFrom,
            FCaptionColorTo, drawrect.left + 1, drawrect.top + 1, drawrect.right - 1,
            drawrect.top + FCaptionheight);
      end;
    end;
    gmAuto:
    begin
      case FCaptionGradientType of
        gtVertical: VGradient(self.canvas, FCaptionColorFrom,
            brighten(FCaptionColorFrom, 40), drawrect.left + 1, drawrect.top + 1,
            drawrect.right - 1, drawrect.top + FCaptionheight);
        gtHorizontal: HGradient(self.canvas, FCaptionColorFrom,
            brighten(FCaptionColorFrom, 40), drawrect.left + 1, drawrect.top + 1,
            drawrect.right - 1, drawrect.top + FCaptionheight);
      end;
    end;
  end;


   // Tekst captiona
  textheight := self.canvas.textheight('Wy');
  DrawGlyph(not(RollMode = rmRoll));
  self.canvas.brush.style := bsClear;
  self.canvas.Font.Assign(self.Font);
  self.canvas.TextOut(drawrect.Left + 5 + 20, drawrect.top + 1 +
    ((FCaptionHeight - textheight) div 2), self.Caption);

  // Pole zawartoœci panela

  // if FRollMode=rmUnroll then
  if Height > 2 * FMargin + FCaptionHeight + 2 then
  begin
    self.canvas.pen.color := FBorderColor;
    rectangle(self.canvas, drawrect.left, drawrect.top + FCaptionHeight +
      1, drawrect.right, drawrect.bottom);

    // T³o
    case FPanelGradientMode of
      gmNone:
      begin
        self.canvas.brush.color := FPanelColorFrom;
        self.canvas.brush.style := bsSolid;
        self.canvas.FillRect(
          rect(drawrect.left + 1, drawrect.top + FCaptionHeight + 2, drawrect.right - 1
          + 1, drawrect.bottom - 1 + 1));
      end;
      gmUser:
      begin
        case FPanelGradientType of
          gtVertical: VGradient(self.canvas, FPanelColorFrom,
              FPanelColorTo, drawrect.left + 1, drawrect.top + FCaptionHeight + 2, drawrect.right -
              1, drawrect.bottom - 1);
          gtHorizontal: HGradient(
              self.canvas, FPanelColorFrom, FPanelColorTo, drawrect.left + 1, drawrect.top +
              FCaptionHeight + 2, drawrect.right - 1, drawrect.bottom - 1);
        end;
      end;
      gmAuto:
      begin
        case FPanelGradientType of
          gtVertical: VGradient(self.canvas, FPanelColorFrom,
              brighten(FPanelColorFrom, 40), drawrect.left + 1, drawrect.top + FCaptionHeight + 2,
              drawrect.right - 1, drawrect.bottom - 1);
          gtHorizontal: HGradient(
              self.canvas, FPanelColorFrom, brighten(FPanelColorFrom, 40), drawrect.left + 1,
              drawrect.top + FCaptionHeight + 2, drawrect.right - 1, drawrect.bottom - 1);
        end;
      end;
    end;
  end;
end;

procedure TSpkRollPanel.OnFinishAnimation(Sender: TObject);
begin
  if FHideChildren and (FRollMode = rmUnroll) then
    ShowComponents;
end;

procedure TSpkRollPanel.HideComponents;

var
  i: integer;
  PropInfo: PPropInfo;

begin
  if self.controlCount > 0 then
    for i := 0 to self.controlcount - 1 do
    begin
      PropInfo := GetPropInfo(self.Controls[i], 'visible');
      if PropInfo <> nil then
        SetOrdProp(self.Controls[i], 'Visible', 0);
    end;
end;

procedure TSpkRollPanel.ShowComponents;

var
  i: integer;
  PropInfo: PPropInfo;

begin
  if self.controlCount > 0 then
    for i := 0 to self.controlcount - 1 do
    begin
      PropInfo := GetPropInfo(self.Controls[i], 'visible');
      if PropInfo <> nil then
        SetOrdProp(self.Controls[i], 'Visible', 1);
    end;
end;

end.
