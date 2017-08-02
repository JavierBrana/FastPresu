unit formBudgets;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, NiceGrid, NiceLookUpComboBox, gsGantt,
  NiceCustomPanel, CustomNiceListBox, DBZVDateTimePicker, ZDataset, Controls,
  Forms, formWorkForm, BGRABitmapTypes, BCPanel, BCButton,
  Graphics, Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, ComCtrls, EditBtn,
  Menus, DBGrids, Grids, Math, Utiles, DB, dbf,
  u_items_tree;

type

  { TBudgets }

  TBudgets = class(TWorkForm)

    BCButton1: TBCButton;
    bMakeBuyDoc1: TBCButton;
    bZoomPlus: TBCButton;
    bInsertTool: TBCButton;
    bInsertLine11: TBCButton;
    bShowCriticalPath: TBCButton;
    bInsertLabor: TBCButton;
    bInsertElement: TBCButton;
    bInsertPacket: TBCButton;
    bInsertOthers: TBCButton;
    bInsertLine6: TBCButton;
    bInsertLine7: TBCButton;

    bInsertLine: TBCButton;
    bDeleteLine: TBCButton;
    bZoomMinus: TBCButton;
    bMakeBuyDoc: TBCButton;
    bSaveElementinDB: TBCButton;
    dsClient: TDataSource;

    edPCode: TNiceLookUpComboBox;
    edTitle1: TDBEdit;
    FGantt: TgsGantt;
    bClientEdit: TBitBtn;
    BCPanel2: TBCPanel;
    DBMemo1: TDBMemo;
    dpCreationDate: TDBZVDateTimePicker;
    dpExpeditionDate: TDBZVDateTimePicker;
    dpValidate: TLabel;
    dpValidDate: TDBZVDateTimePicker;
    dsDocVenta: TDataSource;
    dsDocVentaData: TDataSource;
    dsProjects: TDataSource;
    edCID2: TDBLookupComboBox;
    edCID3: TDBLookupComboBox;
    edCName: TDBEdit;
    edDir1: TDBEdit;
    edDir2: TDBEdit;
    edDocCode: TDBEdit;
    edPais: TDBEdit;
    edPobla: TDBEdit;
    edProvincia: TDBEdit;
    edState: TDBComboBox;
    edTitle: TDBEdit;
    eGanancia: TEdit;
    eTCompra: TDBEdit;
    eTVenta: TDBEdit;
    gbNormalDirection: TGroupBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    miDeleteConnection: TMenuItem;
    MenuItem2: TMenuItem;
    miNewTask: TMenuItem;
    miEditElement: TMenuItem;
    miDelete: TMenuItem;
    MenuItem10: TMenuItem;
    miPeticionOferta: TMenuItem;
    miPedido: TMenuItem;
    miShowAll: TMenuItem;
    miHideAll: TMenuItem;
    miInsertJump: TMenuItem;
    miInsertSutTotal: TMenuItem;
    miShowComposition: TMenuItem;
    MenuItem16: TMenuItem;
    miInsertPack: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    miHideComposition: TMenuItem;
    miSaveInDB: TMenuItem;
    miSubMenuPack: TMenuItem;
    miSubMenuInsert: TMenuItem;
    miInsertLine: TMenuItem;
    NiceGrid1: TNiceGrid;
    NiceGrid2: TNiceGrid;
    edCID: TNiceLookUpComboBox;
    Panel1: TPanel;
    pcAll: TPageControl;
    pmConvertTo: TPopupMenu;
    pmGantt: TPopupMenu;
    pmLines: TPopupMenu;
    pmBuyDocuments: TPopupMenu;
    ScrollBox1: TScrollBox;
    SeparatorBevel1: TBevel;
    SeparatorBevel2: TBevel;
    SeparatorBevel3: TBevel;
    SeparatorBevel4: TBevel;
    SeparatorBevel5: TBevel;
    SeparatorBevel6: TBevel;
    SeparatorBevel7: TBevel;
    SeparatorBevel8: TBevel;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    ToolBarConvertTo: TBCPanel;
    ToolBarDocument: TBCPanel;
    ToolBarBudget1: TBCPanel;
    ToolBarBuy: TBCPanel;
    tsPlanner: TTabSheet;
    tsDocument: TTabSheet;
    tsGeneral: TTabSheet;
    tsMaterialsList: TTabSheet;
    tsSummary: TTabSheet;
    zqClientCODE: TStringField;
    zqClientID_NUMBER: TStringField;
    zqClientNAME: TStringField;
    zqDocVentaCODE: TStringField;
    zqDocVentaCOST: TFloatField;
    zqDocVentaCREATEDAT: TDateField;
    zqDocVentaCREATEDBY: TStringField;
    zqDocVentaCUSTOMER_CODE: TStringField;
    zqDocVentaCUSTOMER_NAME: TStringField;
    zqDocVentaDataBENEFIT: TFloatField;
    zqDocVentaDataCREATEDAT: TDateField;
    zqDocVentaDataCREATEDBY: TStringField;
    zqDocVentaDataDISCOUNT: TFloatField;
    zqDocVentaDataELEMENT_CODE: TStringField;
    zqDocVentaDataELEMENT_DESCRIPTION: TBlobField;
    zqDocVentaDataELEMENT_INDEX: TLargeintField;
    zqDocVentaDataELEMENT_PRICE: TFloatField;
    zqDocVentaDataELEMENT_TITLE: TStringField;
    zqDocVentaDataELEMENT_TOTAL_AMOUNT: TFloatField;
    zqDocVentaDataELEMENT_TYPE: TStringField;
    zqDocVentaDataELEMENT_UNIT: TStringField;
    zqDocVentaDataELEMENT_UNIT_AMOUNT: TFloatField;
    zqDocVentaDataID: TLargeintField;
    zqDocVentaDataNODEINDEX: TStringField;
    zqDocVentaDataSALEDOCUMENT_CODE: TStringField;
    zqDocVentaDELIVERY_DATE: TDateField;
    zqDocVentaDESCRIPTION: TBlobField;
    zqDocVentaID: TLargeintField;
    zqDocVentaPRICE: TFloatField;
    zqDocVentaPROJECT_CODE: TStringField;
    zqDocVentaPROJECT_TITLE: TStringField;
    zqDocVentaSTATE: TStringField;
    zqDocVentaSTATE_NUMBER: TLargeintField;
    zqDocVentaTAX: TLargeintField;
    zqDocVentaTITLE: TStringField;
    zqDocVentaTYPE: TStringField;
    zqDocVentaVALIDTO: TDateField;
    zqProjects: TZQuery;
    zqDocVenta: TZQuery;
    zqDocVentaData: TZQuery;
    zqClient: TZQuery;
    zqProjectsCODE: TStringField;
    zqProjectsCUSTOMER_CODE: TStringField;
    zqProjectsCUSTOMER_NAME: TStringField;
    zqProjectsTITLE: TStringField;
    procedure bClientEditClick(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
    procedure bMakeBuyDocButtonClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);override;
    procedure bShowCriticalPathClick(Sender: TObject);
    procedure bZoomMinusClick(Sender: TObject);
    procedure bZoomPlusClick(Sender: TObject);
    procedure dsDocVentaDataChange(Sender: TObject; Field: TField);
    procedure dsDocVentaStateChange(Sender: TObject);
    procedure edCIDAfterDropDown(Sender: TObject);
    procedure edPCodeAfterDropDown(Sender: TObject);
    procedure edPCodeLookupClose(Sender: TObject; LookupResult: TStringList);
    procedure edCIDChange(Sender: TObject);
    procedure edCIDCloseUp(Sender: TObject);
    procedure edCIDDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure edCIDDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure edCIDLookupClose(Sender: TObject; LookupResult: TStringList);
    procedure edStateSelect(Sender: TObject);
    procedure edTitleKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frDBDataSet1Next(Sender: TObject);
    procedure InsertarLinea(Sender: TObject);
    procedure BorrarLinea(Sender: TObject);
    procedure miConvertTo(Sender: TObject);
    procedure miEditElementClick(Sender: TObject);
    procedure miInsertSutTotalClick(Sender: TObject);
    procedure miShowAllClick(Sender: TObject);
    procedure miHideAllClick(Sender: TObject);
    procedure miShowCompositionClick(Sender: TObject);
    procedure miInsertPackClick(Sender: TObject);
    procedure miHideCompositionClick(Sender: TObject);
    procedure miSaveInDBClick(Sender: TObject);
    procedure NiceGrid1AfterDrawTextCell(Sender: TObject; ACanvas: TCanvas;
      ACol, ARow: integer; Rc: TRect);
    procedure NiceGrid1CellChange(Sender: TObject; ACol, ARow: integer;
      var Str: string);
    procedure NiceGrid1CellChanging(Sender: TObject; ACol, ARow: integer;
      var CanChange: boolean);
    procedure NiceGrid1CellExit(Sender: TObject; ACol, ARow: integer);
    procedure NiceGrid1ColRowChanged(Sender: TObject; ACol, ARow: integer);
    procedure NiceGrid1DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure NiceGrid1DragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure NiceGrid1DrawCell(Sender: TObject; ACanvas: TCanvas;
      ACol, ARow: integer; Rc: TRect; var Handled: boolean);
    procedure NiceGrid1InsertRow(Sender: TObject; ARow: integer);
    procedure NiceGrid1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure pcAllChange(Sender: TObject);
    procedure pmGanttPopup(Sender: TObject);

  private
    { private declarations }
    CellText: string;
    TP: ansistring;
    FNeedSave: boolean;
    FInterval: TInterval;

    //------------------------------------------------------------------------
    FItemsList: TList;
    //------------------------------------------------------------------------


    procedure CalPrecioUO(const aRow: integer);
    procedure CalPrecioElemento(const aRow: integer);
    procedure CalPrecioTotal;
    procedure CalSubTotal(const ARow: integer);

    function InsertarItem(Dato: ansistring; idx, ARow: integer; AParent: TObject = nil): integer;
    procedure BorrarItem(ARow: integer);

    procedure addTasks(aRow, aPos: integer);
    procedure gsGanttMouseOverInterval(Sender: TObject; aInterval: TInterval; X, Y: integer);
    procedure DeleteConnection(Sender: TObject);
    function UOIsTask(aRow: integer; aAll: boolean = true): double;
    procedure SetReadOnly;

    {$IFNDEF LITTLE_VERSION}
    procedure ConfigPermits;
    {$ENDIF}
  public
    { public declarations }
    constructor Create(TheOwner: TComponent; Code: ansistring = '';
          DocumentType: integer = 0; Operation: TDocumentOperations = doNew); reintroduce;
  end;

