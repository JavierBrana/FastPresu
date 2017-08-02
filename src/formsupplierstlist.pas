unit formSupplierstList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, ZVDateTimePicker, SpkRollPanel, ZDataset,
  Forms,
  formListForm,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons,
  ComCtrls, DBGrids, Grids, Menus;

type

  { TSupplierstList }

  TSupplierstList = class(TListForm)
    bDelete: TSpeedButton;
    bEdit: TSpeedButton;
    bNew: TSpeedButton;
    bPrint: TSpeedButton;
    dsSuppliers: TDataSource;
    edFilter: TEdit;
    edFilterSelector: TComboBox;
    Grid: TDBGrid;
    Label1: TLabel;
    Panel1: TPanel;
    pFooter: TPanel;
    ztSuppliers: TZTable;
    ztSuppliersADDRESS1: TStringField;
    ztSuppliersCITY: TStringField;
    ztSuppliersCODE: TStringField;
    ztSuppliersCOUNTRY: TStringField;
    ztSuppliersEMAIL: TStringField;
    ztSuppliersFAMILY: TStringField;
    ztSuppliersFAX: TStringField;
    ztSuppliersFORM: TStringField;
    ztSuppliersID_NUMBER: TStringField;
    ztSuppliersMOBILE: TStringField;
    ztSuppliersNAME: TStringField;
    ztSuppliersPHONE: TStringField;
    ztSuppliersPOSTCODE: TStringField;
    ztSuppliersPROVINCE: TStringField;
    ztSuppliersWEB: TStringField;
    procedure bDeleteClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bNewClick(Sender: TObject);
    procedure edFilterSelectorChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
    procedure DoFilter;
  public
    { public declarations }
  end;

var
  SupplierstList: TSupplierstList;

implementation

uses
  formSupplier,
  formMainWindow,
  Utiles, LCLType;

{$R *.lfm}

{ TSupplierstList }
procedure TSupplierstList.DoFilter;
var
  filter: string;
begin
  filter := '';
  if edFilter.Text <> '' then
  begin
    case edFilterSelector.ItemIndex of
      0: filter := 'CODE = ' + QuotedStr('*' + edFilter.Text + '*');
      1: filter := 'NAME = ' + QuotedStr('*' + edFilter.Text + '*');
      2: filter := 'ID_NUMBER = ' + QuotedStr('*' + edFilter.Text + '*');
      3: filter := 'PHONE = ' + QuotedStr('*' + edFilter.Text + '*') +
          ' OR MOBILE = ' + QuotedStr('*' + edFilter.Text + '*') +
          ' OR BILLING_PHONE = ' + QuotedStr('*' + edFilter.Text + '*') +
          ' OR BILLING_MOBILE = ' + QuotedStr('*' + edFilter.Text + '*');
    end;
  end;

  ztSuppliers.Filtered := False;
  ztSuppliers.FilterOptions := [foCaseInsensitive];
  ztSuppliers.Filter := filter;
  ztSuppliers.Filtered := True;
end;

procedure TSupplierstList.FormCreate(Sender: TObject);
begin
  ztSuppliers.Active := True;
end;

procedure TSupplierstList.FormResize(Sender: TObject);
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

procedure TSupplierstList.GridDblClick(Sender: TObject);
begin
  bEditClick(Sender);
end;

procedure TSupplierstList.GridKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) then
  begin
    if key = VK_A then
    begin
      ztSuppliers.DisableControls;
      ztSuppliers.First;
      while not ztSuppliers.EOF do
      begin
        Grid.SelectedRows.CurrentRowSelected := True;
        ztSuppliers.Next;
      end;
      ztSuppliers.EnableControls;
    end;
  end;

  case Key of
    VK_F5: ztSuppliers.Refresh;
    VK_DELETE: bDeleteClick(Sender);
  end;
end;

procedure TSupplierstList.GridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  SCol, SRow: integer;
  i: integer;
  PT: TPoint;
  RC: TRect;
  Bitmap: TBitmap;
  FDragImages: TDragImageList;
	Idx: Integer;
begin

  Grid.MouseToCell(X, Y, SCol, SRow);
  if (SCol < 0) or (SRow < 1) then Exit;

  {Bitmap := TBitmap.Create;
  Bitmap.PixelFormat := pf32bit;

  if Grid.SelectedRows.Count > 1 then
  begin
    Bitmap.Width := Grid.CellRect(1, 0).Right - Grid.CellRect(1, 0).Left;
    for i := 0 to Grid.SelectedRows.Count - 1 do
    begin
      rc := Grid.CellRect(1, Grid.SelectedRows.IndexOf(Grid.SelectedRows.Items[i]));
      bitmap.Height := bitmap.Height + rc.Bottom - rc.Top;
      bitmap.Canvas.CopyRect(Rect(0, bitmap.Height - (rc.Bottom - rc.Top),
        rc.Right - rc.Left, rc.Bottom - rc.Top),
        Grid.Canvas, rc);
      //Grid.DataSource.DataSet.Bookmark = Grid.SelectedRows.Items[i];
    end;
  end
  else
  begin
    rc := Grid.CellRect(SCol, SRow);
    bitmap.Width := rc.Right - rc.Left;
    bitmap.Height := rc.Bottom - rc.Top;
    //bitmap.Canvas.CopyRect(Rect(0, 0, bitmap.Width, bitmap.Height), Grid.Canvas, rc);
    Grid.Canvas.CopyRect(Rect(0, 0, bitmap.Width, bitmap.Height), bitmap.Canvas, rc);
  end;

  //bitmap.SaveToFile('d:\1.bmp');

  Pt := Grid.ScreenToClient(Pt);
  FDragObject := TControlDragObject.CreateWithBitmap(Grid, bitmap);}
  Grid.BeginDrag(False, 5);

end;

procedure TSupplierstList.bNewClick(Sender: TObject);
begin
  TSupplier.Create(Application, '').Show;
end;

procedure TSupplierstList.edFilterSelectorChange(Sender: TObject);
begin
  doFilter;
end;

procedure TSupplierstList.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  Visible := False;
  if not Floating then
    ManualFloat(ClientRect);
  SupplierstList := nil;
end;

procedure TSupplierstList.bEditClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztSuppliers.GotoBookmark(Grid.SelectedRows.Items[i]);
    TSupplier.Create(Application, ztSuppliers.FieldByName('CODE').Text).Show;
  end;
end;

procedure TSupplierstList.bDeleteClick(Sender: TObject);
var
  code: string;
  i: integer;
begin

  if (Application.MessageBox(
    '¿Seguro que desea eliminar los registros seleccionados?',
    'Borrar Registro', MB_YESNO or MB_ICONWARNING) <> mrYes) then
    Exit;

  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    Grid.DataSource.DataSet.GotoBookmark(Grid.SelectedRows.Items[i]);
    code := Grid.DataSource.DataSet.FieldByName('CODE').Text;
    if code = '' then
      break;

    ztSuppliers.Delete;
  end;
end;

end.
