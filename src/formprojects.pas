unit formProjects;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, DBZVDateTimePicker, ZVDateTimePicker,
  NiceGrid, NiceLookUpComboBox, gsGantt, NiceDividerBevel, NicePageControl,
  BCPanel, BCButton, SpkExpandPanel, SpkRollPanel, ZDataset, ZSequence, Forms,
  formWorkForm, db, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls, StdCtrls,
  Buttons, ComCtrls, Grids, Menus, CheckLst, u_project_items_tree;

type

  { TProjects }

  TProjects = class(TWorkForm)
    bClientEdit: TBitBtn;
    BCPanel2: TBCPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    bPrint1: TBCButton;
    bPrint2: TBCButton;
    cbAsPreform: TCheckBox;
    clDocuments: TCheckListBox;
    DBText1: TDBText;
    dsClient: TDataSource;
    dsProject: TDataSource;
    DBMemo1: TDBMemo;
    edCountryID: TDBLookupComboBox;
    edCP: TDBLookupComboBox;
    edCName: TDBEdit;
    edDir1: TDBEdit;
    edDir2: TDBEdit;
    edDocCode: TDBEdit;
    edPais: TDBEdit;
    edPobla: TDBEdit;
    edProvincia: TDBEdit;
    edState: TDBComboBox;
    edTitle: TDBEdit;
    gbNormalDirection: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    gsGantt: TgsGantt;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    miBill: TMenuItem;
    miDeleteRow: TMenuItem;
    miInsertInstalled: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    ngDataInput: TNiceGrid;
    edCID: TNiceLookUpComboBox;
    pcAll: TPageControl;
    pmGrid: TPopupMenu;
    pmCalendar: TPopupMenu;
    rbBillAll: TRadioButton;
    rbBillByDates: TRadioButton;
    rbAllDocuments: TRadioButton;
    rbSelectDocuments: TRadioButton;
    ScrollBox1: TScrollBox;
    SeparatorBevel1: TBevel;
    SpkRollPanel1: TSpkRollPanel;
    Splitter1: TSplitter;
    Gantt: TTabSheet;
    TabControl1: TTabControl;
    TabSheet1: TTabSheet;
    tsDocument: TTabSheet;
    tsGeneral: TTabSheet;
    tsMaterialsList: TTabSheet;
    zqClient: TZQuery;
    zqClientCODE: TStringField;
    zqClientID_NUMBER: TStringField;
    zqClientNAME: TStringField;
    zqProject: TZQuery;
    zqInstalled: TZQuery;
    zqProjectADDRESS1: TStringField;
    zqProjectADDRESS2: TStringField;
    zqProjectCITY: TStringField;
    zqProjectCODE: TStringField;
    zqProjectCONTACT: TStringField;
    zqProjectCREATEDAT: TDateTimeField;
    zqProjectCREATEDBY: TStringField;
    zqProjectCUSTOMER_CODE: TStringField;
    zqProjectCUSTOMER_NAME: TStringField;
    zqProjectDURATION: TDateField;
    zqProjectEMAIL: TStringField;
    zqProjectID: TLargeintField;
    zqProjectMOBILE: TStringField;
    zqProjectPHONE: TStringField;
    zqProjectPOSTCODE: TStringField;
    zqProjectpyGantt: TBlobField;
    zqProjectSTART_DATE: TDateField;
    zqProjectSTATE: TStringField;
    zqProjectTITLE: TStringField;
    ZVDateTimePicker1: TZVDateTimePicker;
    ZVDateTimePicker2: TZVDateTimePicker;
    procedure BitBtn1Click(Sender: TObject);
    procedure bPrint1Click(Sender: TObject);
    procedure bPrint2Click(Sender: TObject);
    procedure bSaveClick(Sender: TObject);override;
    procedure dsProjectStateChange(Sender: TObject);
    procedure edCIDSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure miBillClick(Sender: TObject);
    procedure miDeleteRowClick(Sender: TObject);
    procedure miInsertInstalledClick(Sender: TObject);
    procedure edCIDLookupClose(Sender: TObject;
      LookupResult: TStringList);
    procedure ngDataInputBeforeShowEdit(Sender: TObject; ARec: TRect;
      var aCanShow: boolean);
    procedure ngDataInputCellExit(Sender: TObject; ACol, ARow: integer);
    procedure ngDataInputColRowChanged(Sender: TObject; ACol, ARow: integer);
    procedure ngDataInputDeleteRow(Sender: TObject; ARow: integer);
    procedure ngDataInputDrawCell(Sender: TObject; ACanvas: TCanvas; ACol,
      ARow: integer; Rc: TRect; var Handled: boolean);
    procedure ngDataInputGutterClick(Sender: TObject; ARow: integer;
      Button: TMouseButton; Shift: TShiftState);
    procedure ngDataInputInsertRow(Sender: TObject; ARow: integer);
    procedure pmGridPopup(Sender: TObject);
    procedure rbBillByDatesChange(Sender: TObject);
    procedure rbSelectDocumentsChange(Sender: TObject);
  private
    { private declarations }
    oldText: string;
    FNeedSave: boolean;
    FProjects: TProjectItems;


    procedure SaveInstalled;
    procedure LoadInstalled;
  public
    { public declarations }
    destructor Destroy; override;
    procedure ImportBudget(aDocCode: string = '');
  end;