var
  Budgets: TBudgets;

implementation

uses
  ControlDragObject, LCLType,
  formMainWindow,
  formClient,
  formClientList,
  formElement,
  formElementsList,
  formBuyDocuments,
  formSaleDocuments,
  formProjects;

{$R *.lfm}

function calFinishDate(aDate: TDateTime; aTime: double; aUnit: String = 'h'): TDateTime;
var
  tmp: double;
  tmp1:Integer;
begin
  tmp := (aTime / FHoursPerDay);
  tmp1 := Trunc(tmp);
  tmp := (tmp - tmp1) * FHoursPerDay / 24;
  Result := aDate + tmp + tmp1;
end;

constructor TBudgets.Create(TheOwner: TComponent; Code: ansistring = '';
      DocumentType: integer = 0; Operation: TDocumentOperations = doNew);
begin
  TP := 'PR';
  {$IFNDEF LITTLE_VERSION}
  if FUser.UserName <> 'ADMIN' then
    if not FUser.Permits.GetDocPermit(TP).Read or
       not FUser.Permits.GetDocPermit(TP).Write then
    begin
      MessageDlg('No tiene PERMISO para LEER este documento.' + #13 + #10 +
                 'El documento no se va a abrir.',
          mtInformation, [mbYes], 0);
      Abort;
    end;
  {$ENDIF}
  inherited Create(TheOwner, Code, DocumentType, Operation);
end;

{$IFNDEF LITTLE_VERSION}
procedure TBudgets.ConfigPermits;
begin
  if FUser.UserName = 'ADMIN' then Exit; // Admin tiene permiso total
  if not FUser.Permits.GetDocPermit(TP).Write and
     FUser.Permits.GetDocPermit(TP).Read then
     SetReadOnly;

  if FUser.Permits.GetDocPermit(TP).Print then
  begin
    bPrint.Enabled := false;
  end;
end;
{$ENDIF}

procedure TBudgets.SetReadOnly;
var
  i: Integer;
begin
  Toolbar.Enabled := false;
  for i:= 0 to BCPanel2.ControlCount - 1 do
  begin
    if not (BCPanel2.Controls[i] is TLabel) then
      BCPanel2.Controls[i].Enabled := false;
  end;
  NiceGrid1.ReadOnly := true;
  NiceGrid1.PopupMenu := nil;
  FGantt.Enabled := false;
end;

function TBudgets.UOIsTask(aRow: integer; aAll: boolean = true): double;
var
  idx, idx1: integer;
  aTime, tmp: double;
  uni: string;
begin
  Result := 0;
  aTime := 0;

  idx := NiceGrid1.Rows[aRow].NodeIndex;
  idx1 := idx + 1;
  inc(aRow);

  while NiceGrid1.Rows[aRow].NodeIndex > idx do
  begin
    if not aAll then
      if NiceGrid1.Rows[aRow].NodeIndex > idx1 then
      begin
        inc(aRow);
        if aRow >= (NiceGrid1.RowCount) then break;
        continue;
      end;

    if NiceGrid1.CellsT['cType', aRow] = 'MO' then
    begin
      tmp := StrToFloatDef(NiceGrid1.CellsT['cTotalAmount', aRow], 0, DefaultFormatSettings);
      if aTime < tmp then
      begin
        aTime := tmp;
        uni := NiceGrid1.CellsT['cUnit', aRow];
      end;
    end;
    inc(aRow);
    if aRow >= (NiceGrid1.RowCount) then break;
  end;
  Result := aTime;
end;

procedure TBudgets.CalPrecioUO(const aRow: integer);
var
  row, Ind: integer;
  cantUO, cantEL, cantTEL, prec, ptotal, pUO, pTotalUO, ben, des: double;
begin

  Ind := NiceGrid1.Rows[aRow].NodeIndex;
  row := aRow;
  cantUO := 0;
  cantEL := 0;
  cantTEL := 0;
  prec := 0;
  ptotal := 0;
  pUO := 0;
  pTotalUO := 0;

  cantUO := StrToFloatDef(NiceGrid1.CellsT['cTotalAmount', aRow], 0);
  ben := StrToFloatDef(NiceGrid1.CellsT['cBenefit', aRow], 0);
  des := StrToFloatDef(NiceGrid1.CellsT['cDiscount', aRow], 0);

  while True do
  begin
    Inc(row);
    if row >= NiceGrid1.RowCount then
      break;
    if Ind >= NiceGrid1.Rows[row].NodeIndex then
      break;
    if NiceGrid1.Rows[row].NodeIndex > (Ind + 1) then
      continue;

    cantEL := StrToFloatDef(NiceGrid1.CellsT['cUnitAmount', row], 0);
    cantTEL := cantEL * cantUO;
    NiceGrid1.CellsT['cTotalAmount', row] := FloatToStr(cantTEL);
    if (NiceGrid1.CellsT['cType', row] = 'UO') then
      CalPrecioUO(row);
    prec := StrToFloatDef(NiceGrid1.CellsT['cUnitPrice', row], 0);
    pUO := pUO + (prec * cantEL);
    prec := prec * cantTEL;
    NiceGrid1.CellsT['cTotalPrice', row] := FloatToStr(prec);
    ptotal := prec * (1 + ben / 100) * (1 - des / 100);
    NiceGrid1.CellsT['cTotalPVP', row] := FloatToStr(ptotal);
    pTotalUO := pTotalUo + ptotal;
  end;
  NiceGrid1.CellsT['cUnitPrice', aRow] := FloatToStr(pUO);
end;

procedure TBudgets.CalPrecioElemento(const aRow: integer);
var
  cantotal, pretotal, pre, ben, des: double;
  tmp: integer;
begin
  if NiceGrid1.RowCount = 0 then
    Exit;

  pre := 0;
  ben := 0;
  des := 0;
  tmp := aRow;

  if (NiceGrid1.CellsT['cType', aRow] = 'UO') or (NiceGrid1.Rows[aRow].NodeIndex > 0) then
  begin
    while (NiceGrid1.Rows[tmp].NodeIndex > 0) do
      Dec(tmp);
    NiceGrid1.CellsT['cTotalAmount', tmp] := NiceGrid1.CellsT['cUnitAmount', tmp];
    CalPrecioUO(tmp);
  end
  else
    NiceGrid1.CellsT['cTotalAmount', aRow] := NiceGrid1.CellsT['cUnitAmount', aRow];

  cantotal := StrToFloatDef(NiceGrid1.CellsT['cTotalAmount', tmp], 0);
  pre := StrToFloatDef(NiceGrid1.CellsT['cUnitPrice', tmp], 0);
  pre := pre * cantotal;
  NiceGrid1.CellsT['cTotalPrice', tmp] := FloatToStr(pre);
  ben := StrToFloatDef(NiceGrid1.CellsT['cBenefit', tmp], 0);
  des := StrToFloatDef(NiceGrid1.CellsT['cDiscount', tmp],0 );
  pretotal := pre * (1 + ben / 100) * (1 - des / 100);
  NiceGrid1.CellsT['cTotalPVP', tmp] := FloatToStr(pretotal);
end;

procedure TBudgets.CalPrecioTotal;
var
  pcomtotal, pvptotal: double;
  i: integer;
