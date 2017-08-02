unit formBuyDocumentsList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, SpkRollPanel, ZVDateTimePicker, ZDataset,
  Forms,
  formListForm,
  Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls,
  DBGrids;

type

  { TBuyDocumentsList }

  TBuyDocumentsList = class(TListForm)
    bDelete: TSpeedButton;
    bDuplicate: TSpeedButton;
    bEdit: TSpeedButton;
    bNew: TSpeedButton;
    bPrint: TSpeedButton;
    cbDate: TCheckBox;
    dsBuyDocs: TDataSource;
    dtBegin: TZVDateTimePicker;
    dtEnd: TZVDateTimePicker;
    edFilter: TEdit;
    edFilterDate: TComboBox;
    edFilterSelector: TComboBox;
    Grid: TDBGrid;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    pFooter: TPanel;
    pMoreOptions: TSpkRollPanel;
    tcSelector: TTabControl;
    ztBuyDocs: TZTable;
    ztBuyDocsCODE: TStringField;
    ztBuyDocsCREATEDAT: TDateTimeField;
    ztBuyDocsPRICE: TFloatField;
    ztBuyDocsPROJECT_NAME: TStringField;
    ztBuyDocsSUPPLIER_NAME: TStringField;
    ztBuyDocsTAX: TLongintField;
    ztBuyDocsVALIDTO: TDateTimeField;
    procedure bDeleteClick(Sender: TObject);
    procedure bDuplicateClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bNewClick(Sender: TObject);
    procedure edFilterSelectorChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
  private
    { private declarations }
    procedure DoFilter;
  public
    { public declarations }
  end;

var
  BuyDocumentsList: TBuyDocumentsList;

implementation

uses
  formBuyDocuments,
  FormMainWindow,
  Utiles;

{$R *.lfm}

{ TBuyDocumentsList }
procedure TBuyDocumentsList.DoFilter;
var
  filter: string;
begin
  filter := '';
  if edFilter.Text <> '' then
  begin
    case edFilterSelector.ItemIndex of
      0: filter := 'CODE = ';
      //1: filter := 'dcdoDes LIKE ';
      2: filter := 'SUPPLIER_NAME = ';
    end;
    filter := filter + QuotedStr('*' + edFilter.Text + '*') + ' AND ';
  end;

  if pMoreOptions.RollMode = rmRoll then
  begin
    if cbDate.Checked then
    begin
      case edFilterDate.ItemIndex of
        0: filter := filter + 'CREATEDAT >= ' + DateToStr(dtBegin.Date);
        1: filter := filter + 'CREATEDAT <=' + DateToStr(dtBegin.Date);
        2: filter := filter + 'CREATEDAT BETWEEN ' + DateToStr(dtBegin.Date) +
            ' AND ' + DateToStr(dtEnd.Date);
      end;
      filter := filter + ' AND ';
    end;

  end;
  filter := filter + 'TYPE = ';

  case tcSelector.TabIndex of
    0: filter := filter + QuotedStr('BP');
    1: filter := filter + QuotedStr('OR');
    2: filter := filter + QuotedStr('WB');
    3: filter := filter + QuotedStr('RO');
    4: filter := filter + QuotedStr('PA');
    5: filter := filter + QuotedStr('BB');
  end;

  ztBuyDocs.Filtered := False;
  ztBuyDocs.FilterOptions := [foCaseInsensitive];
  ztBuyDocs.Filter := filter;
  ztBuyDocs.Filtered := True;
end;

procedure TBuyDocumentsList.FormCreate(Sender: TObject);
begin
  pMoreOptions.RollMode := rmRoll;
  ztBuyDocs.Active := True;
end;

procedure TBuyDocumentsList.FormResize(Sender: TObject);
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

procedure TBuyDocumentsList.GridDblClick(Sender: TObject);
begin
  bEditClick(Sender);
end;

procedure TBuyDocumentsList.bNewClick(Sender: TObject);
begin
  TBuyDocuments.Create(Application, '', tcSelector.TabIndex).Show;
end;

procedure TBuyDocumentsList.edFilterSelectorChange(Sender: TObject);
begin
  doFilter;
end;

procedure TBuyDocumentsList.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  Visible := False;
  if not Floating then
    ManualFloat(ClientRect);
  BuyDocumentsList := nil;
end;

procedure TBuyDocumentsList.bEditClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztBuyDocs.GotoBookmark(Grid.SelectedRows.Items[i]);
    TBuyDocuments.Create(Application, ztBuyDocs.FieldByName('CODE').Text,
      tcSelector.TabIndex, doEdit).Show;
  end;
end;

procedure TBuyDocumentsList.bDuplicateClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztBuyDocs.GotoBookmark(Grid.SelectedRows.Items[i]);
    TBuyDocuments.Create(Application, ztBuyDocs.FieldByName('CODE').Text,
      tcSelector.TabIndex, doCopy).Show;
  end;
end;

procedure TBuyDocumentsList.bDeleteClick(Sender: TObject);
var
  i: integer;
  ZQ: TZQuery;
begin
  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;

  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztBuyDocs.GotoBookmark(Grid.SelectedRows.Items[i]);
    sqlEXEC(ZQ, 'DELETE FROM BUYDOCUMENTDATA WHERE BUYDOCUMENT_CODE = ' +
      QuotedStr(ztBuyDocs.FieldByName('CODE').Text));
    ztBuyDocs.Delete;
  end;
  ztBuyDocs.Refresh;
end;

end.
