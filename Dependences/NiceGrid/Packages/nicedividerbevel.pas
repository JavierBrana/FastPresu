unit NiceDividerBevel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, FPCanvas,
  DividerBevel, ComCtrls;

type

  TDividerStyle = (dsBevel, dsLine, dsLineBotton);

  TNiceDividerBevel = class(TDividerBevel)
  private
    { Private declarations }
    FLineColor: TColor;
    FLineStyle: TFPPenStyle;
    FLineWidth: Integer;
    FDividerStyle: TDividerStyle;

    procedure SetLineColor(value: TColor);
    function GetLineColor: TColor;
    procedure SetLineStyle(value: TFPPenStyle);
    function GetLineStyle: TFPPenStyle;
    procedure SetLineWidth(value: Integer);
    function GetLineWidth: Integer;
    procedure SetDividerStyle(value: TDividerStyle);
    function GetDividerStyle: TDividerStyle;
  protected
    { Protected declarations }
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property LineColor: TColor read GetLineColor write SetLineColor default clBlack;
    property LineStyle: TFPPenStyle read GetLineStyle write SetLineStyle default psSolid;
    property LineWidth: Integer read GetLineWidth write SetLineWidth default 1;
    property DividerStyle: TDividerStyle read GetDividerStyle write SetDividerStyle default dsBevel;
  end;

procedure Register;

implementation
uses
  Math;

procedure Register;
begin
  RegisterComponents('priyatna.org',[TNiceDividerBevel]);
end;

constructor TNiceDividerBevel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLineColor := clBlack;
  FLineStyle := psSolid;
  FLineWidth := 1;
  FDividerStyle := dsBevel;
end;

procedure TNiceDividerBevel.SetLineColor(value: TColor);
begin
  if FLineColor <> value then
  begin
    FLineColor := value;
    Invalidate;
		end;
end;

function TNiceDividerBevel.GetLineColor: TColor;
begin
  Result := FLineColor;
end;

procedure TNiceDividerBevel.SetLineStyle(value: TFPPenStyle);
begin
  if FLineStyle <> value then
  begin
    FLineStyle := value;
    Invalidate;
		end;
end;

function TNiceDividerBevel.GetLineStyle: TFPPenStyle;
begin
  Result := FLineStyle;
end;

procedure TNiceDividerBevel.SetLineWidth(value: Integer);
begin
  if FLineWidth <> value then
  begin
    FLineWidth := value;
    Invalidate;
		end;
end;

function TNiceDividerBevel.GetLineWidth: Integer;
begin
  Result := FLineWidth;
end;


procedure TNiceDividerBevel.SetDividerStyle(value: TDividerStyle);
begin
  if FDividerStyle <> value then
  begin
    FDividerStyle := value;
    Invalidate;
		end;
end;

function TNiceDividerBevel.GetDividerStyle: TDividerStyle;
begin
  Result := FDividerStyle;
end;

procedure TNiceDividerBevel.Paint;
var
  aHorizontal: Boolean;
  aIndent, aRight, j: Integer;
  PaintRect: TRect;