//var
  //Project: TProjects;

implementation
uses
  Math,
  StrUtils,
  Utiles,
  FormMainWindow,
  formSaleDocuments;

{$R *.lfm}

{ TProjects }

destructor TProjects.Destroy;
begin
  FProjects.Free;
  inherited Destroy;
end;

procedure TProjects.FormCreate(Sender: TObject);
begin
  FProjects := TProjectItems.Create(ngDataInput);

  gsGantt.Tree.Columns.Items[0].Visible := false;
  //gsGantt.Tree.Columns.Items[0].Visible := false;
  gsGantt.Tree.Columns.Items[5].Visible := false;
  gsGantt.Tree.Columns.Items[6].Visible := false;
  gsGantt.MinorScale:=tsDay;
  gsGantt.MajorScale:=tsWeekNumPlain;

  if DocCode = '' then
  begin
    sqlEXEC(zqProject, 'SELECT * FROM PROJECT WHERE ID = -1 LIMIT 1');
    zqProject.Append;
    DocCode := 'Nuevo';
  end
  else
  begin
    sqlEXEC(zqProject, 'SELECT * FROM PROJECT WHERE CODE = ' + QuotedStr(DocCode));
    ButtonSaveEnabled := False;

    LoadGantt(gsGantt, DocCode);
    LoadInstalled;
  end;

  Caption := 'Proyecto: ' + DocCode;

  zqClient.Active := true;
  ManualDock(MainWindow.TabDockCenter);
  Visible := True;

  gsGantt.Calendar.StartDate := Date - 1;
  FNeedSave := false;

  {$IFDEF DEBUG}
  ngDataInput.Columns.Items[7].Visible := True;
  {$ENDIF}
end;

procedure TProjects.miBillClick(Sender: TObject);
var
  i: integer;
begin
  rbSelectDocuments.Checked := true;
  for i:=0 to clDocuments.Count - 1 do
  begin
    if clDocuments.Items[i] = ngDataInput.CellsT['CODE', ngDataInput.Row] then
      clDocuments.Checked[i] := true
    else
      clDocuments.Checked[i] := false;
  end;
  SpkRollPanel1.Visible := true;
end;

procedure TProjects.miDeleteRowClick(Sender: TObject);
var
  aItem: TProjectItem;
begin

  aItem := TProjectItem(ngDataInput.Rows[ngDataInput.Row].ExternalObject);
  if assigned(aItem) then
  begin
    aItem.Free;
  end;
end;

