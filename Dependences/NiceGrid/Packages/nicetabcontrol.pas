unit NiceTabControl;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Types, Classes, Math,
  AvgLvlTree, LazUTF8, LazUTF8Classes,
  LCLStrConsts, LResources, LCLIntf, LCLType,
  FileUtil, LMessages, ImgList, ActnList, GraphType,
  Themes, WSLCLClasses, LCLClasses, LCLProc,
  Graphics, Menus, Controls, Forms, StdCtrls, ExtCtrls, ToolWin, Buttons, ComCtrls;

{type
  TNiceTabControl= class(TCustomTabControl)
  private
    FImageChangeLink: TChangeLink;
    FOnChange: TNotifyEvent;
    FOnChangeNeeded: Boolean;
    FTabControlCreating: Boolean;
    FTabs: TStrings;// this is a TTabControlNoteBookStrings
    FCanvas: TCanvas;
    FImages: TCustomImageList;
    procedure AdjustDisplayRect(var ARect: TRect);
    function GetDisplayRect: TRect;
    function GetHotTrack: Boolean;
    function GetMultiLine: Boolean;
    function GetMultiSelect: Boolean;
    function GetOwnerDraw: Boolean;
    function GetRaggedRight: Boolean;
    function GetScrollOpposite: Boolean;
    function GetTabHeight: Smallint;
    function GetTabIndex: Integer;
    function GetTabRectWithBorder: TRect;
    function GetTabWidth: Smallint;
    procedure SetHotTrack(const AValue: Boolean);
    procedure SetImages(const AValue: TCustomImageList);
    procedure SetMultiLine(const AValue: Boolean);
    procedure SetMultiSelect(const AValue: Boolean);
    procedure SetOwnerDraw(const AValue: Boolean);
    procedure SetRaggedRight(const AValue: Boolean);
    procedure SetScrollOpposite(const AValue: Boolean);
    //procedure SetStyle(AValue: TTabStyle); override;
    procedure SetTabHeight(const AValue: Smallint);
    //procedure SetTabPosition(AValue: TTabPosition); override;
    procedure SetTabs(const AValue: TStrings);
    procedure SetTabWidth(const AValue: Smallint);
  protected
    procedure AddRemovePageHandle(APage: TCustomPage); override;
    function CanChange: Boolean; override;
    function CanShowTab(ATabIndex: Integer): Boolean; virtual;
    procedure Change; override;
    procedure CreateWnd; override;
    procedure DestroyHandle; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetTabIndex(Value: Integer); virtual;
    procedure UpdateTabImages;
    procedure ImageListChange(Sender: TObject);
    procedure DoSetBounds(ALeft, ATop, AWidth, AHeight: integer); override;
    class function GetControlClassDefaultSize: TSize; override;
    procedure PaintWindow(DC: HDC); override;
    procedure Paint; virtual;
    procedure AdjustDisplayRectWithBorder(var ARect: TRect); virtual;
    procedure AdjustClientRect(var ARect: TRect); override;
    function CreateTabNoteBookStrings: TTabControlNoteBookStrings; virtual;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    function IndexOfTabAt(X, Y: Integer): Integer;
    function GetHitTestInfoAt(X, Y: Integer): THitTests;
    function GetImageIndex(ATabIndex: Integer): Integer; override;
    function IndexOfTabWithCaption(const TabCaption: string): Integer;
    function TabRect(Index: Integer): TRect;
    function RowCount: Integer;
    procedure ScrollTabs(Delta: Integer);
    procedure BeginUpdate;
    procedure EndUpdate;
    function IsUpdating: boolean;
  public
    property DisplayRect: TRect read GetDisplayRect;
  published
    property HotTrack: Boolean read GetHotTrack write SetHotTrack default False;
    property Images;
    property MultiLine: Boolean read GetMultiLine write SetMultiLine default False;
    property MultiSelect: Boolean read GetMultiSelect write SetMultiSelect default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging;
    property OnDrawTab;
    property OnGetImageIndex;
    property OwnerDraw: Boolean read GetOwnerDraw write SetOwnerDraw default False;
    property RaggedRight: Boolean read GetRaggedRight write SetRaggedRight default False;
    property ScrollOpposite: Boolean read GetScrollOpposite
                                     write SetScrollOpposite default False;
    property Style default tsTabs;
    property TabHeight: Smallint read GetTabHeight write SetTabHeight default 0;
    property TabPosition default tpTop;
    property TabWidth: Smallint read GetTabWidth write SetTabWidth default 0;
    property TabIndex: Integer read GetTabIndex write SetTabIndex default -1;
    property Tabs: TStrings read FTabs write SetTabs;
    property TabStop default True;
    //
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderSpacing;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property OnChangeBounds;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
  end; }

