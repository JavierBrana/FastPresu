unit formClientList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, ZVDateTimePicker, ZDataset,
  Forms,
  formListForm,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons,
  ComCtrls, DBGrids, Grids, Menus,
  ControlDragObject;

type

  { TClientList }

  TClientList = class(TListForm)
    bDelete: TSpeedButton;
    bEdit: TSpeedButton;
    bNew: TSpeedButton;
    bPrint: TSpeedButton;
    dsClients: TDataSource;
    edFilter: TEdit;
    edFilterSelector: TComboBox;
    Grid: TDBGrid;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    miDelete: TMenuItem;
    miAlbaran: TMenuItem;
    miAbono: TMenuItem;
    miPresupuesto: TMenuItem;
    miFacturaPreforma: TMenuItem;
    miFactura: TMenuItem;
    miNewDocument: TMenuItem;
    miEditar: TMenuItem;
    miEdit: TMenuItem;
    miColumns: TMenuItem;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    pFooter: TPanel;
    pmColumns: TPopupMenu;
    ztClients: TZTable;
    procedure bDeleteClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bNewClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumn; State: TGridDrawState);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure DocumentNew(Sender: TObject);
  private
    FDragObject: TControlDragObject;
    procedure DoFilter;
    procedure MenuClick(Sender: TObject);
    { private declarations }
  public
    { public declarations }
  end;

var
  ClientList: TClientList;

implementation

uses
  formClient,
  formMainWindow,
  formSaleDocuments,
  LCLType;

{$R *.lfm}

{ TClientList }
procedure TClientList.DoFilter;
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

  ztClients.Filtered := False;
  ztClients.FilterOptions := [foCaseInsensitive];
  ztClients.Filter := filter;
  ztClients.Filtered := True;
end;


procedure TClientList.FormCreate(Sender: TObject);
var
  i: integer;
  it: TMenuItem;
begin
  ztClients.Active := True;

  pmColumns.Items[0].Clear;
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    it := TMenuItem.Create(pmColumns);
    it.Caption := Grid.Columns[i].Title.Caption;
    it.Checked := Grid.Columns[i].Visible;
    it.OnClick := @MenuClick;
    pmColumns.Items[0].Add(it);
  end;
end;

procedure TClientList.FormResize(Sender: TObject);
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

procedure TClientList.MenuClick(Sender: TObject);
var
  i: integer;
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;

  for i := 0 to Grid.Columns.Count - 1 do
  begin
    if Grid.Columns[i].Title.Caption = TMenuItem(Sender).Caption then
    begin
      Grid.Columns[i].Visible := TMenuItem(Sender).Checked;
      Exit;
    end;
  end;
end;

procedure TClientList.GridDblClick(Sender: TObject);
begin
  bEditClick(Sender);
end;

procedure TClientList.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: integer; Column: TColumn; State: TGridDrawState);
var
  s: TStream;
  GraphExt: string;
  gc: TGraphicClass;
  AGraphic: TGraphic;
begin
  {if Column.Index > 0 then exit;
  ztClients.Last;
  if ztClients.FieldByName('clLogo').Size = 0 then exit;
  try
    s := ztClients.CreateBlobStream(ztClients.FieldByName('clLogo'), bmRead);
    AGraphic := nil;
    GraphExt :=  s.ReadAnsiString;  //Read file extension Graphic type from stream
    gc := GetGraphicClassForFileExtension(GraphExt);
    if assigned(gc) then
    begin
      AGraphic := gc.Create;
      AGraphic.LoadFromStream(s);
      Grid.Canvas.StretchDraw(Rect, AGraphic);
    end;
    finally
    end;}
end;

procedure TClientList.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  {if (ssCtrl in Shift) then
  begin
    if key = VK_A then
    begin
      Grid.DataSource.DataSet.DisableControls;
      zqElements.First;
      while not zqElements.EOF do
      begin
        Grid.SelectedRows.CurrentRowSelected := True;
        zqElements.Next;
      end;
      Grid.DataSource.DataSet.EnableControls;
    end;
  end;}

  case Key of
    VK_F5: self.ztClients.Refresh;
    VK_DELETE: bDeleteClick(Sender);
  end;
end;

procedure TClientList.GridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  SCol, SRow: integer;
  XX, YY, i: integer;
  PT: TPoint;
  RC: TRect;
  Bitmap: TBitmap;
  FDragImages: TDragImageList;
  Idx: integer;
  a: boolean;
begin

  Grid.MouseToCell(X, Y, SCol, SRow);
  if (SCol < 0) or (SRow < 1) then
    Exit;

  Bitmap := TBitmap.Create;
  Bitmap.PixelFormat := pf32bit;

  if Grid.SelectedRows.Count > 0 then
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
    Grid.MouseToCell(X, Y, xx, yy);
    rc := Grid.CellRect(xx, yy);
    bitmap.Width := rc.Bottom - rc.Top;
    bitmap.Height := rc.Bottom - rc.Top;
    bitmap.Canvas.CopyRect(Rect(0, 0, rc.Bottom - rc.Top, rc.Bottom - rc.Top),
      Grid.Canvas, rc);
  end;

  bitmap.SaveToFile('d:\1.bmp');

  Pt := Grid.ScreenToClient(Pt);
  //FDragObject = new TControlDragObject(Grid, Pt.X, Pt.Y );
  FDragObject := TControlDragObject.CreateWithBitmap(Grid, bitmap);

  Grid.BeginDrag(False, 5);

  FDragImages := TDragImageList.Create(nil);
  Idx := FDragImages.AddMasked(bitmap, clBtnFace);
  //FDragImages.SetDragImage(idx, 0, 0);
  //a := ImageList_SetDragCursorImage((HIMAGELIST)FDragImages.Handle, 0, 0, 0);

end;

procedure TClientList.DocumentNew(Sender: TObject);
//var
//  form: TfSaleDocuments;
begin
  //form := TfSaleDocuments.Create(Application, '', TMenuItem(Sender).MenuIndex);
  //form.Show;
end;

procedure TClientList.bNewClick(Sender: TObject);
begin
  TClient.Create(Application, '').Show;
end;

procedure TClientList.edFilterChange(Sender: TObject);
begin
  doFilter;
end;


procedure TClientList.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  Visible := False;
  if not Floating then
    ManualFloat(ClientRect);
  ClientList := nil;
end;

procedure TClientList.bEditClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztClients.GotoBookmark(Grid.SelectedRows.Items[i]);
    TClient.Create(Application, ztClients.FieldByName('CODE').Text).Show;
  end;
end;

procedure TClientList.bDeleteClick(Sender: TObject);
var
  code: string;
  i: integer;
begin

  if (Application.MessageBox(
    'Se va a proceder a borrar los registros seleccionados.' + #10 + #13 +
    '¿Desea continuar?',
    'Borrar Registro', MB_YESNO or MB_ICONWARNING) <> mrYes) then
    Exit;

  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    Grid.DataSource.DataSet.GotoBookmark(Grid.SelectedRows.Items[i]);
    code := Grid.DataSource.DataSet.FieldByName('CODE').Text;
    if code = '' then
      break;

    ztClients.Delete;
  end;
end;

end.