begin
  pcomtotal := 0;
  pvptotal := 0;


  for i := 0 to NiceGrid1.RowCount - 1 do
  begin
    if (NiceGrid1.Rows[i].NodeIndex = 0) and (NiceGrid1.CellsT['cTotalPVP', i] <> '') and
      (NiceGrid1.CellsT['cType', i] <> 'ST') then
    begin
      pcomtotal := pcomtotal + StrToFloatDef(NiceGrid1.CellsT['cTotalPrice', i], 0);
      pvptotal := pvptotal + StrToFloatDef(NiceGrid1.CellsT['cTotalPVP', i], 0);
    end;
    if (NiceGrid1.CellsT['cType', i] = 'ST') then
      CalSubTotal(i);
  end;
  if not (zqDocVenta.State = dsEdit) or not (zqDocVenta.State = dsInsert) then
    zqDocVenta.Edit;

  zqDocVenta.FieldByName('COST').AsFloat := pcomtotal;
  zqDocVenta.FieldByName('PRICE').AsFloat := pvptotal;
  eGanancia.Text := FormatFloat('#,##0.00', pvptotal - pcomtotal);
end;

procedure TBudgets.CalSubTotal(const ARow: integer);
var
  tmp: integer;
  SB: double;
begin
  if ARow < 0 then
    Exit;

  tmp := ARow;
  SB := 0;

  while (tmp > 0) do
  begin
    Dec(tmp);
    if NiceGrid1.CellsT['cType', tmp] = 'ST' then
      break;
    if NiceGrid1.Rows[tmp].NodeIndex > 0 then
      continue;
    if NiceGrid1.CellsT['cType', tmp] = '' then
      continue;

    SB := SB + StrToFloatDef(NiceGrid1.CellsT['cTotalPVP', tmp], 0);
  end;

  NiceGrid1.CellsT['cTotalPVP', ARow] := FloatToStr(SB);
end;

function TBudgets.InsertarItem(Dato: ansistring; idx, ARow: integer; AParent: TObject): integer;
var
  zqElem, zqElemCom: TZQuery;
  AItem: TItem;
begin

  zqElem := TZQuery.Create(self);
  zqElem.Connection := MainWindow.zcMainConnection;
  sqlEXEC(zqElem, 'SELECT * FROM ELEMENT WHERE CODE = ' + QuotedStr(dato));

  // Si no encuentra el Record devuelve -1
  if zqElem.RecordCount = 0 then
  begin
    Result := -1;
    Exit;
  end;

  AItem := TItem.Create(AParent);
  if AParent = FItemsList then FItemsList.Add(AItem)
  else TItem(AParent).AddItem(AItem);

  AItem.Row := NiceGrid1.Rows[ARow];

  AItem.Code := zqElem.FieldByName('CODE').Text;
  AItem.Title := zqElem.FieldByName('TITLE').Text;
  AItem.Description := zqElem.FieldByName('DESCRIPTION').AsString;
  AItem.UnitOfElement := zqElem.FieldByName('UNIT_ID').Text;
  AItem.Price := zqElem.FieldByName('PURCHASE_PRICE').AsFloat;
  AItem.TypeOfElement := zqElem.FieldByName('TYPE').Text;

  NiceGrid1.Rows[ARow].NodeIndex := idx;
  NiceGrid1.CellsT['cCode', ARow] := zqElem.FieldByName('CODE').Text;
  NiceGrid1.CellsT['cTitle', ARow] := zqElem.FieldByName('TITLE').Text;
  NiceGrid1.CellsT['cDescription', ARow] := zqElem.FieldByName('DESCRIPTION').AsString;
  NiceGrid1.CellsT['cUnit', ARow] := zqElem.FieldByName('UNIT_ID').Text;
  NiceGrid1.CellsT['cUnitPrice', ARow] := zqElem.FieldByName('PURCHASE_PRICE').Text;
  NiceGrid1.CellsT['cType', ARow] := zqElem.FieldByName('TYPE').Text;

  case NiceGrid1.CellsT['cType', ARow] of
    'UO': NiceGrid1.Rows[ARow].ImageIndex := 0;
    'MA': NiceGrid1.Rows[ARow].ImageIndex := 1;
    'MO': NiceGrid1.Rows[ARow].ImageIndex := 2;
    'HE': NiceGrid1.Rows[ARow].ImageIndex := 3;
    'DI': NiceGrid1.Rows[ARow].ImageIndex := 4;
  end;

  if AItem.TypeOfElement = 'UO' then
  begin
    zqElemCom := TZQuery.Create(self);
    try
      zqElemCom.Connection := MainWindow.zcMainConnection;

      sqlEXEC(zqElemCom, 'SELECT * FROM ELEMENTCOMPOSITION WHERE CODE = ' +
        QuotedStr(zqElem.FieldByName('CODE').Text));
      while not zqElemCom.EOF do
      begin
        Application.ProcessMessages;
        inc(ARow);
        InsertarItem(zqElemCom.FieldByName('ELEMENT_CODE').Text, idx + 1, ARow, AItem);
        TItem(AItem.Items[AItem.Items.Count-1]).UnitAmount := zqElemCom.FieldByName('ELEMENT_AMOUNT').AsFloat;
        NiceGrid1.CellsT['cUnitAmount', ARow] := zqElemCom.FieldByName('ELEMENT_AMOUNT').Text;
        zqElemCom.Next;
      end;
    finally
      zqElemCom.Free;
    end;
  end;

  zqElem.Free;
end;

procedure TBudgets.BorrarItem(ARow: integer);
var
  row, Ind: integer;
begin

  row := ARow + 1;
  Ind := NiceGrid1.Rows[ARow].NodeIndex;

  if NiceGrid1.CellsT['cType', ARow] = 'UO' then
  begin
    while True do
    begin
      if row >= NiceGrid1.RowCount then  break;
      if Ind >= NiceGrid1.Rows[row].NodeIndex then break;

      if Assigned (NiceGrid1.Rows[row].ExternalObject) then
        FGantt.RemoveInterval(TInterval(NiceGrid1.Rows[row].ExternalObject));
      NiceGrid1.DeleteRow(row);
    end;
  end;
  if Assigned (NiceGrid1.Rows[ARow].ExternalObject) then
     FGantt.RemoveInterval(TInterval(NiceGrid1.Rows[aRow].ExternalObject));
  NiceGrid1.DeleteRow(ARow);

  // Recalcular precio total
  if (Ind > 0) then
    CalPrecioElemento(ARow - 1);
  CalPrecioTotal();
end;

procedure TBudgets.addTasks(aRow, aPos: integer);
  procedure CreateHito(aRow: Integer);
  var
    Task : TInterval;
    Res: TResource;
    idx: integer;
    atime, tmp: double;
  begin
    Task := TInterval.Create(FGantt);
    Task.StartDate := date;
    Task.FinishDate := date;
    Task.Visible := True;
    Task.Task := NiceGrid1.CellsT['cTitle', aRow];

    if Nicegrid1.CellsT['cType', aRow] = 'UO' then
    begin
      Res := TResource.Create(Task);
      idx := NiceGrid1.Rows[aRow].NodeIndex;
      inc(aRow);

      while NiceGrid1.Rows[aRow].NodeIndex > idx do
      begin
        Res.ResourceName := NiceGrid1.CellsT['cTitle', aRow];
        Res.ResourceCost := StrToFloatDef(NiceGrid1.CellsT['cUnitPrice', aRow], 0);
        Res.ResourceQuantity := StrToFloatDef(NiceGrid1.CellsT['cUnitAmount', aRow], 0);
        case NiceGrid1.CellsT['cTitle', aRow] of
          'MO': Res.ResourceType := rtLabor;
          'MA', 'DI': Res.ResourceType := rtMaterial;
          'HE': Res.ResourceType := rtTool;
        end;
        inc(aRow);
        if aRow >= (NiceGrid1.RowCount) then break;
      end;
      Task.AddResource(Res);
    end;
    FGantt.AddInterval(Task);
  end;

  procedure CreateTask(aRow: Integer; ParentTask: TInterval = nil);
  var
    Task : TInterval;
    Res: TResource;
    idx: integer;
  begin
    Task := TInterval.Create(FGantt);
    Task.StartDate := date;
    Task.FinishDate := calFinishDate(date, UOIsTask(aRow, false));
    Task.Visible := True;
    Task.Task := NiceGrid1.CellsT['cTitle', aRow];
    Task.Project := DocCode;
    Task.Amount := StrToFloatDef(NiceGrid1.CellsT['cTotalAmount', aRow], 0);

    if Nicegrid1.CellsT['cType', aRow] = 'UO' then
    begin
      Res := TResource.Create(Task);
      idx := NiceGrid1.Rows[aRow].NodeIndex;
      inc(aRow);

      while NiceGrid1.Rows[aRow].NodeIndex > idx do
      begin
        if NiceGrid1.Rows[aRow].NodeIndex = (idx + 1) then
        begin
          Res.ResourceName := NiceGrid1.CellsT['cTitle', aRow];
          Res.ResourceCost := StrToFloatDef(NiceGrid1.CellsT['cUnitPrice', aRow], 0);
          Res.ResourceQuantity := StrToFloatDef(NiceGrid1.CellsT['cUnitAmount', aRow], 0);
          case NiceGrid1.CellsT['cType', aRow] of
            'MO': Res.ResourceType := rtLabor;
            'MA', 'DI': Res.ResourceType := rtMaterial;
            'HE': Res.ResourceType := rtTool;
            'UO': CreateTask(aRow, Task);
          end;
        end;
        inc(aRow);
        if aRow >= (NiceGrid1.RowCount) then break;
      end;
      Task.AddResource(Res);
    end;
    if ParentTask <> nil then ParentTask.AddInterval(Task)
    else FGantt.AddInterval(Task);
  end;

