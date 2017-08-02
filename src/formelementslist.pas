unit formElementsList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SpkRollPanel, ZDataset,
  Forms,
  formListForm,
  Controls, Graphics, Dialogs, ComCtrls, DBGrids, ExtCtrls,
  StdCtrls, Buttons, Menus, ControlDragObject;

type

  { TElementsList }

  TElementsList = class(TListForm)
    bDelete: TSpeedButton;
    bDuplicate: TSpeedButton;
    bEdit: TSpeedButton;
    bNew: TSpeedButton;
    bPrint: TSpeedButton;
    chbFamily: TCheckBox;
    chbManufacturer: TCheckBox;
    chbGamma: TCheckBox;
    edFilterFamily: TEdit;
    edFilterManufacturer: TEdit;
    edFilterGamma: TEdit;
    edFilterSelector: TComboBox;
    dsElements: TDataSource;
    edFilter: TEdit;
    Grid: TDBGrid;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    pFooter: TPanel;
    pMoreOptions: TSpkRollPanel;
    pmColumns: TPopupMenu;
    tcSelector: TTabControl;
    zqElements: TZQuery;
    zqElementsCODE: TStringField;
    zqElementsDATE_UPDATE: TDateTimeField;
    zqElementsFAMILY_ID: TStringField;
    zqElementsGAMMA: TStringField;
    zqElementsMANUFACTURER: TStringField;
    zqElementsPURCHASE_PRICE: TFloatField;
    zqElementsREAL_PRICE: TFloatField;
    zqElementsSTATE: TSmallintField;
    zqElementsTITLE: TStringField;
    zqElementsTYPE: TStringField;
    zqElementsUNIT_ID: TStringField;
    procedure bDeleteClick(Sender: TObject);
    procedure bDuplicateClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bNewClick(Sender: TObject);
    procedure bPrintClick(Sender: TObject);
    procedure dsElementsDataChange(Sender: TObject; Field: TField);
    procedure edFilterChange(Sender: TObject);
    procedure edFilterSelectorChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure GridStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure GridTitleClick(Column: TColumn);
    procedure tcSelectorChange(Sender: TObject);
  private
    { private declarations }
    FDragObject: TControlDragObject;
    procedure MenuClick(Sender: TObject);
  public
    { public declarations }
    procedure DoFilter;
    procedure New(Sender: TObject); override;
    procedure Edit(Sender: TObject); override;
    procedure Duplicate(Sender: TObject); override;
    procedure Print(Sender: TObject); override;
    procedure Delete(Sender: TObject); override;
  end;

var
  ElementsList: TElementsList;

implementation

{$R *.lfm}
uses
  LCLType, Utiles,
  formElement, formMainWindow;
  //formImportDBWizard;

{ TElementsList }
procedure TElementsList.DoFilter;
var
  filter: string;
begin
  filter := '';
  filter := 'SELECT CODE, TITLE, REAL_PRICE, PURCHASE_PRICE, FAMILY_ID, ' +
            'DATE_UPDATE, UNIT_ID, MANUFACTURER, GAMMA, STATE FROM ELEMENT WHERE ';

  if edFilter.Text <> '' then
  begin
    case edFilterSelector.ItemIndex of
      0: filter := filter + 'CODE LIKE ';
      1: filter := filter + 'TITLE LIKE ';
    end;
    filter := filter + QuotedStr('%' + edFilter.Text + '%') + ' AND ';
  end;

  if pMoreOptions.RollMode = rmUnRoll then
  begin
    if chbManufacturer.Checked and (edFilterManufacturer.Text <> '') then
      filter := filter + 'MANUFACTURER LIKE ' + QuotedStr('%' + edFilterManufacturer.Text + '%') + ' AND ';
    if chbGamma.Checked and (edFilterGamma.Text <> '') then
      filter := filter + 'GAMMA LIKE ' + QuotedStr('%' + edFilterGamma.Text + '%') + ' AND ';
    if chbFamily.Checked and (edFilterFamily.Text <> '') then
      filter := filter + 'FAMILY = ' + QuotedStr('%' + edFilterFamily.Text + '%') + ' AND ';
  end;

  filter := filter + 'TYPE = ';
  case tcSelector.TabIndex of
    0: filter := filter + QuotedStr('UO');
    1: filter := filter + QuotedStr('MA');
    2: filter := filter + QuotedStr('MO');
    3: filter := filter + QuotedStr('HE');
    4: filter := filter + QuotedStr('DI');
    5: filter := filter + QuotedStr('*');
  end;


  sqlEXEC(zqElements, filter);
  {
  zqElements.Filtered := False;
  zqElements.FilterOptions := [foCaseInsensitive];
  zqElements.Filter := filter;
  zqElements.Filtered := True;
  }
end;

procedure TElementsList.New(Sender: TObject);
begin
  TElement.Create(Application).Show;
end;

procedure TElementsList.Edit(Sender: TObject);
begin
  TElement.Create(Application, Grid.DataSource.DataSet.FieldByName('CODE').Text,
      tcSelector.TabIndex, doEdit).Show;
end;

procedure TElementsList.Duplicate(Sender: TObject);
begin
  TElement.Create(Application, Grid.DataSource.DataSet.FieldByName('CODE').Text,
      tcSelector.TabIndex, doCopy).Show;
end;

procedure TElementsList.Print(Sender: TObject);
begin

end;

procedure TElementsList.Delete(Sender: TObject);
var
  ZQ: TZQuery;
  code: string;
  i: integer;
  //DeleteItem: TDeleteDBItem;