procedure TProjects.ImportBudget(aDocCode: string);

  function IsElement(aType: String): boolean;
  var
    i: integer;
    ElementType: array[0..4] of string = ('UO', 'MA', 'MO', 'HE', 'DI');
  begin
    for i := 0 to 3 do
      if aType = ElementType[i] then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;

  procedure InsertDocument(aCode: string; aParent: TProjectItem);
  var
    ZQ: TZQuery;
    aRow: Integer;
    aItem: TProjectItem;
  begin
    ZQ := TZQuery.Create(self);
    ZQ.Connection := MainWindow.zcMainConnection;
    sqlEXEC(ZQ, 'SELECT * FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE = ' + QuotedStr(aCode));

    ZQ.First;
    while not ZQ.EOF do
    begin

      if not IsElement (ZQ.FieldByName('ELEMENT_TYPE').Text) or
         (ZQ.FieldByName('ELEMENT_INDEX').AsInteger > 0)then
      begin
        ZQ.Next;
        Continue;
      end;

      aRow := ngDataInput.RowCount;
      ngDataInput.RowCount := aRow + 1;
      aItem := TProjectItem.Create(aParent);
      aItem.Row := ngDataInput.Rows[aRow];
      aItem.Code := ZQ.FieldByName('NODEINDEX').Text;
      aItem.Title := ZQ.FieldByName('ELEMENT_CODE').Text + ' - ' +
                     ZQ.FieldByName('ELEMENT_TITLE').Text;
      aItem.TotalAmount := ZQ.FieldByName('ELEMENT_TOTAL_AMOUNT').AsFloat;
      aItem.UnitOfElement := ZQ.FieldByName('ELEMENT_UNIT').Text;
      aItem.TypeOfItem := 'TAS';
      aItem.TypeOfElement := ZQ.FieldByName('ELEMENT_TYPE').Text;;

      ZQ.Next;
    end;
  end;

  function IsOpened(aCode : string): boolean;
  var
    i: Integer;
  begin
    Result := false;
    for i := 0 to FProjects.ItemList.Count - 1 do
    begin
      if TProjectItem(FProjects.ItemList[i]).Code = aCode then
      begin
        Result := true;
        break;
      end;
    end;
  end;

var
  ZQ: TZQuery;
  aRow: integer;
  aTask: TInterval;
  command: string;
  aItem: TProjectItem;
begin

  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;
  command := 'SELECT CODE, TITLE FROM SALEDOCUMENT WHERE PROJECT_CODE = ' + QuotedStr(DocCode);
  if aDocCode <> '' then
    command := command + ' AND CODE = ' + QuotedStr(aDocCode);

  sqlEXEC(ZQ, command);
  ZQ.First;

  while not ZQ.EOF do
  begin

    if IsOpened(ZQ.FieldByName('CODE').Text) then break;

    aTask := TInterval.Create(gsGantt);
    aTask.Task := ZQ.FieldByName('CODE').Text + '-' + ZQ.FieldByName('TITLE').Text;
    aTask.Visible := true;
    gsGantt.AddInterval(aTask);
    gsGantt.Tree.Cells[0, gsGantt.Tree.RowCount - 1] := ZQ.FieldByName('CODE').Text;
    LoadGantt(gsGantt, ZQ.FieldByName('CODE').Text, aTask);


    aRow := ngDataInput.RowCount;
    ngDataInput.RowCount := aRow + 1;
    aItem := FProjects.CreateItem(ngDataInput.Rows[aRow]);
    aItem.Code := ZQ.FieldByName('CODE').Text;
    aItem.Title := ZQ.FieldByName('TITLE').Text;
    aItem.TypeOfItem :=  'DOC';

    clDocuments.AddItem(ZQ.FieldByName('CODE').Text, ngDataInput.Rows[ngDataInput.RowCount - 1]);
    InsertDocument(ZQ.FieldByName('CODE').Text, aItem);

    ZQ.Next;
  end;

  FNeedSave := true;
  bSave.Enabled := true;
end;

procedure TProjects.miInsertInstalledClick(Sender: TObject);
var
  aRow: integer;
  aItem, rowItem: TProjectItem;
  row: integer;
begin

  aRow := ngDataInput.Row;
  rowItem := TProjectItem(ngDataInput.Rows[aRow].ExternalObject);
  if not assigned(rowItem) then Exit;

  case rowItem.TypeOfItem of
    'CON': rowItem := TProjectItem(rowItem.Parent);
    'DOC': Exit;
  end;

  if rowItem.HasChildren then
    row := TProjectItem(rowItem.Items[rowItem.Items.Count - 1]).Row.Index + 1
  else
    row := aRow + 1;

  ngDataInput.InsertRow(row);

  aItem := TProjectItem.Create(rowItem);
  aItem.Row := ngDataInput.Rows[row];
  aItem.TypeOfItem := 'CON';
  aItem.DateOfInstallation := Date;
  aItem.Title := 'Cantidad Instalada:';
  aItem.UnitOfElement := rowItem.UnitOfElement ;


  ngDataInput.Col := 3;
  ngDataInput.Row := row;
end;