var
  i: integer;

begin

  case Nicegrid1.CellsT['cType', aRow] of
    'MO',
    'HE':
      CreateHito(aRow);
    'UO':
    begin
      {if UOIsTask(aRow) = 0 then // Es hito
      begin
        CreateHito(aRow);
      end
      else  }                     // Es Task;
      begin
        if NiceGrid1.Rows[aRow].NodeIndex > 0 then
        begin
          i := aRow;
          while (NiceGrid1.Rows[i].NodeIndex = NiceGrid1.Rows[aRow].NodeIndex) do
          begin
            if i = 0 then break;
            Dec(i);
          end;
          CreateTask(aRow, TInterval(NiceGrid1.Rows[i].ExternalObject));
        end
        else CreateTask(aRow);
      end;
    end;
  end;
end;

procedure TBudgets.bClientEditClick(Sender: TObject);
begin
  // Abrir el cliente
  TClient.Create(Application, edCID.Text);
end;

procedure TBudgets.bCloseClick(Sender: TObject);
begin
  inherited;
end;

// Crear un documento de compra (Petición de oferta o pedido(por defecto))
procedure TBudgets.bMakeBuyDocButtonClick(Sender: TObject);
var
  form: TBuyDocuments;
  i, BuyType: integer;
begin
  if Sender = bMakeBuyDoc then
    BuyType := 1
  else
    BuyType := TMenuItem(Sender).MenuIndex;

  form := TBuyDocuments.Create(Application, '', BuyType);
  form.NiceGrid1.RowCount := 0;

  for i := 0 to NiceGrid2.RowCount - 1 do
  begin
    if NiceGrid2.CellsT['cCheck', i] <> '1' then  continue;

    form.NiceGrid1.RowCount := form.NiceGrid1.RowCount + 1;
    form.InsertarItem(NiceGrid2.CellsT['cCode', i], form.NiceGrid1.RowCount - 1);
    form.NiceGrid1.CellsT['cAmount', form.NiceGrid1.RowCount - 1] := NiceGrid2.CellsT['cBuy', i];
    form.CalcPrecioElemento(form.NiceGrid1.RowCount - 1);
  end;
  form.Show;
end;

procedure TBudgets.bSaveClick(Sender: TObject);
var
  ZQ: TZQuery;
  num, NumRow, i: integer;
begin
  if edTitle.Text = '' then
  begin
    edTitle.SetFocus;
    Exit;
  end
  else if (edCID.Text = '') then
  begin
    pcAll.TabIndex := 0;
    edCID.SetFocus();
    Exit;
  end
  else if (edCName.Text = '') then
  begin
    pcAll.TabIndex := 0;
    edCName.SetFocus;
    Exit;
  end;

  Screen.Cursor:=crHourGlass;
  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;

  if (edDocCode.Text = '') then
  begin
    sqlEXEC(ZQ, 'SELECT ID FROM SALEDOCUMENT WHERE TYPE = ' +
      QuotedStr(TP) + ' ORDER BY ID DESC LIMIT 1');
    num := ZQ.FieldByName('ID').AsInteger;
    DocCode := FormatFloat(TP + '00000000', num + 1);
    zqDocVenta.FieldByName('CODE').Text := DocCode;
    Caption := Caption + DocCode;
  end;

  if FNeedSave then    // Salvar la lista del presupuesto
  begin
    sqlEXEC(zqDocVentaData, 'SELECT * FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE = '
      + QuotedStr(DocCode));
    NumRow := zqDocVentaData.RecordCount;
    zqDocVentaData.First;

    for i := 0 to Max(NiceGrid1.RowCount, NumRow)-1 do
    begin
      if (i >= NiceGrid1.RowCount) then   // Borrar registros
      begin
        sqlEXEC(zqDocVentaData, 'DELETE FROM SALEDOCUMENTDATA WHERE ID >= ' +
          IntToStr(i + 1) + ' AND SALEDOCUMENT_CODE = ' + QuotedStr(DocCode));
        Break;
      end
      else if (i < NumRow) then           // Actualizar registro
      begin
        zqDocVentaData.Edit;
      end
      else                                //  Añadir registro
      begin
        zqDocVentaData.Append;
        zqDocVentaData.FieldByName('ID').AsInteger := i + 1;
        zqDocVentaData.FieldByName('SALEDOCUMENT_CODE').Text := DocCode;
      end;

      NiceGrid1.CellsT['cIndex', i] := NiceGrid1.CellsT['cIndex', i];
      zqDocVentaData.FieldByName('NODEINDEX').Text := NiceGrid1.CellsT['cIndex', i];
      zqDocVentaData.FieldByName('ELEMENT_CODE').Text := NiceGrid1.CellsT['cCode', i];
      zqDocVentaData.FieldByName('ELEMENT_TITLE').Text := NiceGrid1.CellsT['cTitle', i];
      zqDocVentaData.FieldByName('ELEMENT_DESCRIPTION').AsString := NiceGrid1.CellsT['cDescription', i];
      zqDocVentaData.FieldByName('ELEMENT_UNIT_AMOUNT').Text := NiceGrid1.CellsT['cUnitAmount', i];
      zqDocVentaData.FieldByName('ELEMENT_TOTAL_AMOUNT').Text := NiceGrid1.CellsT['cTotalAmount', i];
      zqDocVentaData.FieldByName('ELEMENT_UNIT').Text := NiceGrid1.CellsT['cUnit', i];
      zqDocVentaData.FieldByName('ELEMENT_PRICE').Text := NiceGrid1.CellsT['cUnitPrice', i];
      zqDocVentaData.FieldByName('BENEFIT').Text := NiceGrid1.CellsT['cBenefit', i];
      zqDocVentaData.FieldByName('DISCOUNT').Text := NiceGrid1.CellsT['cDiscount', i];
      zqDocVentaData.FieldByName('ELEMENT_TYPE').Text := NiceGrid1.CellsT['cType', i];
      zqDocVentaData.FieldByName('ELEMENT_INDEX').AsInteger := NiceGrid1.Rows[i].NodeIndex;
      zqDocVentaData.Post;
      zqDocVentaData.Next;
    end;
  end;

  // Salvar gantt:
  //if FGanttNeedSave then
    SaveGantt(FGantt, DocCode, edTitle.Text, true);

  case (zqDocVenta.State) of
    dsEdit,
    dsInsert: zqDocVenta.Post;
  end;

  ButtonSaveEnabled := False;
  Screen.Cursor:=crDefault;
end;

procedure TBudgets.bShowCriticalPathClick(Sender: TObject);
  procedure UnCheckCliticalPath(aTask: TInterval);
  var
    i: integer;
  begin
    if aTask.HasChilds then
      for i := 0 to aTask.IntervalCount - 1 do
        UnCheckCliticalPath(aTask.Interval[i]);
    aTask.InCriticalPath := false;
  end;

var
  i: integer;
begin
  bShowCriticalPath.Down := not bShowCriticalPath.Down;

  if bShowCriticalPath.Down then FGantt.FindCriticalPath
  else
    for i := 0 to FGantt.IntervalCount - 1 do
      UnCheckCliticalPath(FGantt.Interval[i]);
  FGantt.Invalidate;
end;

procedure TBudgets.bZoomMinusClick(Sender: TObject);
begin
  //(tsMinute, tsHour, tsDay, tsWeek, tsWeekNum, tsWeekNumPlain,tsMonth, tsQuarter, tsHalfYear, tsYear)
  FGantt.PixelsPerMinorScale := FGantt.PixelsPerMinorScale - 20;
  if FGantt.PixelsPerMinorScale < 20 then
  begin
    case FGantt.MajorScale of
      tsDay:
        begin
          FGantt.MajorScale := tsWeekNumPlain;
          FGantt.MinorScale := tsDay;
        end;
      tsWeek,
      tsWeekNum,
      tsWeekNumPlain:
        begin
          FGantt.MajorScale := tsMonth;
          FGantt.MinorScale := tsWeek;
        end;
      tsMonth:
        begin
          FGantt.MajorScale := tsQuarter;
          FGantt.MinorScale := tsMonth;
        end;
      tsQuarter:
        begin
          FGantt.MajorScale := tsHalfYear;
          FGantt.MinorScale := tsQuarter;
        end;
      tsHalfYear:
        begin
          FGantt.MajorScale := tsYear;
          FGantt.MinorScale := tsHalfYear;
        end;
    end;
    if FGantt.MajorScale < tsYear then
      FGantt.PixelsPerMinorScale := 250;
  end;
