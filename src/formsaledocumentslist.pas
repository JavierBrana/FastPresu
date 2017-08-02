unit formSaleDocumentsList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, ZVDateTimePicker, SpkRollPanel, ZDataset,
  Forms,
  formListForm,
  Controls, Dialogs, ExtCtrls, StdCtrls, Buttons,
  ComCtrls, DBGrids, Menus;

type

  { TSaleDocumentsList }

  TSaleDocumentsList = class(TListForm)
    bDelete: TSpeedButton;
    bDuplicate: TSpeedButton;
    bEdit: TSpeedButton;
    bNew: TSpeedButton;
    bPrint: TSpeedButton;
    cbDate: TCheckBox;
    dsSaleDocs: TDataSource;
    dtBegin: TZVDateTimePicker;
    dtEnd: TZVDateTimePicker;
    edFilter: TEdit;
    edFilterDate: TComboBox;
    edFilterSelector: TComboBox;
    Grid: TDBGrid;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    miColumns: TMenuItem;
    miDelete: TMenuItem;
    miEdit: TMenuItem;
    miEditar: TMenuItem;
    miNewDocument: TMenuItem;
    Panel1: TPanel;
    pFooter: TPanel;
    pmColumns: TPopupMenu;
    pMoreOptions: TSpkRollPanel;
    tcSelector: TTabControl;
    ztSaleDocs: TZTable;
    ztSaleDocsCODE: TStringField;
    ztSaleDocsCOST: TFloatField;
    ztSaleDocsCREATEDAT: TDateField;
    ztSaleDocsCREATEDBY: TStringField;
    ztSaleDocsCUSTOMER_CODE: TStringField;
    ztSaleDocsCUSTOMER_NAME: TStringField;
    ztSaleDocsDELIVERY_DATE: TDateField;
    ztSaleDocsID: TLargeintField;
    ztSaleDocsPRICE: TFloatField;
    ztSaleDocsPROJECT_CODE: TStringField;
    ztSaleDocsPROJECT_TITLE: TStringField;
    ztSaleDocsSTATE: TStringField;
    ztSaleDocsSTATE_NUMBER: TLargeintField;
    ztSaleDocsTAX: TLargeintField;
    ztSaleDocsTITLE: TStringField;
    ztSaleDocsTYPE: TStringField;
    ztSaleDocsVALIDTO: TDateField;
    procedure bDeleteClick(Sender: TObject);
    procedure bDuplicateClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bNewClick(Sender: TObject);
    procedure dtBeginChange(Sender: TObject);
    procedure edFilterDateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure pmColumnsPopup(Sender: TObject);
    procedure pMoreOptionsPaint(Sender: TObject);
    procedure tcSelectorChange(Sender: TObject);
  private
    { private declarations }
    procedure DoFilter;
    procedure MenuClick(Sender: TObject);
    procedure ConvertDocumentoTo(Sender: TObject);
  public
    { public declarations }
  end;

var
  SaleDocumentsList: TSaleDocumentsList;

implementation
uses
  LCLType,
  Utiles,
  formSaleDocuments,
  formMainWindow,
  formBudgets,
  formWorkForm;

{$R *.lfm}

procedure TSaleDocumentsList.FormCreate(Sender: TObject);
var
  i: integer;
  it: TMenuItem;
begin
  pMoreOptions.RollMode := rmRoll;
  ztSaleDocs.Active := True;

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

procedure TSaleDocumentsList.FormResize(Sender: TObject);
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

procedure TSaleDocumentsList.MenuClick(Sender: TObject);
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

procedure TSaleDocumentsList.FormShow(Sender: TObject);
begin
  doFilter;
end;

procedure TSaleDocumentsList.GridDblClick(Sender: TObject);
begin
  bEditClick(Sender);
end;

procedure TSaleDocumentsList.GridKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) then
  begin
    if key = VK_A then
    begin
      ztSaleDocs.DisableControls;
      ztSaleDocs.First;
      while not ztSaleDocs.EOF do
      begin
        Grid.SelectedRows.CurrentRowSelected := True;
        ztSaleDocs.Next;
      end;
      ztSaleDocs.EnableControls;
    end;
  end;

  case Key of
    VK_F5: ztSaleDocs.Refresh;
    VK_DELETE: bDeleteClick(Sender);
  end;
end;

procedure TSaleDocumentsList.pmColumnsPopup(Sender: TObject);
var
  i: integer;
  it: TMenuItem;
begin
  pmColumns.Items[6].Clear;
  for i := 0 to tcSelector.Tabs.Count - 1 do
  begin
    //if tcSelector.TabIndex = i then continue;
    it := TMenuItem.Create(pmColumns);
    it.Caption := tcSelector.Tabs[i];
    it.OnClick := @ConvertDocumentoTo;
    if tcSelector.TabIndex = i then
      it.Visible := False;
    pmColumns.Items[6].Add(it);
  end;
end;

procedure TSaleDocumentsList.pMoreOptionsPaint(Sender: TObject);
begin

end;

procedure TSaleDocumentsList.ConvertDocumentoTo(Sender: TObject);
var
  i: integer;
  form: TSaleDocuments;