procedure TProjects.edCIDLookupClose(Sender: TObject;
  LookupResult: TStringList);
begin
  zqProject.FieldByName('CUSTOMER_NAME').Text := LookupResult[2];
end;

procedure TProjects.ngDataInputBeforeShowEdit(Sender: TObject; ARec: TRect;
  var aCanShow: boolean);
begin
  if (ngDataInput.CellsT['cType', ngDataInput.Row] = 'CON') and
     ((ngDataInput.Columns[ngDataInput.Col].Name = 'cDone') or
      (ngDataInput.Columns[ngDataInput.Col].Name = 'cDate')) then
    aCanShow := True
  else
    aCanShow := False;
end;

procedure TProjects.ngDataInputCellExit(Sender: TObject; ACol, ARow: integer);

  procedure SetPercentToTask(aPer: double; aRow: integer);
  begin
    if Assigned(ngDataInput.Rows[aRow].ExternalObject) then
      TInterval(ngDataInput.Rows[aRow].ExternalObject).IntervalDone :=
      (TInterval(ngDataInput.Rows[aRow].ExternalObject).FinishDate -
      TInterval(ngDataInput.Rows[aRow].ExternalObject).StartDate) * aPer / 100 +
      TInterval(ngDataInput.Rows[aRow].ExternalObject).StartDate;

    gsGantt.Invalidate;
  end;


begin
  if ngDataInput.RowCount = 0 then Exit;
  if (ACol = -1) or(ARow = -1) then Exit;

  if (oldText <> ngDataInput.Cells[ACol, ARow]) and
     (ngDataInput.CellsT['cType', ARow] = 'CON') then
  begin
    case ACol of
      3: TProjectItem(ngDataInput.Rows[ARow].ExternalObject).InstalledAmount :=
           StrToFloatDef(ngDataInput.Cells[ACol, ARow],0);
    end;
  end;
end;

procedure TProjects.ngDataInputColRowChanged(Sender: TObject; ACol,
  ARow: integer);
begin
  if ngDataInput.RowCount = 0 then Exit;
  if (ACol = -1) or(ARow = -1) then Exit;

  oldText := ngDataInput.Cells[ACol, ARow];
end;

procedure TProjects.ngDataInputDeleteRow(Sender: TObject; ARow: integer);
begin
  FNeedSave := true;
  bSave.Enabled := true;
end;

procedure TProjects.ngDataInputDrawCell(Sender: TObject; ACanvas: TCanvas;
  ACol, ARow: integer; Rc: TRect; var Handled: boolean);
begin

  if ngDataInput.CellsT['cType', ARow] = 'CON' then
    ACanvas.Font.Color := clGray//clNavy
  else
    ACanvas.Font.Color := clBlack;


  if (ngDataInput.Rows[ARow].NodeIndex = 0) then
    ACanvas.Font.Style := [fsBold]
  else
    ACanvas.Font.Style := [];
end;

procedure TProjects.ngDataInputGutterClick(Sender: TObject; ARow: integer;
  Button: TMouseButton; Shift: TShiftState);
begin
  if mbLeft = Button then
      TProjectItem(ngDataInput.Rows[ARow].ExternalObject).ToggleChildrenVisibility;
end;

procedure TProjects.ngDataInputInsertRow(Sender: TObject; ARow: integer);
begin
  FNeedSave := true;
  bSave.Enabled := true;
end;

procedure TProjects.pmGridPopup(Sender: TObject);
begin
  case ngDataInput.CellsT['cType', ngDataInput.Row] of
    'DOC':
    begin
      miBill.Visible := true;
      miInsertInstalled.Visible := false;
      miDeleteRow.Visible := false;
    end;
    'TAS':
    begin
      miBill.Visible := false;
      miInsertInstalled.Visible := true;
      miDeleteRow.Visible := false;
    end;
    'CON':
    begin
      miBill.Visible := false;
      miInsertInstalled.Visible := true;
      miDeleteRow.Visible := true;
    end;
  end;
end;

procedure TProjects.rbBillByDatesChange(Sender: TObject);
begin
  ZVDateTimePicker1.Enabled := rbBillByDates.Checked;
  ZVDateTimePicker2.Enabled := rbBillByDates.Checked;
end;

procedure TProjects.rbSelectDocumentsChange(Sender: TObject);
begin
  clDocuments.Enabled := rbSelectDocuments.Checked;
