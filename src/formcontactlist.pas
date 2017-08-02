unit formContactList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, ZDataset, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DBGrids, Menus;

type

  { TContactList }

  TContactList = class(TForm)
    bDelete: TSpeedButton;
    bEdit: TSpeedButton;
    bNew: TSpeedButton;
    bPrint: TSpeedButton;
    dsContacts: TDataSource;
    edFilter: TEdit;
    edFilterSelector: TComboBox;
    Grid: TDBGrid;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    miAbono: TMenuItem;
    miAlbaran: TMenuItem;
    miColumns: TMenuItem;
    miDelete: TMenuItem;
    miEdit: TMenuItem;
    miEditar: TMenuItem;
    miFactura: TMenuItem;
    miFacturaPreforma: TMenuItem;
    miNewDocument: TMenuItem;
    miPresupuesto: TMenuItem;
    Panel1: TPanel;
    pFooter: TPanel;
    pmColumns: TPopupMenu;
    ztContacts: TZTable;
    procedure bNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ContactList: TContactList;

implementation

uses
  formContact;

{$R *.lfm}

{ TContactList }

procedure TContactList.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  Visible := False;
  if not Floating then
    ManualFloat(ClientRect);
  ContactList := nil;
end;

procedure TContactList.FormResize(Sender: TObject);
var
  w, i: integer;
begin
  w := pFooter.Width div pFooter.ControlCount;
  for i := 0 to pFooter.ControlCount - 1 do
  begin
    pFooter.Controls[i].Width := W;
    if pFooter.Width < 450 then
    begin
      TSpeedButton(pFooter.Controls[i]).ShowCaption := false;
    end
    else
      TSpeedButton(pFooter.Controls[i]).ShowCaption := true;
  end;
end;

procedure TContactList.bNewClick(Sender: TObject);
begin
  TContact.Create(Application, '').Show;
end;

end.