begin
  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztSaleDocs.GotoBookmark(Grid.SelectedRows.Items[i]);
    form := TSaleDocuments.Create(Application, ztSaleDocs.FieldByName('CODE').Text,
      TMenuItem(Sender).MenuIndex, doCopy);
    form.Show;
    form.SetFocus;
  end;
end;

procedure TSaleDocumentsList.tcSelectorChange(Sender: TObject);
begin
  doFilter;
end;

procedure TSaleDocumentsList.edFilterDateChange(Sender: TObject);
begin
  case edFilterDate.ItemIndex of
    0, 1: dtEnd.Enabled := False;
    2: dtEnd.Enabled := True;
  end;
end;

procedure TSaleDocumentsList.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  Visible := False;
  if not Floating then
    ManualFloat(ClientRect);
  SaleDocumentsList := nil;
end;

procedure TSaleDocumentsList.dtBeginChange(Sender: TObject);
begin
  doFilter;
end;

procedure TSaleDocumentsList.bNewClick(Sender: TObject);
var
  form: TWorkForm;
begin
  if tcSelector.TabIndex = 0 then form := TBudgets.Create(Application, '', tcSelector.TabIndex)
  else form := TSaleDocuments.Create(Application, '', tcSelector.TabIndex);

  form.Show;
  form.SetFocus;
end;

procedure TSaleDocumentsList.bEditClick(Sender: TObject);
var
  i: integer;
  form : TForm;
begin
  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztSaleDocs.GotoBookmark(Grid.SelectedRows.Items[i]);
    if tcSelector.TabIndex = 0 then
      form := TBudgets.Create(Application, ztSaleDocs.FieldByName('CODE').Text,
              tcSelector.TabIndex, doEdit)
    else
      form := TSaleDocuments.Create(Application, ztSaleDocs.FieldByName('CODE').Text,
            tcSelector.TabIndex, doEdit);
    form.Show;
    form.SetFocus;
  end;
end;

procedure TSaleDocumentsList.bDuplicateClick(Sender: TObject);
var
  i: integer;
  form : TForm;
begin
  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztSaleDocs.GotoBookmark(Grid.SelectedRows.Items[i]);
    if tcSelector.TabIndex = 0 then
      form := TBudgets.Create(Application, ztSaleDocs.FieldByName('CODE').Text,
              tcSelector.TabIndex, doCopy)
    else
        form := TSaleDocuments.Create(Application, ztSaleDocs.FieldByName('CODE').Text,
            tcSelector.TabIndex, doCopy);
    form.Show;
    form.SetFocus;
  end;
end;

procedure TSaleDocumentsList.bDeleteClick(Sender: TObject);
var
  i: integer;
  ZQ: TZQuery;
begin
  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;

  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztSaleDocs.GotoBookmark(Grid.SelectedRows.Items[i]);
    sqlEXEC(ZQ, 'DELETE FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE = ' +
      QuotedStr(ztSaleDocs.FieldByName('CODE').Text), false);
    sqlEXEC(ZQ, 'DELETE FROM TASK WHERE PROJECTID = ' +
      QuotedStr(ztSaleDocs.FieldByName('CODE').Text), false);
    sqlEXEC(ZQ, 'DELETE FROM TASKCONNECTIONS WHERE PROJECTID = ' +
      QuotedStr(ztSaleDocs.FieldByName('CODE').Text), false);

    ztSaleDocs.Delete;
  end;
  ztSaleDocs.Refresh;

end;

procedure TSaleDocumentsList.DoFilter;
var
  filter: string;
begin
  filter := '';
  if edFilter.Text <> '' then
  begin
    case edFilterSelector.ItemIndex of
      0: filter := 'CODE LIKE ';
      1: filter := 'TITLE LIKE ';
      2: filter := 'CUSTOMER_NAME LIKE ';
    end;
    filter := filter + QuotedStr('*' + edFilter.Text + '*') + ' AND ';
  end;

  if pMoreOptions.RollMode = rmRoll then
  begin
    if cbDate.Checked then
    begin
      case edFilterDate.ItemIndex of
        0: filter := filter + 'CREATEDBY >= ' + DateToStr(dtBegin.Date);
        1: filter := filter + 'CREATEDBY <=' + DateToStr(dtBegin.Date);
        2: filter := filter + 'CREATEDBY BETWEEN ' + DateToStr(dtBegin.Date) +
            ' AND ' + DateToStr(dtEnd.Date);
      end;
      filter := filter + ' AND ';
    end;

  end;
  filter := filter + 'TYPE = ';

  case tcSelector.TabIndex of
    0: filter := filter + QuotedStr('PR');
    1: filter := filter + QuotedStr('FP');
    2: filter := filter + QuotedStr('BI');
    3: filter := filter + QuotedStr('PA');
    4: filter := filter + QuotedStr('DN');
  end;

  ztSaleDocs.Filtered := False;
  ztSaleDocs.FilterOptions := [foCaseInsensitive];
  ztSaleDocs.Filter := filter;
  ztSaleDocs.Filtered := True;
end;

end.