end;

procedure TBudgets.bZoomPlusClick(Sender: TObject);
begin
  //(tsMinute, tsHour, tsDay, tsWeek, tsWeekNum, tsWeekNumPlain, tsMonth, tsQuarter, tsHalfYear, tsYear)
  FGantt.PixelsPerMinorScale := FGantt.PixelsPerMinorScale + 20;
  if FGantt.PixelsPerMinorScale < 250 then
  begin
    case FGantt.MajorScale of
      tsWeek,
      tsWeekNum,
      tsWeekNumPlain:
        begin
          //FGantt.MinorScale := tsHour;
          //FGantt.MajorScale := tsDay;
        end;
      tsMonth:
        begin
          FGantt.MinorScale := tsDay;
          FGantt.MajorScale := tsWeek;
        end;
      tsQuarter:
        begin
          FGantt.MinorScale := tsWeekNumPlain;
          FGantt.MajorScale := tsMonth;
        end;
      tsHalfYear:
        begin
          FGantt.MinorScale := tsMonth;
          FGantt.MajorScale := tsQuarter;
        end;
      tsYear:
        begin
          FGantt.MinorScale := tsQuarter;
          FGantt.MajorScale := tsHalfYear;
        end;
    end;
    if FGantt.MajorScale > tsHour then
      FGantt.PixelsPerMinorScale := 20;
  end;
end;

procedure TBudgets.dsDocVentaDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TBudgets.dsDocVentaStateChange(Sender: TObject);
begin
  case zqDocVenta.State of
    dsEdit, dsInsert: ButtonSaveEnabled := True;
    else
      ButtonSaveEnabled := False;
  end;
end;

procedure TBudgets.edCIDAfterDropDown(Sender: TObject);
begin
  edCID.ListSource.DataSet.Refresh;
end;

procedure TBudgets.edPCodeAfterDropDown(Sender: TObject);
begin
  zqProjects.SQL.Text := 'SELECT CODE, TITLE, CUSTOMER_ID, CUSTOMER_NAME FROM PROJECT';
  if edCID.Text <> '' then
    zqProjects.SQL.Text := zqProjects.SQL.Text + ' WHERE CUSTOMER_ID = ' + QuotedStr(edCID.Text);
end;

procedure TBudgets.edPCodeLookupClose(Sender: TObject;
  LookupResult: TStringList);
begin
  zqDocVenta.FieldByName('PROJECT_TITLE').Text := zqProjects.FieldByName('TITLE').Text;

  if zqDocVenta.FieldByName('CUSTOMER_CODE').Text = '' then
  begin
    zqDocVenta.FieldByName('CUSTOMER_CODE').Text := zqProjects.FieldByName('CUSTOMER_CODE').Text;
    zqDocVenta.FieldByName('CUSTOMER_NAME').Text := zqProjects.FieldByName('CUSTOMER_NAME').Text;
  end;
end;

procedure TBudgets.edCIDChange(Sender: TObject);
begin
  if edCID.Text = '' then
    bClientEdit.Enabled := False
  else
    bClientEdit.Enabled := True;
end;

procedure TBudgets.edCIDCloseUp(Sender: TObject);
begin

end;

procedure TBudgets.edCIDDragDrop(Sender, Source: TObject; X, Y: integer);
var
  From: TDBGrid;
begin

  if Source.ClassNameIs('TControlDragObject') then
    From := TDBGrid(TControlDragObject(Source).Control)
  else
    From := TDBGrid(Source);

  edCID.Text := From.DataSource.DataSet.FieldByName('PROJECT_TITLE').Text;
  edCIDCloseUp(Sender);
end;

procedure TBudgets.edCIDDragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
begin
  Accept := (Source = ClientList.Grid) or Source.ClassNameIs('TControlDragObject');
end;

procedure TBudgets.edCIDLookupClose(Sender: TObject;
  LookupResult: TStringList);
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
    zqDocVenta.FieldByName('CUSTOMER_NAME').Text := zqClient.FieldByName('NAME').Text;
	end;
end;

procedure TBudgets.edStateSelect(Sender: TObject);
  procedure AddToProject(aNew: boolean);
  var
    aForm : TProjects;
  begin
    if aNew then
    begin
      aForm := TProjects.Create(Application, '', 0, doNew);
      aForm.zqProject.FieldByName('CUSTOMER_CODE').Text := zqDocVenta.FieldByName('CUSTOMER_CODE').Text;
      aForm.zqProject.FieldByName('CUSTOMER_NAME').Text := zqDocVenta.FieldByName('CUSTOMER_NAME').Text;
    end
    else
      aForm := TProjects.Create(Application, zqDocVenta.FieldByName('PROJECT_CODE').Text , 0, doNew);

    aForm.ImportBudget(DocCode);
    aForm.Show;
  end;