begin

  if (Application.MessageBox(
    '¿Seguro que desea eliminar los registros seleccionados?',
    'Borrar Registro', MB_YESNO or MB_ICONWARNING) <> mrYes) then
    Exit;

  {DeleteItem := TDeleteDBItem.Create(Grid);
  if Assigned(DeleteItem.FatalException) then
     raise DeleteItem.FatalException;
  Exit; }

  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;

  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    Application.ProcessMessages;
    Grid.DataSource.DataSet.GotoBookmark(Grid.SelectedRows.Items[i]);
    code := Grid.DataSource.DataSet.FieldByName('CODE').Text;
    if code = '' then
      break;

    code := zqElements.FieldByName('CODE').Text;
    if zqElements.FieldByName('TYPE').Text = 'UO' then
      sqlEXEC(ZQ, 'DELETE FROM ELEMENTCOMPOSITION WHERE CODE = ' +
        QuotedStr(code));

    zqElements.Delete;
  end;
end;


procedure TElementsList.FormCreate(Sender: TObject);
var
  i: integer;
  it: TMenuItem;
begin
  zqElements.Open;
  //sqlEXEC(zqElements, 'SELECT CODE, TITLE, REAL_PRICE, PURCHASE_PRICE, FAMILY_ID, ' +
  //                    'DATE_UPDATE, UNIT_ID, MANUFACTURER, GAMMA, STATE FROM ELEMENT');

  pMoreOptions.RollMode := rmRoll;
  pMoreOptions.Font.Style:=[];

  pmColumns.Items.Clear;
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    it := TMenuItem.Create(pmColumns);
    it.Caption := Grid.Columns[i].Title.Caption;
    it.Checked := Grid.Columns[i].Visible;
    it.OnClick := @MenuClick;
    pmColumns.Items.Add(it);
  end;
end;

procedure TElementsList.FormResize(Sender: TObject);
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

procedure TElementsList.MenuClick(Sender: TObject);
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

procedure TElementsList.FormShow(Sender: TObject);
begin
  DoFilter;
end;

procedure TElementsList.GridDblClick(Sender: TObject);
begin
  bEditClick(Sender);
end;

procedure TElementsList.GridKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin

  if (ssCtrl in Shift) then
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
  end;

  case Key of
    VK_F5: zqElements.Refresh;
    VK_DELETE: bDeleteClick(Sender);
  end;
end;

procedure TElementsList.GridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
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
  if (SCol < 0) or (SRow < 1) then
    Exit;

  Bitmap := TBitmap.Create;
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

  //bitmap.SaveToFile('e:\1.bmp');

  Pt := Grid.ScreenToClient(Pt);
  FDragObject := TControlDragObject.CreateWithBitmap(Grid, bitmap);
  Grid.BeginDrag(False, 5);

  //FDragImages := TDragImageList.Create(nil);
  //Idx := FDragImages.AddMasked(bitmap, clBtnFace);
  //FDragImages.SetDragImage(idx, 0, 0);
  //ImageList_SetDragCursorImage((HIMAGELIST)FDragImages.Handle, 0, 0, 0);

end;

procedure TElementsList.GridStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  //DragObject := TMyDragObject.Create(Sender as TControl);
end;

procedure TElementsList.GridTitleClick(Column: TColumn);
begin
  //Grid.SortedField = Column.Field.Name;
  //Grid.SortOrder := [soAscending];
end;

procedure TElementsList.tcSelectorChange(Sender: TObject);
begin
  DoFilter;
end;

procedure TElementsList.bPrintClick(Sender: TObject);
begin
end;

procedure TElementsList.dsElementsDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TElementsList.edFilterChange(Sender: TObject);
begin
  DoFilter;
  Exit;

  if zqElements.Locate('CODE', edFilter.Text, [loCaseInsensitive,loPartialKey]) then
  begin
    Grid.SelectedRows.CurrentRowSelected := true;
    Caption := '';
	end;
end;

procedure TElementsList.edFilterSelectorChange(Sender: TObject);
begin
  DoFilter;
end;

procedure TElementsList.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  Visible := False;
  if not Floating then
    ManualFloat(ClientRect);
end;

procedure TElementsList.bEditClick(Sender: TObject);
var
  form: TElement;
begin
  form := TElement.Create(Application, Grid.DataSource.DataSet.FieldByName('CODE').Text,
          tcSelector.TabIndex, doEdit);
  form.Show;
end;

procedure TElementsList.bDuplicateClick(Sender: TObject);
begin
  TElement.Create(Application, Grid.DataSource.DataSet.FieldByName('CODE').Text,
    tcSelector.TabIndex, doCopy).Show;
end;

procedure TElementsList.bDeleteClick(Sender: TObject);
var
  ZQ: TZQuery;
  code: string;
  i: integer;
  //DeleteItem: TDeleteDBItem;
begin

  if (Application.MessageBox(
    '¿Seguro que desea eliminar los registros seleccionados?',
    'Borrar Registro', MB_YESNO or MB_ICONWARNING) <> mrYes) then
    Exit;

  {DeleteItem := TDeleteDBItem.Create(Grid);
  if Assigned(DeleteItem.FatalException) then
     raise DeleteItem.FatalException;

  Exit; }
  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;

  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    Application.ProcessMessages;
    Grid.DataSource.DataSet.GotoBookmark(Grid.SelectedRows.Items[i]);
    code := Grid.DataSource.DataSet.FieldByName('CODE').Text;
    if code = '' then break;

    if Grid.DataSource.DataSet.FieldByName('TYPE').Text = 'UO' then
      sqlEXEC(ZQ, 'DELETE FROM ELEMENTCOMPOSITION WHERE CODE = ' + QuotedStr(code));

    Grid.DataSource.DataSet.Delete;
  end;

end;

procedure TElementsList.bNewClick(Sender: TObject);
begin
  TElement.Create(Application).Show;
end;

end.
