unit NiceCustomPanel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  LCLIntf, LMessages;

type
  TNiceCustomPanel = class(TCustomPanel)
  private
    { Private declarations }
    procedure SetTransparent(const AValue: boolean);
    function GetTransparent: boolean;
  protected
    { Protected declarations }
    procedure WMPaint(var Message: TLMPaint); message LM_PAINT;
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(TheOwner: TComponent); override;
  published
    { Published declarations }
    property Transparent: boolean read GetTransparent write SetTransparent;
  end;

  TNicePanel = class(TNiceCustomPanel)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
      property Align;
      property Alignment;
      property Anchors;
      property AutoSize;
      property BorderSpacing;
      property BevelInner;
      property BevelOuter;
      property BevelWidth;
      property BidiMode;
      property BorderWidth;
      property BorderStyle;
      property Caption;
      property ChildSizing;
      property ClientHeight;
      property ClientWidth;
      //property Color;
      property Constraints;
      property DockSite;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
      property Font;
      property FullRepaint;
      property ParentBidiMode;
      property ParentColor;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property TabStop;
      property UseDockManager default True;
      property Visible;
      property OnClick;
      property OnContextPopup;
      property OnDockDrop;
      property OnDockOver;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDock;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnGetSiteInfo;
      property OnGetDockCaption;
      property OnMouseDown;
      property OnMouseEnter;
      property OnMouseLeave;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
      property OnStartDock;
      property OnStartDrag;
      property OnUnDock;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I nicecustompanel_icon.lrs}
  RegisterComponents('priyatna.org',[TNicePanel]);
end;

constructor TNiceCustomPanel.Create(TheOwner: TComponent);
begin
  inherited Create (TheOwner);
  ControlStyle := ControlStyle + [csOpaque];
end;

procedure TNiceCustomPanel.WMPaint(var Message: TLMPaint);
begin
  if (csDestroying in ComponentState) or (not HandleAllocated) then exit;
  Include(FControlState, csCustomPaint);
  inherited WMPaint(Message);
  Exclude(FControlState, csCustomPaint);
end;

procedure TNiceCustomPanel.Paint;
var
  ARect: TRect;
  TS : TTextStyle;
begin
  ARect := GetClientRect;
  Canvas.Pen.Style:=psClear;
  Canvas.Brush.Style:=bsClear;
  Canvas.Brush.Color:=clred;

  InflateRect(ARect, -5, -5);
  canvas.FillRect(ARect);

  Canvas.Brush.Color:=clyellow;
  InflateRect(ARect, -10, -10);
  canvas.RoundRect(ARect, 10, 10);
end;

procedure TNiceCustomPanel.SetTransparent(const AValue: Boolean);
begin
  if GetTransparent = AValue then exit;
  if AValue then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];
  Invalidate;
end;

function TNiceCustomPanel.GetTransparent: Boolean;
begin
  Result := not (csOpaque in ControlStyle);
end;

end.