end;

procedure TProjects.dsProjectStateChange(Sender: TObject);
begin
  case dsProject.State of
    dsEdit, dsInsert: ButtonSaveEnabled := True;
    else ButtonSaveEnabled := False;
  end;
end;

procedure TProjects.edCIDSelect(Sender: TObject);
begin
  {if edCID.ItemIndex = 0 then
  begin
    TfClient.Create(Application, '').Show;
    if not (zqDocVenta.State = dsEdit) or not (zqDocVenta.State = dsInsert) then
      zqDocVenta.Edit;
    zqDocVenta.FieldByName('dvclNom').Text := '';
    zqDocVenta.FieldByName('dvclID').Text := '';
  end
  else}
  begin
    //if zqDocVenta.FieldByName('dvclNom').Text <> ztClient.FieldByName('clNom').Text then
    begin
      if not (zqProject.State = dsEdit) or not (zqProject.State = dsInsert) then
        zqProject.Edit;

      zqProject.FieldByName('pyclNom').Text := zqClient.FieldByName('clNom').Text;
		end;
	end;
end;

procedure TProjects.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited FormClose(Sender, CloseAction);

  zqProject.Cancel;
  zqClient.Cancel;
end;

procedure TProjects.bSaveClick(Sender: TObject);
var
  ZQ: TZQuery;
  num: integer;
begin

  if edTitle.Text = '' then
  begin
    edTitle.SetFocus;
    Exit;
  end;

  if edCID.Text = '' then
  begin
    edCID.SetFocus;
    Exit;
  end;

  if edCName.Text = '' then
  begin
    edCName.SetFocus;
    Exit;
  end;

  if edDocCode.Text = '' then
  begin
    ZQ := TZQuery.Create(self);
    ZQ.Connection := MainWindow.zcMainConnection;
    sqlEXEC(ZQ, 'SELECT ID FROM PROJECT ORDER by ID DESC LIMIT 1');

    num := ZQ.FieldByName('ID').AsInteger;
    if num = 0 then
      DocCode := FormatFloat('PJ00000000', 1)
    else
      DocCode := FormatFloat('PJ00000000', num + 1);
    zqProject.FieldByName('CODE').Text := DocCode;
    Caption := 'Proyecto: ' + DocCode;
    if HasParent then Parent.Caption := Caption;
  end;

  SaveGantt(gsGantt, DocCode, edTitle.Text, true);
  SaveInstalled;

  case (zqProject.State) of
    dsEdit,
    dsInsert: zqProject.Post;
  end;

  bSave.Enabled := false;
end;

procedure TProjects.SaveInstalled;
var
  i, NumRow: integer;
begin
  if not FNeedSave then Exit;

  sqlEXEC(zqInstalled, 'SELECT * FROM PROJECTCONTROL WHERE pcPYCODE = '
        + QuotedStr(DocCode));
  NumRow := zqInstalled.RecordCount;
  zqInstalled.First;

  for i := 0 to Max(ngDataInput.RowCount, NumRow)-1 do
  begin
    if (i < NumRow) then           // Actualizar registro
    begin
      zqInstalled.Edit;
    end
    else                                //  Añadir registro
    begin
      zqInstalled.Append;
      zqInstalled.FieldByName('pcPYCODE').Text := DocCode;
      zqInstalled.FieldByName('pcCREATEDAT').AsDateTime := Date;
      //zqInstalled.FieldByName('pcCREATEDBY').Text := ;
    end;

    zqInstalled.FieldByName('pcELID').Text := ngDataInput.CellsT['cCode', i];
    zqInstalled.FieldByName('pcELTITLE').Text := ngDataInput.CellsT['cBriefDescription', i];
    zqInstalled.FieldByName('pcELTOTAL').Text := ngDataInput.CellsT['cTotalAmount', i];
    zqInstalled.FieldByName('pcELINSTALLED').Text := ngDataInput.CellsT['cDone', i];
    zqInstalled.FieldByName('pcELREST').Text := ngDataInput.CellsT['cRest', i];
    zqInstalled.FieldByName('pcELUNIT').Text := ngDataInput.CellsT['cUnit', i];
    zqInstalled.FieldByName('pcELDATE').Text := ngDataInput.CellsT['cDate', i];
    zqInstalled.FieldByName('pcELTYPE').Text := ngDataInput.CellsT['cType', i];
    zqInstalled.FieldByName('pcELNODEINDEX').AsInteger := ngDataInput.Rows[i].NodeIndex;
    if assigned(ngDataInput.Rows[i].ExternalObject) then
      zqInstalled.FieldByName('pcTASK').AsString := TInterval(ngDataInput.Rows[i].ExternalObject).Id;
    zqInstalled.Post;
    zqInstalled.Next;
  end;

  FNeedSave := false;