begin
  case FDividerStyle of
    dsBevel: inherited Paint;
    dsLine:
      begin
        Canvas.Pen.Color:=FLineColor;
        Canvas.Pen.Style:=FLineStyle;
        Canvas.Pen.Width:=FLineWidth;

        CalcSize;
        if not Transparent then begin
          Canvas.Brush.Color := Color;
          Canvas.Brush.Style := bsSolid;
          Canvas.FillRect(ClientRect);
        end;

        aHorizontal := (Orientation = trHorizontal);

        if aHorizontal then begin
          PaintRect.Left := 0;
          PaintRect.Top := FBevelTop;
          PaintRect.Bottom := PaintRect.Top + FBevelHeight;
        end else begin
          PaintRect.Left := FBevelTop;
          PaintRect.Top := 0;
          PaintRect.Right := PaintRect.Left + FBevelHeight;
        end;

        if Caption = '' then begin
          if aHorizontal then
            PaintRect.Right := Width
          else
            PaintRect.Bottom := Height;
          Canvas.MoveTo(PaintRect.Left, PaintRect.Top);
          Canvas.LineTo(PaintRect.Right, PaintRect.Top);
          exit;
        end;

        if LeftIndent > 0 then aIndent := LeftIndent
        else
          if LeftIndent = 0 then aIndent := 0
          else
          begin
            j := 2 * CaptionSpacing + FTextExtent.cx;
            if aHorizontal then aIndent := (Width - j) div 2
            else aIndent := (Height - j) div 2;
          end;

        if not IsRightToLeft or not aHorizontal then aRight := aIndent
        else
        begin
          aRight := Width - FTextExtent.cx - CaptionSpacing - aIndent;
          if aIndent > 0 then dec(aRight, CaptionSpacing);
        end;

        if aRight > 0 then
        begin
          if aHorizontal then
          begin
            PaintRect.Right := aRight;
            Canvas.MoveTo(PaintRect.Left, PaintRect.Bottom);
            Canvas.LineTo(PaintRect.Right, PaintRect.Bottom);
    						end
    						else
          begin
            PaintRect.Bottom := aRight;
            Canvas.MoveTo(PaintRect.Right, PaintRect.Top);
            Canvas.LineTo(PaintRect.Right, PaintRect.Bottom);
          end;
          //Canvas.Frame3D(PaintRect, 1, aBevel);
        end;

        if aIndent > 0 then inc(aIndent, CaptionSpacing);
        if aHorizontal then begin
          PaintRect.Left := aRight + CaptionSpacing + FTextExtent.cx;
          if aIndent <> 0 then inc(PaintRect.Left, CaptionSpacing);
          PaintRect.Top := FBevelTop;
          PaintRect.Right := Width;
          PaintRect.Bottom := FBevelTop + FBevelHeight;
          Canvas.MoveTo(PaintRect.Left, PaintRect.Top);
          Canvas.LineTo(PaintRect.Right, PaintRect.Top);
        end
        else
        begin
          PaintRect.Left := FBevelTop;
          PaintRect.Top := aRight + CaptionSpacing + FTextExtent.cx;
          if aIndent <> 0 then inc(PaintRect.Top, CaptionSpacing);
          PaintRect.Right := FBevelTop + FBevelHeight;
          PaintRect.Bottom := Height;
          Canvas.MoveTo(PaintRect.Left, PaintRect.Top);
          Canvas.LineTo(PaintRect.Left, PaintRect.Bottom);
        end;
        //Canvas.Frame3D(PaintRect, 1, aBevel);

        Canvas.Brush.Style := bsClear;
        j := Max((FBevelHeight - FTextExtent.cy) div 2, 0);
        if aHorizontal then begin
          Canvas.Font.Orientation := 0;
          if not IsRightToLeft then
            Canvas.TextOut(aIndent, j, Caption)
          else
            Canvas.TextOut(Width - FTextExtent.cx - aIndent, j, Caption);
        end else begin
          Canvas.Font.Orientation := 900;
          Canvas.TextOut(j, aIndent + FTextExtent.cx, Caption);
        end;
						end;
    dsLineBotton:
      begin
        Canvas.Pen.Color:=FLineColor;
        Canvas.Pen.Style:=FLineStyle;
        Canvas.Pen.Width:=FLineWidth;

        if not Transparent then begin
          Canvas.Brush.Color := Color;
          Canvas.Brush.Style := bsSolid;
          Canvas.FillRect(ClientRect);
        end;

        aHorizontal := (Orientation = trHorizontal);

        PaintRect := ClientRect;
        if aHorizontal then
        begin
      				Canvas.MoveTo(PaintRect.Left, PaintRect.Bottom - (1 + FLineWidth div 2));
          Canvas.LineTo(PaintRect.Right, PaintRect.Bottom - (1 + FLineWidth div 2));
    				end
    				else
        begin
      				Canvas.MoveTo(PaintRect.Right - (1 + FLineWidth div 2), PaintRect.Top);
          Canvas.LineTo(PaintRect.Right - (1 + FLineWidth div 2), PaintRect.Bottom);
    				end;

        if LeftIndent > 0 then aIndent := LeftIndent
        else
          if LeftIndent = 0 then aIndent := 0
          else
          begin
            j := 2 * CaptionSpacing + FTextExtent.cx;
            if aHorizontal then aIndent := (Width - j) div 2
            else aIndent := (Height - j) div 2;
          end;

        if not IsRightToLeft or not aHorizontal then aRight := aIndent
        else
        begin
          aRight := Width - FTextExtent.cx - CaptionSpacing - aIndent;
          if aIndent > 0 then dec(aRight, CaptionSpacing);
        end;

        Canvas.Brush.Style := bsClear;
        if aHorizontal then begin
          Canvas.Font.Orientation := 0;
          if not IsRightToLeft then
            Canvas.TextOut(aIndent, 0, Caption)
          else
            Canvas.TextOut(Width - FTextExtent.cx - aIndent, 0, Caption);
        end
        else
        begin
          Canvas.Font.Orientation := 900;
          Canvas.TextOut(0, aIndent + FTextExtent.cx, Caption);
        end;
						end;
		end;
end;

end.
