unit ControlDragObject;

{$mode objfpc}{$H+}

interface

uses
  LMessages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TControlDragObject = class(TDragControlObject)
  private
    FDragImages: TDragImageList;
    FX, FY: Integer;
    withbitmap: Boolean;
    bitmap : TBitmap;
  protected
    function GetDragImages: TDragImageList; override;
  public
    constructor CreateWithHotSpot(WinControl: TWinControl; X, Y: Integer);
    constructor CreateWithBitmap(WinControl: TWinControl; Graphics: TBitmap);
    destructor Destroy; override;
  end;

  procedure FixControlStyles(Parent: TControl);

implementation


{ TControlDragObject }

constructor TControlDragObject.CreateWithHotSpot(WinControl: TWinControl; X, Y: Integer);
begin
  inherited Create(WinControl);
  FX := X;
  FY := Y;
  withbitmap := false;
end;

constructor TControlDragObject.CreateWithBitmap(WinControl: TWinControl; Graphics: TBitmap);
begin
  inherited Create(WinControl);
  bitmap := Graphics;
  withbitmap := true;
end;

destructor TControlDragObject.Destroy;
begin
  FDragImages.Free;
  inherited;
end;

function TControlDragObject.GetDragImages: TDragImageList;
var
  Bmp: TBitmap;
  Idx: Integer;
begin
  if not Assigned(FDragImages) then
    FDragImages := TDragImageList.Create(nil);
  Result := FDragImages;
  Result.Clear;

  if withbitmap then
  begin
    Idx := FDragImages.AddMasked(bitmap, clBtnFace);
    FDragImages.SetDragImage(Idx, -20, 0);
    exit;
  end;

  Bmp := TBitmap.Create;
  try
    Bmp.Width := Control.Width;
    Bmp.Height := Control.Height;
    Bmp.Canvas.Lock;
    try
      //Draw control in bitmap
      (Control as TWinControl).PaintTo(Bmp.Canvas.Handle, 0, 0);
    finally
      Bmp.Canvas.UnLock
    end;
    FDragImages.Width := Control.Width;
    FDragImages.Height := Control.Height;
    Idx := FDragImages.AddMasked(Bmp, clBtnFace);
    FDragImages.SetDragImage(Idx, FX, FY);
  finally
    Bmp.Free
  end

end;

procedure FixControlStyles(Parent: TControl);
var
  I: Integer;
begin
  Parent.ControlStyle := Parent.ControlStyle + [csDisplayDragImage];
  if Parent is TWinControl then
    with TWinControl(Parent) do
      for I := 0 to ControlCount - 1 do
        FixControlStyles(Controls[I]);
end;

end.