procedure Register;

implementation

{ TTabControl }

{procedure TNiceTabControl.AdjustDisplayRect(var ARect: TRect);
const
  TabControlInternalBorder = 2; // TNiceTabControl paints a border, so limit the children, to be within that border
begin
  AdjustDisplayRectWithBorder(ARect);
  if TabPosition<>tpTop then
    ARect.Top:=Min(Max(ARect.Top,ARect.Top+BorderWidth+TabControlInternalBorder),ARect.Bottom);
  if TabPosition<>tpBottom then
    ARect.Bottom:=Max(Min(ARect.Bottom,ARect.Bottom-BorderWidth-TabControlInternalBorder),ARect.Top);
  if TabPosition<>tpLeft then
    ARect.Left:=Min(Max(ARect.Left,ARect.Left+BorderWidth+TabControlInternalBorder),ARect.Right);
  if TabPosition<>tpRight then
    ARect.Right:=Max(Min(ARect.Right,ARect.Right-BorderWidth-TabControlInternalBorder),ARect.Left);
end;

function TNiceTabControl.GetDisplayRect: TRect;
begin
  Result:=ClientRect;
  AdjustDisplayRect(Result);
end;

function TNiceTabControl.GetHotTrack: Boolean;
begin
  Result:=TNiceTabControl(FTabs).HotTrack;
end;

function TNiceTabControl.GetMultiLine: Boolean;
begin
  Result:=TNiceTabControl(FTabs).MultiLine;
end;

function TNiceTabControl.GetMultiSelect: Boolean;
begin
  Result:=TNiceTabControl(FTabs).MultiSelect;
end;

function TNiceTabControl.GetOwnerDraw: Boolean;
begin
  Result:=TNiceTabControl(FTabs).OwnerDraw;
end;

function TNiceTabControl.GetRaggedRight: Boolean;
begin
  Result:=TNiceTabControl(FTabs).RaggedRight;
end;

function TNiceTabControl.GetScrollOpposite: Boolean;
begin
  Result:=TNiceTabControl(FTabs).ScrollOpposite;
end;

function TNiceTabControl.GetTabHeight: Smallint;
begin
  Result:=TNiceTabControl(FTabs).TabHeight;
end;

function TNiceTabControl.GetTabIndex: Integer;
begin
  Result:=TNiceTabControl(FTabs).TabIndex;
end;

function TNiceTabControl.GetTabWidth: Smallint;
begin
  Result:=TNiceTabControl(FTabs).TabWidth;
end;

procedure TNiceTabControl.SetHotTrack(const AValue: Boolean);
begin
  TNiceTabControl(FTabs).HotTrack:=AValue;
end;

procedure TNiceTabControl.SetImages(const AValue: TCustomImageList);
begin
  if FImages = AValue then Exit;
  if FImages <> nil then
    FImages.RemoveFreeNotification(Self);
  FImages := TImageList(AValue);
  if FImages <> nil then
    FImages.FreeNotification(Self);
  TNiceTabControl(FTabs).Images := FImages;
end;

procedure TNiceTabControl.SetMultiLine(const AValue: Boolean);
begin
  TNiceTabControl(FTabs).MultiLine:=AValue;
end;

procedure TNiceTabControl.SetMultiSelect(const AValue: Boolean);
begin
  TNiceTabControl(FTabs).MultiSelect:=AValue;
end;

procedure TNiceTabControl.SetOwnerDraw(const AValue: Boolean);
begin
  TNiceTabControl(FTabs).OwnerDraw:=AValue;
end;

procedure TNiceTabControl.SetRaggedRight(const AValue: Boolean);
begin
  TNiceTabControl(FTabs).RaggedRight:=AValue;
end;

procedure TNiceTabControl.SetScrollOpposite(const AValue: Boolean);
begin
  TNiceTabControl(FTabs).ScrollOpposite:=AValue;
end;

{procedure TNiceTabControl.SetStyle(AValue: TTabStyle);
begin
  inherited SetStyle(AValue);
  if FStyle=AValue then exit;
  FStyle:=AValue;
  TNiceTabControlNoteBookStrings(FTabs).Style := AValue;
end;}

procedure TNiceTabControl.SetTabHeight(const AValue: Smallint);
begin
  TNiceTabControl(FTabs).TabHeight:=AValue;
end;

{procedure TNiceTabControl.SetTabPosition(AValue: TTabPosition);
begin
  if FTabPosition=AValue then exit;
  FTabPosition:=AValue;
  TNiceTabControlNoteBookStrings(FTabs).TabPosition := AValue;
  ReAlign;
end;}

procedure TNiceTabControl.SetTabs(const AValue: TStrings);
begin
  FTabs.Assign(AValue);
end;

procedure TNiceTabControl.SetTabWidth(const AValue: Smallint);
begin
  TNiceTabControl(FTabs).TabWidth:=AValue;
end;

procedure TNiceTabControl.AddRemovePageHandle(APage: TCustomPage);
begin
  // There are no pages, don't create a handle
end;

function TNiceTabControl.CanChange: Boolean;
begin
  Result:=true;
  if FTabControlCreating then exit;
  if not IsUpdating and Assigned(FOnChanging) then
    FOnChanging(Self,Result);
end;

function TNiceTabControl.CanShowTab(ATabIndex: Integer): Boolean;
begin
  Result:=true;
end;

procedure TNiceTabControl.Change;
begin
  if FTabControlCreating then exit;
  if IsUpdating then begin
    FOnChangeNeeded:=true;
    exit;
  end else
    FOnChangeNeeded:=false;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TNiceTabControl.GetImageIndex(ATabIndex: Integer): Integer;
begin
  Result := ATabIndex;
  if Assigned(FOnGetImageIndex) then
    FOnGetImageIndex(Self, ATabIndex, Result);
end;

procedure TNiceTabControl.CreateWnd;
begin
  BeginUpdate;
  inherited CreateWnd;
  EndUpdate;
end;

procedure TNiceTabControl.DestroyHandle;
begin
  BeginUpdate;
  inherited DestroyHandle;
  EndUpdate;
end;

procedure TNiceTabControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

procedure TNiceTabControl.SetTabIndex(Value: Integer);
begin
  TNiceTabControl(FTabs).TabIndex:=Value;
end;

procedure TNiceTabControl.UpdateTabImages;
begin
  TNiceTabControl(FTabs).UpdateTabImages;
end;

procedure TNiceTabControl.ImageListChange(Sender: TObject);
begin
  TNiceTabControl(FTabs).ImageListChange(Sender);
end;

procedure TNiceTabControl.DoSetBounds(ALeft, ATop, AWidth, AHeight: integer);
begin
  inherited DoSetBounds(ALeft, ATop, AWidth, AHeight);
  if FTabs <> nil then
    TNiceTabControl(FTabs).TabControlBoundsChange;
end;

class function TNiceTabControl.GetControlClassDefaultSize: TSize;
begin
  Result.CX := 200;
  Result.CY := 150;
end;

procedure TNiceTabControl.PaintWindow(DC: HDC);
var
  DCChanged: boolean;
begin
  DCChanged := (not FCanvas.HandleAllocated) or (FCanvas.Handle <> DC);
  if DCChanged then
    FCanvas.Handle := DC;
  try
    Paint;
  finally
    if DCChanged then FCanvas.Handle := 0;
  end;
end;

procedure TNiceTabControl.Paint;
var
  ARect, ARect2: TRect;
  TS: TTextStyle;
  Details: TThemedElementDetails;
  lCanvas: TCanvas;
begin
  lCanvas := FCanvas;

  //DebugLn(['TNiceTabControl.Paint Bounds=',dbgs(BoundsRect),' ClientRect=',dbgs(ClientRect),' CientOrigin=',dbgs(ClientOrigin)]);
  // clear only display area since button area is painted by another control
  // draw a frame
  ARect := ClientRect;
  AdjustDisplayRectWithBorder(ARect);

  Details := ThemeServices.GetElementDetails(ttPane);
  ARect2 := ARect;
  // paint 1 pixel under the header, to avoid painting a closing border
  case TabPosition of
    tpTop:    ARect2.Top    := ARect2.Top    - 1;
    tpBottom: ARect2.Bottom := ARect2.Bottom + 1;
    tpLeft:   ARect2.Left   := ARect2.Left   - 1;
    tpRight:  ARect2.Right  := ARect2.Right  + 1;
  end;
  ThemeServices.DrawElement(lCanvas.Handle, Details, ARect2);

  InflateRect(ARect,BorderWidth,BorderWidth);
  lCanvas.Frame3d(ARect, BorderWidth, bvRaised);

  if (csDesigning in ComponentState) and (Caption <> '') then
  begin
    ARect:=GetDisplayRect;
    TS := lCanvas.TextStyle;
    TS.Alignment:=taCenter;
    TS.Layout:= tlCenter;
    TS.Opaque:= false;
    TS.Clipping:= false;
    lCanvas.TextRect(ARect, ARect.Left, ARect.Top, Caption, TS);
  end;
end;

procedure TNiceTabControl.AdjustDisplayRectWithBorder(var ARect: TRect);
var
  TabAreaSize: LongInt;
begin
  TabAreaSize := TNiceTabControl(FTabs).GetSize;

  case TabPosition of
    tpTop:    ARect.Top:=Min(TabAreaSize,ARect.Bottom);
    tpBottom: ARect.Bottom:=Max(ARect.Bottom-TabAreaSize,ARect.Top);
    tpLeft:   ARect.Left:=Min(TabAreaSize,ARect.Right);
    tpRight:  ARect.Right:=Max(ARect.Right-TabAreaSize,ARect.Left);
  end;
end;

function TNiceTabControl.GetTabRectWithBorder: TRect;
var
  TabAreaSize: LongInt;
begin
  Result := ClientRect;
  TabAreaSize := TNiceTabControl(FTabs).GetSize;
  case TabPosition of
    tpTop:    Result.Bottom:=Min(TabAreaSize,Result.Bottom);
    tpBottom: Result.Top:=Max(Result.Bottom-TabAreaSize,Result.Top);
    tpLeft:   Result.Right:=Min(TabAreaSize,Result.Right);
    tpRight:  Result.Left:=Max(Result.Right-TabAreaSize,Result.Left);
  end;
end;

procedure TNiceTabControl.AdjustClientRect(var ARect: TRect);
begin
  AdjustDisplayRect(ARect);
end;

function TNiceTabControl.CreateTabNoteBookStrings: TNiceTabControlNoteBookStrings;
begin
  Result := TNiceTabControlNoteBookStrings.Create(Self);
end;

constructor TNiceTabControl.Create(TheOwner: TComponent);
begin
  FTabControlCreating:=true;
  inherited Create(TheOwner);
  ControlStyle:=ControlStyle+[csAcceptsControls];
  FStyle:=tsTabs;
  FTabPosition:=tpTop;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := @ImageListChange;
  FTabs := CreateTabNoteBookStrings;
  //Set FTab's internal NoteBook.TabStop to False, otherwise TNiceTabControl can always be tabbed into (Issue #0021332)
  TNiceTabControlNoteBookStrings(FTabs).NoteBook.TabStop := False;
  with GetControlClassDefaultSize do
    SetInitialBounds(0, 0, CX, CY);
  BorderWidth:=0;
  FTabControlCreating:=false;

  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
end;

destructor TNiceTabControl.Destroy;
begin
  BeginUpdate;
  FCanvas.Free;
  FreeThenNil(FTabs);
  FreeThenNil(FImageChangeLink);
  inherited Destroy;
end;

function TNiceTabControl.IndexOfTabAt(X, Y: Integer): Integer;
begin
  Result:=TNiceTabControl(FTabs).IndexOfTabAt(X,Y);
end;

function TNiceTabControl.GetHitTestInfoAt(X, Y: Integer): THitTests;
begin
  Result:=TNiceTabControl(FTabs).GetHitTestInfoAt(X,Y);
end;

function TNiceTabControl.IndexOfTabWithCaption(const TabCaption: string
  ): Integer;
begin
  Result:=0;
  while Result<Tabs.Count do begin
    if CompareText(Tabs[Result],TabCaption)=0 then exit;
    inc(Result);
  end;
  Result:=-1;
end;

function TNiceTabControl.TabRect(Index: Integer): TRect;
begin
  Result:=TNiceTabControl(FTabs).TabRect(Index);
end;

function TNiceTabControl.RowCount: Integer;
begin
  Result:=TNiceTabControl(FTabs).RowCount;
end;

procedure TNiceTabControl.ScrollTabs(Delta: Integer);
begin
  TNiceTabControl(FTabs).ScrollTabs(Delta);
end;

procedure TNiceTabControl.BeginUpdate;
begin
  if FTabs=nil then exit;
  TNiceTabControl(FTabs).BeginUpdate;
  //debugln('TNiceTabControl.BeginUpdate ',dbgs(IsUpdating));
end;

procedure TNiceTabControl.EndUpdate;
begin
  if FTabs=nil then exit;
  TNiceTabControl(FTabs).EndUpdate;
  //debugln('TNiceTabControl.EndUpdate ',dbgs(IsUpdating));
  if not TNiceTabControl(FTabs).IsUpdating then begin
    if FOnChangeNeeded then Change;
  end;
end;

function TNiceTabControl.IsUpdating: boolean;
begin
  Result:=(FTabs<>nil) and TNiceTabControl(fTabs).IsUpdating;
end;   }


procedure Register;
begin
  {
  {$I nicetabcontrol_icon.lrs}
  RegisterComponents('priyatna.org',[TNiceTabControl]);  }
end;

end.