end;

procedure TProjects.LoadInstalled;
var
  i, j: integer;
  aList: TList;
begin
  sqlEXEC(zqInstalled, 'SELECT * FROM PROJECTCONTROL WHERE pcPYCODE = '
        + QuotedStr(DocCode));

  zqInstalled.First;
  ngDataInput.RowCount := 0;
  i := 0;
  while not zqInstalled.EOF do
  begin
    ngDataInput.RowCount := i + 1;
    ngDataInput.CellsT['cCode', i] := zqInstalled.FieldByName('pcELID').Text;
    ngDataInput.CellsT['cBriefDescription', i] := zqInstalled.FieldByName('pcELTITLE').Text;
    ngDataInput.CellsT['cTotalAmount', i] := zqInstalled.FieldByName('pcELTOTAL').Text;
    ngDataInput.CellsT['cDone', i] := zqInstalled.FieldByName('pcELINSTALLED').Text;
    ngDataInput.CellsT['cRest', i] := zqInstalled.FieldByName('pcELREST').Text;
    ngDataInput.CellsT['cUnit', i] := zqInstalled.FieldByName('pcELUNIT').Text;
    ngDataInput.CellsT['cDate', i] := zqInstalled.FieldByName('pcELDATE').Text;
    ngDataInput.CellsT['cType', i] := zqInstalled.FieldByName('pcELTYPE').Text;
    ngDataInput.Rows[i].NodeIndex := zqInstalled.FieldByName('pcELNODEINDEX').AsInteger;

    if zqInstalled.FieldByName('pcTASK').Text <> '' then
    begin
      aList := TList.Create;
      gsGantt.MakeIntervalList(aList);
      for j := 0 to aList.Count - 1 do
      begin
        if String(TInterval(aList[j]).Id) = zqInstalled.FieldByName('pcTASK').Text then
        begin
          ngDataInput.Rows[i].ExternalObject := TInterval(aList[j]);
          break;
        end;
      end;
      aList.Free;
    end;

    if zqInstalled.FieldByName('pcELNODEINDEX').AsInteger = 0 then
      clDocuments.AddItem(zqInstalled.FieldByName('pcELID').Text, ngDataInput.Rows[i]);

    inc(i);
    zqInstalled.Next;
  end;
end;

procedure TProjects.bPrint1Click(Sender: TObject);
begin
  ImportBudget;
end;

procedure TProjects.BitBtn1Click(Sender: TObject);

  procedure CreateBill(aDoc: string; aPos: Integer);
  var
    aForm : TSaleDocuments;
    i: Integer;
  begin
    aForm := TSaleDocuments.Create(Application, aDoc,
             1 + integer(not cbAsPreform.Checked), doCopy);

    aForm.Show;
  end;

var
  i: integer;
begin
  if rbAllDocuments.Checked then
    for i := 0 to clDocuments.Count - 1 do
    begin
      CreateBill(clDocuments.Items[i], i);
    end;

  if rbSelectDocuments.Checked then
    for i := 0 to clDocuments.Count - 1 do
    begin
      if clDocuments.Checked[i] then
        CreateBill(clDocuments.Items[i], i);
    end;
end;

procedure TProjects.bPrint2Click(Sender: TObject);
var
  i, j: integer;
  ct, ci, percent: double;
begin
  for i := 0 to ngDataInput.RowCount - 1 do
  begin
    if ngDataInput.CellsT['cType', i] = 'TAS' then
    begin
      ct := StrToFloatDef(ngDataInput.CellsT['cTotalAmount', i], 0);
      ci := StrToFloatDef(ngDataInput.CellsT['cDone', i], 0);
      ngDataInput.CellsT['cRest', i] := FloatToStr(ct - ci);
      percent := ci * 100 / ct;
    end;
  end;
end;

end.