begin

  if (edState.ItemIndex = 4) then
  begin
    if zqDocVenta.FieldByName('PROJECT_CODE').Text = '' then
    begin
      case MessageDlg('Se ha ACEPTADO el presupuesto:' + #13 + #10 +
                      '¿Quiere crear un Proyecto y abregar el documento?',
          mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
        mrCancel: Exit;
        mrYes: AddToProject(true);
      end;
    end
    else
    case MessageDlg('Se ha ACEPTADO el presupuesto:' + #13 + #10 +
                    '¿Quiere abregar el documento al Proyecto?',
        mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrCancel: Exit;
      mrYes: AddToProject(false);
    end;
    SetReadOnly;
  end
  else if (edState.ItemIndex = 5) then SetReadOnly;
end;

procedure TBudgets.edTitleKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin

  if Key = VK_RETURN then
	begin
		SelectNext(TWinControl(Sender), True, True);
    Key := 0;
		Exit;
	end;
end;

procedure TBudgets.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  inherited FormClose(Sender, CloseAction);

  zqDocVenta.Cancel;
  zqDocVentaData.Cancel;

end;

procedure TBudgets.FormCreate(Sender: TObject);
var
  ARow: integer;
  i: integer;
  pvptotal: double;
  pcomtotal: double;
  ZQ: TZQuery;
  AItem: TItem;
begin
  FItemsList := TList.Create;

  ManualDock(MainWindow.TabDockCenter);
  zqClient.Open;
  zqProjects.Open;

  if (DocOperation = doEdit) then // Abrir presupuesto existente
  begin
    sqlEXEC(zqDocVenta, 'SELECT * FROM SALEDOCUMENT WHERE CODE = ' + QuotedStr(DocCode));
    sqlEXEC(zqDocVentaData, 'SELECT * FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE = ' +
      QuotedStr(DocCode));

    NiceGrid1.RowCount := 0;
    while not zqDocVentaData.EOF do
    begin
      ARow := zqDocVentaData.FieldByName('ID').AsInteger - 1;
      NiceGrid1.RowCount := NiceGrid1.RowCount + 1;

      NiceGrid1.CellsT['cIndex', ARow] := zqDocVentaData.FieldByName('NODEINDEX').Text;
      NiceGrid1.CellsT['cCode', ARow] := zqDocVentaData.FieldByName('ELEMENT_CODE').Text;
      NiceGrid1.CellsT['cTitle', ARow] := zqDocVentaData.FieldByName('ELEMENT_TITLE').Text;
      NiceGrid1.CellsT['cDescription', ARow] := zqDocVentaData.FieldByName('ELEMENT_DESCRIPTION').AsString;
      NiceGrid1.CellsT['cUnitAmount', ARow] := zqDocVentaData.FieldByName('ELEMENT_UNIT_AMOUNT').Text;
      NiceGrid1.CellsT['cTotalAmount', ARow] := zqDocVentaData.FieldByName('ELEMENT_TOTAL_AMOUNT').Text;
      NiceGrid1.CellsT['cUnit', ARow] := zqDocVentaData.FieldByName('ELEMENT_UNIT').Text;
      NiceGrid1.CellsT['cUnitPrice', ARow] := zqDocVentaData.FieldByName('ELEMENT_PRICE').Text;
      NiceGrid1.CellsT['cBenefit', ARow] := zqDocVentaData.FieldByName('BENEFIT').Text;
      NiceGrid1.CellsT['cDiscount', ARow] := zqDocVentaData.FieldByName('DISCOUNT').Text;
      NiceGrid1.CellsT['cType', ARow] := zqDocVentaData.FieldByName('ELEMENT_TYPE').Text;
      NiceGrid1.Rows[ARow].NodeIndex := zqDocVentaData.FieldByName('ELEMENT_INDEX').AsInteger;

      case NiceGrid1.CellsT['cType', ARow] of
        'UO': NiceGrid1.Rows[ARow].ImageIndex := 0;
        'MA': NiceGrid1.Rows[ARow].ImageIndex := 1;
        'MO': NiceGrid1.Rows[ARow].ImageIndex := 2;
        'HE': NiceGrid1.Rows[ARow].ImageIndex := 3;
        'DI': NiceGrid1.Rows[ARow].ImageIndex := 4;
      end;

      zqDocVentaData.Next;

      if NiceGrid1.CellsT['cType', ARow] = 'ST' then
        CalSubTotal(ARow);
    end;
    //***********************************************************************

    if NiceGrid1.RowCount = 0 then
      NiceGrid1.RowCount := 10
    else
    begin
      pcomtotal := 0;
      pvptotal := 0;

      for i := 0 to NiceGrid1.RowCount - 1 do
      begin
        if NiceGrid1.Rows[i].NodeIndex = 0 then
        begin
          CalPrecioElemento(i);
          if NiceGrid1.CellsT['cTotalPVP', i] <> '' then
          begin
            pcomtotal := StrToFloatDef(NiceGrid1.CellsT['cTotalPrice', i], 0);
            pvptotal := StrToFloatDef(NiceGrid1.CellsT['cTotalPVP', i], 0);
          end;
        end;
      end;
      eGanancia.Text := FormatFloat('0.00', pvptotal - pcomtotal);
    end;
    //***********************************************************************
    if LoadGantt(FGantt, DocCode) = 0 then
    begin
      for i:=0  to NiceGrid1.RowCount - 1 do
        if NiceGrid1.Rows[i].NodeIndex = 0 then addTasks(i, FGantt.IntervalCount);
    end;
    ButtonSaveEnabled := False;
    bClientEdit.Enabled := True;
  end
  else    // Presupuesto nuevo
  begin

    sqlEXEC(zqDocVenta, 'SELECT * FROM SALEDOCUMENT WHERE ID = -1');
    zqDocVenta.Append;

    if DocOperation = doCopy then  // Duplicar
    begin
      ZQ := TZQuery.Create(self);
      ZQ.Connection := MainWindow.zcMainConnection;

      sqlEXEC(ZQ, 'SELECT * FROM SALEDOCUMENT WHERE CODE = ' + QuotedStr(DocCode));
      for i := 4 to ZQ.FieldCount - 1 do
        zqDocVenta.Fields.FieldByNumber(i).AsVariant :=
          ZQ.Fields.FieldByNumber(i).AsVariant;

      sqlEXEC(ZQ, 'SELECT * FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE = ' + QuotedStr(DocCode));
      while not ZQ.EOF do
      begin
        ARow := ZQ.FieldByName('vdID').AsInteger - 1;
        NiceGrid1.RowCount := NiceGrid1.RowCount + 1;
        NiceGrid1.Rows[ARow].NodeIndex := ZQ.FieldByName('ELEMENT_INDEX').AsInteger;
        NiceGrid1.CellsT['cIndex', ARow] := ZQ.FieldByName('NODEINDEX').Text;
        NiceGrid1.CellsT['cCode', ARow] := ZQ.FieldByName('ELEMENT_CODE').Text;
        NiceGrid1.CellsT['cTitle', ARow] := ZQ.FieldByName('ELEMENT_TITLE').Text;
        NiceGrid1.CellsT['cDescription', ARow] := zqDocVentaData.FieldByName('ELEMENT_DESCRIPTION').AsString;
        NiceGrid1.CellsT['cUnitAmount', ARow] := ZQ.FieldByName('ELEMENT_UNIT_AMOUNT').Text;
        NiceGrid1.CellsT['cTotalAmount', ARow] := ZQ.FieldByName('ELEMENT_TOTAL_AMOUNT').Text;
        NiceGrid1.CellsT['cUnit', ARow] := ZQ.FieldByName('ELEMENT_UNIT').Text;
        NiceGrid1.CellsT['cUnitPrice', ARow] := ZQ.FieldByName('ELEMENT_PRICE').Text;
        NiceGrid1.CellsT['cBenefit', ARow] := ZQ.FieldByName('BENEFIT').Text;
        NiceGrid1.CellsT['cDiscount', ARow] := ZQ.FieldByName('DISCOUNT').Text;
        NiceGrid1.CellsT['cType', ARow] := ZQ.FieldByName('ELEMENT_TYPE').Text;


        case NiceGrid1.CellsT['cType', ARow] of
          'UO': NiceGrid1.Rows[ARow].ImageIndex := 0;
          'MA': NiceGrid1.Rows[ARow].ImageIndex := 1;
          'MO': NiceGrid1.Rows[ARow].ImageIndex := 2;
          'HE': NiceGrid1.Rows[ARow].ImageIndex := 3;
          'DI': NiceGrid1.Rows[ARow].ImageIndex := 4;
        end;

        ZQ.Next;

        if NiceGrid1.CellsT['cType', ARow] = 'ST' then
          CalSubTotal(ARow);
      end;
      //***********************************************************************

      for i := 0 to NiceGrid1.RowCount - 1 do
      begin
        if NiceGrid1.Rows[i].NodeIndex = 0 then
        begin
          CalPrecioElemento(i);
          if NiceGrid1.CellsT['cTotalPVP', i] <> '' then
          begin
            pcomtotal := StrToFloatDef(NiceGrid1.CellsT['cTotalPrice', i], 0);
            pvptotal := StrToFloatDef(NiceGrid1.CellsT['cTotalPVP', i], 0);
          end;
        end;
      end;
      eTCompra.Text := FloatToStr(pcomtotal);
      eTVenta.Text := FloatToStr(pvptotal);
      eGanancia.Text := FormatFloat('0.00', pvptotal - pcomtotal);
      //***********************************************************************
    end
    else
    begin
      NiceGrid1.RowCount := 40;

      for i:=0 to 39 do
      begin
        AItem := TItem.Create(FItemsList);
        FItemsList.Add(AItem);
        AItem.Row := NiceGrid1.Rows[i];
      end;
    end;

    zqDocVenta.FieldByName('TYPE').Text := TP;
    zqDocVenta.FieldByName('CREATEDAT').AsDateTime := Date();
    zqDocVenta.FieldByName('DELIVERY_DATE').AsDateTime := Date();
    zqDocVenta.FieldByName('VALIDTO').AsDateTime := Date();


    edState.ItemIndex := 0;

    DocCode := 'Nuevo';
  end;

  Caption := Caption + DocCode;
  pcAll.PageIndex := 1;

  FGantt.MajorScale:=tsWeekNumPlain;
  FGantt.MinorScale:=tsDay;
  FGantt.Tree.Columns.Items[0].Visible := false;
  FGantt.Tree.Columns.Items[3].Visible := false;
  FGantt.Tree.Columns.Items[4].Visible := false;
  FGantt.Tree.Columns.Items[5].Visible := false;
  FGantt.Tree.Columns.Items[6].Visible := false;
  FGantt.Tree.Width := 400;
  FGantt.Calendar.StartDate := Date - 1;
  FGantt.Calendar.OnMoveOverInterval := @gsGanttMouseOverInterval;

  if not FUser.Permits.GetDocPermit(TP).Write then
  begin
    if FUser.Permits.GetDocPermit(TP).Print then
    begin
      bPrint.Enabled := false;
      bPrint.Visible := false;
    end;
  end;
end;

procedure TBudgets.FormShow(Sender: TObject);
begin
  inherited;
  pcAllChange(Sender);
end;

procedure TBudgets.frDBDataSet1Next(Sender: TObject);
begin
  {if (frDBDataSet1.DataSet.FieldByName('ELEMENT_INDEX').AsInteger > 0) or
     (frDBDataSet1.DataSet.FieldByName('ELEMENT_TYPE').Text <> 'UO') then
    frDBDataSet1.DataSet.Next;}
end;

procedure TBudgets.InsertarLinea(Sender: TObject);
begin
  NiceGrid1.InsertRow(NiceGrid1.Row);
  NiceGrid1.Rows[NiceGrid1.Row].NodeIndex := NiceGrid1.Rows[NiceGrid1.Row + 1].NodeIndex;

  case TControl(sender).Tag of
    1: NiceGrid1.CellsT['cType',NiceGrid1.Row] := 'MA';
    2: NiceGrid1.CellsT['cType',NiceGrid1.Row] := 'MO';
    3: NiceGrid1.CellsT['cType',NiceGrid1.Row] := 'HE';
    4: NiceGrid1.CellsT['cType',NiceGrid1.Row] := 'DI';
  end;

  if TControl(sender).Tag > 0 then NiceGrid1.Rows[NiceGrid1.Row].ImageIndex := TControl(sender).Tag;

end;

procedure TBudgets.BorrarLinea(Sender: TObject);
begin
  BorrarItem(NiceGrid1.Row);
end;

procedure TBudgets.miConvertTo(Sender: TObject);
var
  form: TSaleDocuments;
begin
  form := TSaleDocuments.Create(Application, DocCode, TMenuItem(Sender).MenuIndex + 1, doCopy);
  form.Show;
  form.SetFocus;
end;

procedure TBudgets.miEditElementClick(Sender: TObject);
var
  form: TElement;
begin

  if StringReplace(NiceGrid1.CellsT['cCode', NiceGrid1.Row], ' ', '', [rfReplaceAll]) = '' then exit;
  form := TElement.Create(Application, NiceGrid1.CellsT['cCode', NiceGrid1.Row],
          0, doEdit);
  form.Show;
end;

procedure TBudgets.miInsertSutTotalClick(Sender: TObject);
begin
  NiceGrid1.CellsT['cType', NiceGrid1.Row] := 'ST';
  NiceGrid1.CellsT['cTitle', NiceGrid1.Row] := 'SubTotal';
  NiceGrid1.Rows[NiceGrid1.Row].NodeIndex := 0;

  CalSubTotal(NiceGrid1.Row);
  NiceGrid1.Invalidate;
end;

procedure TBudgets.miShowAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to NiceGrid1.RowCount - 1 do
  begin
    if NiceGrid1.Rows[i].NodeIndex > 0 then
      NiceGrid1.Rows[i].Visible := True;
  end;
end;

procedure TBudgets.miHideAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to NiceGrid1.RowCount - 1 do
  begin
    if NiceGrid1.Rows[i].NodeIndex > 0 then
      NiceGrid1.Rows[i].Visible := False;
  end;
end;

procedure TBudgets.miShowCompositionClick(Sender: TObject);
var
  ind, row: integer;
begin
  if NiceGrid1.CellsT['cType', NiceGrid1.Row] <> 'UO' then
    Exit;
  row := NiceGrid1.Row;
  ind := NiceGrid1.Rows[row].NodeIndex;
  Inc(row);
  while NiceGrid1.Rows[row].NodeIndex > ind do
  begin
    NiceGrid1.Rows[row].Visible := True;
    Inc(row);
  end;
end;

procedure TBudgets.miInsertPackClick(Sender: TObject);
begin
  //InsertarLinea(Sender);
  InsertarLinea(Sender);
  NiceGrid1.CellsT['cType', NiceGrid1.Row] := 'UO';
  NiceGrid1.Rows[NiceGrid1.Row].ImageIndex := 0;
  NiceGrid1.Row := NiceGrid1.Row + 1;
  InsertarLinea(Sender);
  NiceGrid1.Rows[NiceGrid1.Row].NodeIndex := NiceGrid1.Rows[NiceGrid1.Row - 1].NodeIndex + 1;
  NiceGrid1.Row := NiceGrid1.Row - 1;
end;

procedure TBudgets.miHideCompositionClick(Sender: TObject);
var
  ind, row: integer;
begin
  if NiceGrid1.CellsT['cType', NiceGrid1.Row] <> 'UO' then
    Exit;
  row := NiceGrid1.Row;
  ind := NiceGrid1.Rows[row].NodeIndex;
  Inc(row);
  while NiceGrid1.Rows[row].NodeIndex > ind do
  begin
    NiceGrid1.Rows[row].Visible := False;
    Inc(row);
  end;
end;

procedure TBudgets.miSaveInDBClick(Sender: TObject);
var
  form: TElement;
  ind, Row, YY: integer;
begin

  if NiceGrid1.CellsT['cCode', Row] <> '' then Exit;
  form := TElement.Create(self);
  Row := NiceGrid1.Row;

  form.zqElement.FieldByName('TITLE').AsString := NiceGrid1.CellsT['cTitle', Row];
  form.zqElement.FieldByName('DESCRIPTION').AsString := NiceGrid1.CellsT['cTitle', Row];;
  form.zqElement.FieldByName('UNIT_ID').AsString := NiceGrid1.CellsT['cUnit', Row];;

  case NiceGrid1.CellsT['cType', Row] of
    'UO':
    begin
      ind := NiceGrid1.Rows[Row].NodeIndex;
      inc(Row);
      form.eType.ItemIndex := 0;
      form.gComposition.RowCount := 0;
      while NiceGrid1.Rows[Row].NodeIndex > ind do
      begin
        if Row >= NiceGrid1.RowCount then break;
        YY := form.gComposition.RowCount;
        form.gComposition.RowCount := YY + 1;
        form.gComposition.CellsT['cCode', YY] := NiceGrid1.CellsT['cCode', Row];
        form.gComposition.CellsT['cTitle', YY] := NiceGrid1.CellsT['cTitle', Row];
        form.gComposition.CellsT['cUnitAmount', YY] := NiceGrid1.CellsT['cUnitAmount', Row];
        form.gComposition.CellsT['cUnit', YY] := NiceGrid1.CellsT['cUnit', Row];
        form.gComposition.CellsT['cUnitPrice', YY] := NiceGrid1.CellsT['cUnitPrice', Row];

        form.gComposition.Rows[YY].NodeIndex := NiceGrid1.Rows[Row].NodeIndex - (ind + 1);
        case NiceGrid1.CellsT['cType', Row] of
          'UO': form.gComposition.Rows[YY].ImageIndex := 0;
          'MA': form.gComposition.Rows[YY].ImageIndex := 1;
          'MO': form.gComposition.Rows[YY].ImageIndex := 2;
          'HE': form.gComposition.Rows[YY].ImageIndex := 3;
          'DI': form.gComposition.Rows[YY].ImageIndex := 4;
        end;

        inc(Row);
      end;
    end;
    'MA': form.eType.ItemIndex := 1;
    'MO': form.eType.ItemIndex := 2;
    'HE': form.eType.ItemIndex := 3;
    'DI': form.eType.ItemIndex := 4;
  end;

  form.Show;
end;

procedure TBudgets.NiceGrid1AfterDrawTextCell(Sender: TObject;
  ACanvas: TCanvas; ACol, ARow: integer; Rc: TRect);
begin

  if NiceGrid1.CellsT['cType', ARow] = 'ST' then
  begin
    ACanvas.Pen.Color := clBlue;
    ACanvas.MoveTo(Rc.Left, Rc.Top + 1);
    ACanvas.LineTo(Rc.Right, Rc.Top + 1);
  end;

end;

procedure TBudgets.NiceGrid1CellChange(Sender: TObject; ACol, ARow: integer;
          var Str: string);
begin

end;

procedure TBudgets.NiceGrid1CellChanging(Sender: TObject; ACol, ARow: integer;
  var CanChange: boolean);
begin

end;

procedure TBudgets.NiceGrid1CellExit(Sender: TObject; ACol, ARow: integer);
var
  //X: Integer;
  Y: integer;
begin
  if (ACol = -1) or (ARow = -1) then Exit;
  if ARow >= NiceGrid1.RowCount then Exit;

  if (CellText <> NiceGrid1.Cells[ACol, ARow]) then
  begin
    Y := ARow;
    case NiceGrid1.Columns[ACol].Name of
      'cCode':
        InsertarItem(NiceGrid1.CellsT['cCode', Y], NiceGrid1.Rows[Y].NodeIndex, Y);
      'cTitle'://2:
        TInterval(NiceGrid1.Rows[ARow].ExternalObject).Task := NiceGrid1.Cells[ACol, ARow];
			'cUnitAmount'://3:
        TItem(NiceGrid1.Rows[ARow].ExternalObject).UnitAmount := StrToFloatDef(NiceGrid1.CellsT['cUnitAmount', ARow], 0);

      //8, 9:
      'cBenefit':
        TItem(NiceGrid1.Rows[ARow].ExternalObject).Benefit := StrToFloatDef(NiceGrid1.CellsT['cBenefit', ARow], 0);
      'cDiscount':
      begin
        if (NiceGrid1.Rows[ARow].NodeIndex = 0) and
           (NiceGrid1.CellsT['cType', ARow] = 'UO') then
        begin
          Inc(Y);
          while NiceGrid1.Rows[Y].NodeIndex > 0 do
          begin
            if Y = NiceGrid1.RowCount then
              break;
            NiceGrid1.Cells[ACol, Y] := NiceGrid1.Cells[ACol, ARow];
            Inc(Y);
          end;
        end;
      end;
    end;

    FNeedSave := true;
    bSave.Enabled := true;

  end;
end;

procedure TBudgets.NiceGrid1ColRowChanged(Sender: TObject; ACol, ARow: integer);
begin

  if (ACol = -1) or (ARow = -1) then Exit;
  CellText := NiceGrid1.Cells[ACol, ARow];

  if NiceGrid1.CellsT['cType', ARow] = 'ST' then
  begin
    NiceGrid1.Columns.Items[ACol].ReadOnly := True;
    Exit;
  end;

  NiceGrid1.Columns.Items[ACol].ReadOnly := False;

  case NiceGrid1.Columns[ACol].Name of
    'cIndex', 'cDiscount', 'cBenefit':
      if (NiceGrid1.Rows[ARow].NodeIndex > 0) or (NiceGrid1.CellsT['cType', ARow] = '') then
        NiceGrid1.Columns.Items[ACol].ReadOnly := True;
    'cCode':
    begin
      //zqElemento.Open;
      //NiceGrid1.Edit.DataSource := dsElemento;
      //NiceGrid1.Edit.ShowGridTitleRow := true;
    end;

    'cTotalAmount', 'cTotalPrice': NiceGrid1.Columns.Items[ACol].ReadOnly := true;

    'cUnitAmount':
    begin
      //NiceGrid1.Edit.DataSource := dsUnidad;
      //NiceGrid1.Edit.ShowGridTitleRow := false;
      NiceGrid1.Columns.Items[ACol].ReadOnly := false;
    end;
  end;
end;

procedure TBudgets.NiceGrid1DragDrop(Sender, Source: TObject; X, Y: integer);
var
  offset, CCol, CRow, RIn: integer;
  From: TDBGrid;
  i: integer;
begin
  offset := 0;
  NiceGrid1.MouseToCell(X, Y, CCol, CRow);

  if not NiceGrid1.RowIsEmpty(CRow) then
  begin
    if NiceGrid1.CellsT['cType', CRow] = 'UO' then
    begin
      BorrarItem(CRow);
      NiceGrid1.InsertRow(CRow);
    end;
  end;

  if Source.ClassNameIs('TControlDragObject') then
    From := TDBGrid(TControlDragObject(Source).Control)
  else if Source is TDragControlObject then
    From := TDBGrid((Source as TDragControlObject).Control)
  else
    From := TDBGrid(Source);

  for i := 0 to From.SelectedRows.Count - 1 do
  begin
    From.DataSource.DataSet.GotoBookmark(From.SelectedRows.Items[i]);
    InsertarItem(from.DataSource.DataSet.FieldByName('CODE').Text,
             NiceGrid1.Rows[CRow + offset].NodeIndex, CRow + offset, FItemsList);

    // insertar en gantt también:
    //addTasks(cRow + offset, FGantt.IntervalCount);
    NiceGrid1.Rows[cRow + offset].ExternalObject :=  TObject(FItemsList[FItemsList.Count - 1]);
    offset := offset + 1 + RIn;
  end;

  NiceGrid1.Row := CRow;
  NiceGrid1.Col := 0;
  NiceGrid1.SetFocus;

  if not FNeedSave then
    FNeedSave := True;
end;

procedure TBudgets.NiceGrid1DragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
var
  CCol, CRow: integer;
begin
  NiceGrid1.MouseToCell(X, Y, CCol, CRow);

  Accept := (Sender = Source) or (Source = ElementsList.Grid) or
    Source.ClassNameIs('TControlDragObject');

  Accept := True;

  if Accept then
  begin
    NiceGrid1.Row := CRow;
    NiceGrid1.SelectArea := Rect(0, CRow, NiceGrid1.ColCount - 1, CRow);
  end;
end;

procedure TBudgets.NiceGrid1DrawCell(Sender: TObject; ACanvas: TCanvas;
  ACol, ARow: integer; Rc: TRect; var Handled: boolean);
begin
  if NiceGrid1.Rows[ARow].NodeIndex > 0 then
  begin
    ACanvas.Font.Color := clGray;
  end
  else
  begin
    //NiceGrid1.CellStyle[ACol, ARow].Font.Size = 9; //Style << fsBold << fsUnderline;
    ACanvas.Font.Color := clBlack;
  end;

  //if NiceGrid1.CellsT['cType', ARow] = 'UO' then
  if (NiceGrid1.Rows[ARow].NodeIndex = 0) or (NiceGrid1.CellsT['cType', ARow] = 'UO') then
    ACanvas.Font.Style := [fsBold]
  else
    ACanvas.Font.Style := [];
end;

procedure TBudgets.NiceGrid1InsertRow(Sender: TObject; ARow: integer);
begin

end;

procedure TBudgets.NiceGrid1KeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin

  if ssShift in Shift then
  begin
    case Key of
      VK_DELETE: ;// BorrarLinea(Sender);
      VK_INSERT: ;// InsertarLinea(Sender);
      {begin
            NiceGrid1.InsertRow(NiceGrid1.Row);
            NiceGrid1.Rows[NiceGrid1.Row].NodeIndex := NiceGrid1.Rows[NiceGrid1.Row + 1].NodeIndex ;
         end;}
      else;
    end;
  end;
end;

procedure TBudgets.pcAllChange(Sender: TObject);

  procedure ShowToolBarButtons(aTag: Integer);
  var
    i: integer;
  begin
    for i := 0 to ToolBar.ControlCount - 1 do
    begin
      if ToolBar.Controls[i].Tag = 0 then continue;
      if ToolBar.Controls[i].Tag = aTag then ToolBar.Controls[i].Visible := true
      else ToolBar.Controls[i].Visible := false;
    end;
  end;

var
  tmp: boolean;
  i: integer;
  j: integer;
  tmp1: double;
  tmp2: double;

begin

  ShowToolBarButtons(pcAll.TabIndex);

  case pcAll.TabIndex of
    1:;
    2:
    begin

    end;
    3:
    begin
      tmp := False;
      NiceGrid2.RowCount := 0;
      for i := 0 to NiceGrid1.RowCount - 1 do
      begin
        if NiceGrid1.RowIsEmpty(i) then
          Continue;
        if NiceGrid1.CellsT['cType', i] <> 'MA' then
          Continue;

        for j := 0 to NiceGrid2.RowCount - 1 do
        begin
          if NiceGrid1.CellsT['cCode', i] = NiceGrid2.CellsT['cCode', j] then
          begin
            tmp1 := StrToFloatDef(NiceGrid1.CellsT['cTotalAmount', i], 0);
            tmp2 := StrToFloatDef(NiceGrid2.CellsT['cAmount', j], 0);
            NiceGrid2.CellsT['cTotalAmount', j] := FloatToStr(tmp1 + tmp2);
            tmp := True;
            break;
          end;
        end;

        if tmp then
        begin
          tmp := False;
          Continue;
        end;

        NiceGrid2.RowCount := NiceGrid2.RowCount + 1;
        NiceGrid2.CellsT['cCode', NiceGrid2.RowCount - 1] := NiceGrid1.CellsT['cCode', i];
        NiceGrid2.CellsT['cTitle', NiceGrid2.RowCount - 1] := NiceGrid1.CellsT['cTitle', i];
        NiceGrid2.CellsT['cAmount', NiceGrid2.RowCount - 1] := NiceGrid1.CellsT['cTotalAmount', i];
        NiceGrid2.CellsT['cUnit', NiceGrid2.RowCount - 1] := NiceGrid1.CellsT['cUnit', i];
        NiceGrid2.CellsT['cBuy', NiceGrid2.RowCount - 1] := NiceGrid1.CellsT['cTotalAmount', i];
      end;
    end;
    4:;
  end;
end;

procedure TBudgets.pmGanttPopup(Sender: TObject);
var
  i: integer;
  it: TMenuItem;
begin

  if assigned(FInterval) then
  begin
    {$IFDEF DEBUG}
      dgSetLine('-------------------------------------------------------');
    {$ENDIF}

    pmGantt.Items[0].Clear;

    for i:=0 to FInterval.ConnectionCount - 1 do
    begin
      {$IFDEF DEBUG}
        dgSetLine(FInterval.Task + ' - Con. ' + IntToStr(i) + ': ' + FInterval.Connection[i].Task);
      {$ENDIF}
      it := TMenuItem.Create(pmGantt);
      it.Caption := FInterval.Connection[i].Task + ' (Con.)';
      it.OnClick := @DeleteConnection;
      pmGantt.Items[0].Add(it);
    end;
    for i:=0 to FInterval.DependencyCount - 1 do
    begin
      {$IFDEF DEBUG}
        dgSetLine(FInterval.Task + ' - Dep. ' + IntToStr(i) + ': ' +  FInterval.Dependencies[i].Task);
      {$ENDIF}
      it := TMenuItem.Create(pmGantt);
      it.Caption := FInterval.Dependencies[i].Task + ' (Dep.)';
      it.OnClick := @DeleteConnection;
      pmGantt.Items[0].Add(it);
    end;
  end;

  if pmGantt.Items[0].Count > 0 then pmGantt.Items[0].Visible := true
  else pmGantt.Items[0].Visible := false;

end;

procedure TBudgets.DeleteConnection(Sender: TObject);
begin
  if TMenuItem(Sender).MenuIndex < FInterval.ConnectionCount then
    FInterval.DeleteConnection(TMenuItem(Sender).MenuIndex)
  else
    FInterval.Dependencies[TMenuItem(Sender).MenuIndex - FInterval.ConnectionCount].RemoveConnection(FInterval);
end;

procedure TBudgets.gsGanttMouseOverInterval(Sender: TObject; aInterval: TInterval; X, Y: integer);
var
  i: integer;
begin
  FInterval := aInterval;
end;

end.
