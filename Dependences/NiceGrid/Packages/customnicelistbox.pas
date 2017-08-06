unit CustomNiceListBox;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LMessages;

type
  TCustomNiceListBox = class(TListBox)
  private
    { Private declarations }
    procedure LMDrawListItem(var TheMessage: TLMDrawListItem); message LM_DrawListItem;// override;
  protected
    { Protected declarations }
    procedure DrawItem(Index: Integer; ARect: TRect; State: TOwnerDrawState); override;
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation
uses
  LCLType, LCLIntf;

procedure Register;
begin
  RegisterComponents('priyatna.org',[TCustomNiceListBox]);
end;

procedure TCustomNiceListBox.LMDrawListItem(var TheMessage: TLMDrawListItem);
begin
  with TheMessage.DrawListItemStruct^ do
  begin
    Canvas.Handle := DC;
    if Assigned(Font) then
      Canvas.Font := Font;
    if Assigned(Brush) then
      Canvas.Brush := Brush;

    if (ItemID <> UINT(-1)) and (odSelected in ItemState) then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText
    end else
    begin
      Canvas.Brush.Color := GetColorResolvingParent;
      Canvas.Font.Color := clWindowText;
    end;

    DrawItem(ItemID, Area, ItemState);

    //if odFocused in ItemState then
    //  DrawFocusRect(DC, Area);

    Canvas.Handle := 0;
  end;
end;

procedure TCustomNiceListBox.DrawItem(Index: Integer; ARect: TRect;
  State: TOwnerDrawState);
begin
  inherited DrawItem(Index, ARect, State);

end;

end.
