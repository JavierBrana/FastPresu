unit NiceEditors;
{$MODE Delphi}
interface
uses
  LCLIntf, LCLType, LMessages, Classes, Controls, StdCtrls, Buttons,
  Forms, Graphics, SysUtils, Contnrs, ExtCtrls, Clipbrd,

  NiceLookUpComboBox, ImgList, DB, Menus, Grids;


const
  NumChars: set of Char = ['0'..'9'];
  MaxBinary = 32;

type
  TEditType = (etBinary, etFloat, etHex, etInteger, etString);
  TStringCharSet = (scFull, scAlpha, scDigit, scTime, scDate);


  TNiceNumeric = class(TCustomEdit)
  private
    CellX, CellY : Integer;
  protected
    procedure KeyPress(var Key: Char); override;
  public
    //constructor Create(AOwner: TComponent); override;
    constructor Create(AOwner: TComponent; X,Y: Integer); reintroduce;
    destructor Destroy; override;
  published
    property Color;
  end;

  TNiceMemo = class(TCustomMemo)
  private
    FButton : TSpeedButton;
    FShowButton : Boolean;
    FOnButtonClick : TNotifyEvent;

    procedure SetShowButton(Value: Boolean);
    procedure SetButton(Value: Boolean);
    procedure SetEditRect;
    procedure ButtonClick(Sender: TObject);
    //procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    function ChildClassAllowed(ChildClass: TClass): boolean; override;

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property Color;
    property Constraints;
    //property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    //property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property ShowButton: Boolean read FShowButton write SetShowButton default false;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
  end;


  TNumericType = (ntFloat, ntInteger);

  TNumericOptions = class
    private
      FNumericType: TNumericType;
      FDecimals : Integer;
      FShowZero : boolean;
      FThousandsSeparator: boolean;
    protected
      procedure SetNumericType (Val: TNumericType);
      procedure SetDecimals (Val: Integer);
      procedure SetShowZero (Val: boolean);
      procedure SetThousandsSeparator (Val: boolean);
    public
      constructor Create;
    published
      property NumericType: TNumericType read FNumericType Write SetNumericType default ntInteger;
      property Decimals: Integer read FDecimals write SetDecimals default 2;
      property ShowZero: boolean read FShowZero write SetShowZero default true;
      property ThousandsSeparator: boolean read FThousandsSeparator write SetThousandsSeparator default true;
  end;

implementation

//------------------------TNiceNumeric----------------------------------------
{constructor TNiceNumeric.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Text := '';
end;}

constructor TNiceNumeric.Create(AOwner: TComponent; X,Y: Integer);
begin
  inherited Create(AOwner);
  Text := '';
  CellX := X;
  CellY := Y;
end;

destructor TNiceNumeric.Destroy;
begin
  inherited Destroy;
end;

procedure TNiceNumeric.KeyPress(var Key: Char);
var
  size, textheight, linescount: integer;
begin
  {
  inherited KeyPress(Key);
  if (Key in ['.',',']) then Key := DefaultFormatSettings.Decimalseparator;
  if not (Key in ['0'..'9', DefaultFormatSettings.DecimalSeparator,'+','-',#8,#9]) then Key := #0;
  if (Key = DefaultFormatSettings.DecimalSeparator) and (FDecimals = 0) then Key := #0;

  if (Pos(DecimalSeparator, Text) > 0) then
  begin
    if (Key = DecimalSeparator) then
      if SelLength > 0 then Text := ''
      else Key := #0;
    if ((Length(Text) - Pos(DecimalSeparator, Text) + 1) > FGrid.Columns.Items[FGrid.Col].FDecimals)
      and (Key in ['0'..'9']) and (Pos(DecimalSeparator, Text) <= SelStart) then
      Key := #0;
  end; }
end;

//------------------------TNiceMemo-----------------------------------------
constructor TNiceMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShowButton := false;
  Text := '';
end;

destructor TNiceMemo.Destroy;
begin
  FButton := nil;
  inherited Destroy;
end;


function TNiceMemo.ChildClassAllowed(ChildClass: TClass): boolean;
begin
     // Permite la posesión del button
  Result := true;
end;

{procedure TNiceMemo.CMTextChanged(var Message: TMessage);
begin
  inherited;

end;}

procedure TNiceMemo.SetShowButton(Value: Boolean);
begin
  if FShowButton <> Value then
  begin
    FShowButton := Value;
    SetButton(FShowButton);
    if FButton <> nil then
    begin
      if NewStyleControls {and Ctl3D}then
        FButton.SetBounds(Width - FButton.Width - 5, 0, FButton.Width, Height - 5)
      else FButton.SetBounds (Width - FButton.Width, 1, FButton.Width, Height - 3);
    end;
    SetEditRect;
    Invalidate;
  end;
end;

procedure TNiceMemo.SetButton(Value: Boolean);
begin
  if Value then
  begin
    if FButton = nil then
    begin
      FButton := TSpeedButton.Create(Self);
      FButton.Width := 16;//cButtonWidth;
      FButton.Height := Height - 2;
      //FButton.Align := alRight;
      FButton.Visible := True;
      FButton.ParentFont := false;
      //FButton1.Glyph.LoadFromResourceName(HInstance,'IMGSOFTBTNSPOTS');
      FButton.Caption := '...';
      FButton.Cursor := crArrow;
      FButton.OnClick := ButtonClick;
      FButton.Parent := Self;
      //FButton.Parent := Parent;
      //FButton.AnchorToCompanion(akLeft, 0 ,Self);
      FButton.BringToFront;
    end;
  end
  else
  begin
    FButton.Free;
    FButton:=nil;
  end;
end;

procedure TNiceMemo.ButtonClick(Sender: TObject);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self);
end;

procedure TNiceMemo.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, $00B2{EM_GETRECT}, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1; {+1 is workaround for windows paint bug}
  if FButton <> nil  then
    Loc.Right := ClientWidth - FButton.Width - 2
  else
    Loc.Right := ClientWidth - 2;
  Loc.Top := 0;
  Loc.Left := 2;

  SendMessage(Handle, $00B4{EM_SETRECTNP}, 0, LongInt(@Loc));
  SendMessage(Handle, $00B2{EM_GETRECT}, 0, LongInt(@Loc)); {debug}
end;


  {TNumericOptions}

constructor TNumericOptions.Create;
begin
  FNumericType := ntInteger;
  FDecimals := 2;
  FShowZero := true;
  FThousandsSeparator := true;
end;

procedure TNumericOptions.SetDecimals(Val: Integer);
begin
  Decimals := val;
end;

procedure TNumericOptions.SetNumericType(Val: TNumericType);
begin
  NumericType := Val;
end;

procedure TNumericOptions.SetShowZero(Val: Boolean);
begin
  ShowZero := Val;
end;

procedure TNumericOptions.SetThousandsSeparator(Val: Boolean);
begin
  ThousandsSeparator := Val;
end;

end.
