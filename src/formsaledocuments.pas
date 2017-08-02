unit formSaleDocuments;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Controls, Forms, formWorkForm,
  NiceGrid, NiceLookUpComboBox, gsGantt, DBGrids,
  DBZVDateTimePicker, ZDataset,
  BGRABitmapTypes, BCPanel, BCButton,
  Graphics, Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, ComCtrls,
  Menus, Math, Utiles, DB, dbf, u_items_tree;

type

  { TSaleDocuments }

  TSaleDocuments = class(TWorkForm)

    BCButton1: TBCButton;
    bCloseInfoPanel: TBCButton;
    bFontMinus: TBCButton;
    bFontMinus1: TBCButton;
    bInsertTool: TBCButton;
    bInsertLabor: TBCButton;
    bInsertElement: TBCButton;
    bInsertPacket: TBCButton;
    bInsertOthers: TBCButton;
    bInsertLine6: TBCButton;
    bFontPlus: TBCButton;

    bInsertLine: TBCButton;
    bDeleteLine: TBCButton;
    bConverTo: TBCButton;
    bSaveElementinDB: TBCButton;
    edClientRef: TDBEdit;
    eHoursMO: TEdit;
    eHoursHE: TEdit;
    Label13: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    lCreationDate: TDBText;
    dsClient: TDataSource;
    eBenefict_Summary: TEdit;
    eIVA: TDBEdit;
    eIVAMoney: TEdit;

    edPCode: TNiceLookUpComboBox;
    edTitle1: TDBEdit;
    eTCompra_Summary: TDBEdit;
    eTotalMachinery: TEdit;
    eTotalMachineryCost: TEdit;
    eTotalManPower: TEdit;
    eTotalManPowerCost: TEdit;
    eTotalMaterials: TEdit;
    eTotalMaterialsCost: TEdit;
    eTotalOthers: TEdit;
    eTotalHours: TEdit;
    eTotalOthersCost: TEdit;
    eTotalPriceWithTaxes: TEdit;
    eTVenta_Summary: TDBEdit;
    bClientEdit: TBitBtn;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    MenuItem11: TMenuItem;
    MenuItem9: TMenuItem;
    Panel2: TPanel;
    pInfoPanel: TBCPanel;
    DBMemo1: TDBMemo;
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
    lGain: TLabel;
    lSell: TLabel;
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
    GridLines: TNiceGrid;
    edCID: TNiceLookUpComboBox;
    Panel1: TPanel;
    pcAll: TPageControl;
    pmConvertTo: TPopupMenu;
    pmLines: TPopupMenu;
    pmBuyDocuments: TPopupMenu;
    ScrollBox1: TScrollBox;
    SeparatorBevel1: TBevel;
    SeparatorBevel2: TBevel;
    SeparatorBevel3: TBevel;
    SeparatorBevel4: TBevel;
    SeparatorBevel8: TBevel;
    SeparatorBevel9: TBevel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    SpeedButton1: TSpeedButton;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    ToolBarDocument: TBCPanel;
    tsDocument: TTabSheet;
    tsGeneral: TTabSheet;
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
    zqDocVentaDataPARENT: TLongintField;
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
    procedure bCloseInfoPanelClick(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
    procedure bFontMinus1Click(Sender: TObject);
    procedure bFontPlusClick(Sender: TObject);
    procedure bFontMinusClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject); override;
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
    procedure eIVAExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InsertarLinea(Sender: TObject);
    procedure BorrarLinea(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure miConvertTo(Sender: TObject);
    procedure miEditElementClick(Sender: TObject);
    procedure miInsertSutTotalClick(Sender: TObject);
    procedure miShowAllClick(Sender: TObject);
    procedure miHideAllClick(Sender: TObject);
    procedure miShowCompositionClick(Sender: TObject);
    procedure miInsertPackClick(Sender: TObject);
    procedure miHideCompositionClick(Sender: TObject);
    procedure miSaveInDBClick(Sender: TObject);
    procedure GridLinesAfterDrawTextCell(Sender: TObject; ACanvas: TCanvas;
      ACol, ARow: integer; Rc: TRect);
    procedure GridLinesBeforeShowEdit(Sender: TObject; ARec: TRect;
      var aCanShow: boolean);
    procedure GridLinesCellExit(Sender: TObject; ACol, ARow: integer);
    procedure GridLinesClick(Sender: TObject);
    procedure GridLinesColRowChanged(Sender: TObject; ACol, ARow: integer);
    procedure GridLinesDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure GridLinesDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure GridLinesDrawCell(Sender: TObject; ACanvas: TCanvas;
      ACol, ARow: integer; Rc: TRect; var Handled: boolean);
    procedure GridLinesGutterClick(Sender: TObject; ARow: integer;
      Button: TMouseButton; Shift: TShiftState);
    procedure pcAllChange(Sender: TObject);

  private
    { private declarations }
    CellText: string;
    TP: ansistring;
    FNeedSave: boolean;
    FLines: TItems;


    procedure CalPrecioTotal;
    procedure CalSubTotal(const ARow: integer);

    function InsertarItem(Dato: ansistring; ARow: integer; aParent: TObject): integer;
    procedure BorrarItem(ARow: integer);

    procedure SetReadOnly;

    procedure Summary;
    procedure UpdateCodeIndexSince(Idx: integer);

    {$IFNDEF LITTLE_VERSION}
    procedure ConfigPermits;
    {$ENDIF}
  public
    { public declarations }
    constructor Create(TheOwner: TComponent; Code: ansistring = '';
      DocumentType: integer = 0; Operation: TDocumentOperations = doNew);
      reintroduce;
    destructor Destroy; override;
  end;

var
  FSaleDocuments: TSaleDocuments;

implementation

uses
  ControlDragObject, LCLType,
  formMainWindow,
  formConfigWindow,
  formClient,
  formClientList,
  formElement,
  formElementsList,
  formProjects,
  u_units,
  u_variables;

{$R *.lfm}

function calFinishDate(aDate: TDateTime; aTime: double; aUnit: string = 'h'): TDateTime;
var
  tmp: double;
  tmp1: integer;
begin
  tmp := (aTime / FHoursPerDay);
  tmp1 := Trunc(tmp);
  tmp := (tmp - tmp1) * FHoursPerDay / 24;
  Result := aDate + tmp + tmp1;
end;

constructor TSaleDocuments.Create(TheOwner: TComponent; Code: ansistring = '';
  DocumentType: integer = 0; Operation: TDocumentOperations = doNew);
begin
  TP := 'PR';
  FLines := TItems.Create(GridLines);
  {$IFNDEF LITTLE_VERSION}
  if FUser.UserName <> 'ADMIN' then
    if not FUser.Permits.GetDocPermit(TP).Read or not
      FUser.Permits.GetDocPermit(TP).Write then
    begin
      MessageDlg('No tiene PERMISO para LEER este documento.' + #13 +
        #10 + 'El documento no se va a abrir.',
        mtInformation, [mbYes], 0);
      Abort;
    end;
  {$ENDIF}
  inherited Create(TheOwner, Code, DocumentType, Operation);

end;

destructor TSaleDocuments.Destroy;
begin
  FLines.Free;
  inherited Destroy;
end;

{$IFNDEF LITTLE_VERSION}
procedure TSaleDocuments.ConfigPermits;
begin
  if FUser.UserName = 'ADMIN' then
    Exit; // Admin tiene permiso total
  if not FUser.Permits.GetDocPermit(TP).Write and
    FUser.Permits.GetDocPermit(TP).Read then
    SetReadOnly;

  if FUser.Permits.GetDocPermit(TP).Print then
  begin
    bPrint.Enabled := False;
  end;
end;

{$ENDIF}

procedure TSaleDocuments.SetReadOnly;
var
  i: integer;
begin
  Toolbar.Enabled := False;
  for i := 0 to pInfoPanel.ControlCount - 1 do
  begin
    if not (pInfoPanel.Controls[i] is TLabel) then
      pInfoPanel.Controls[i].Enabled := False;
  end;
  GridLines.ReadOnly := True;
  GridLines.PopupMenu := nil;
end;

procedure TSaleDocuments.Summary;
var
  MA, MO, HE, DI: double;
  TMA, TMO, THE, TDI: double;
  TimeMO, TimeHE: double;

  procedure ProcessItem(aItem: TItem);
  var
    i: integer;
  begin
    if aItem.HasChildren then
      for i := 0 to aItem.Items.Count - 1 do
        ProcessItem(TItem(aItem.Items[i]))
    else
      case aItem.TypeOfElement of
        'MA':
        begin
          TMA := TMA + aItem.TotalSalePrice;
          MA := MA + aItem.TotalPrice;
        end;
        'MO':
        begin
          TMO := TMO + aItem.TotalSalePrice;
          MO := MO + aItem.TotalPrice;
          TimeMO := TimeMO + ConverUnits(aItem.TotalAmount, aItem.UnitOfElement,'h');
        end;
        'HE':
        begin
          THE := THE + aItem.TotalSalePrice;
          HE := HE + aItem.TotalPrice;
          TimeHE := TimeHE + ConverUnits(aItem.TotalAmount, aItem.UnitOfElement,'h');
        end;
        'DI':
        begin
          TDI := TDI + aItem.TotalSalePrice;
          DI := DI + aItem.TotalPrice;
        end;
      end;
  end;

var
  IVA: float;
  i: integer;
begin
  MA := 0;
  MO := 0;
  HE := 0;
  DI := 0;
  TMA := 0;
  TMO := 0;
  THE := 0;
  TDI := 0;
  TimeMO := 0;
  TimeHE := 0;

  if (FLines.TotalSalePrice <> 0) and (FLines.TotalPrice <> 0) then
    eBenefict_Summary.Text := FormatFloat('#,##0.00', FLines.TotalSalePrice -
      FLines.TotalPrice) + ' - (' +
      FormatFloat('0.00', (FLines.TotalSalePrice / FLines.TotalPrice - 1) * 100) +
      '%)'
  else
    eBenefict_Summary.Text := '0';
  IVA := FLines.TotalSalePrice * StrToFloatDef(eIVA.Text, 0) / 100;
  eIVAMoney.Text := FormatFloat('#,##0.00', IVA);
  eTotalPriceWithTaxes.Text := FormatFloat('#,##0.00', FLines.TotalSalePrice + IVA);

  for i := 0 to FLines.ItemList.Count - 1 do
    if TObject(FLines.ItemList[i]) is TItem then
      ProcessItem(TItem(FLines.ItemList[i]));

  eTotalMaterialsCost.Text := FormatFloat('#,##0.00', MA);
  eTotalManPowerCost.Text := FormatFloat('#,##0.00', MO);
  eTotalMachineryCost.Text := FormatFloat('#,##0.00', HE);
  eTotalOthersCost.Text := FormatFloat('#,##0.00', DI);

  eTotalMaterials.Text := FormatFloat('#,##0.00', TMA);
  eTotalManPower.Text := FormatFloat('#,##0.00', TMO);
  eTotalMachinery.Text := FormatFloat('#,##0.00', THE);
  eTotalOthers.Text := FormatFloat('#,##0.00', TDI);

  eHoursMO.Text := FormatFloat('#,##0.00', TimeMO);
  eHoursHE.Text := FormatFloat('#,##0.00', TimeHE);
  eTotalHours.Text := FormatFloat('#,##0.00', TimeMO + TimeHE);
end;

procedure TSaleDocuments.CalPrecioTotal;
var
  i: integer;
begin
  if not (zqDocVenta.State = dsEdit) or not (zqDocVenta.State = dsInsert) then
    zqDocVenta.Edit;

  zqDocVenta.FieldByName('COST').AsFloat := FLines.TotalPrice;
  zqDocVenta.FieldByName('PRICE').AsFloat := FLines.TotalSalePrice;
  eGanancia.Text := FormatFloat('#,##0.00', FLines.TotalSalePrice - FLines.TotalPrice);

  for i := 0 to GridLines.RowCount - 1 do
  begin
    if (GridLines.CellsT['cType', i] = 'ST') then
      CalSubTotal(i);
  end;

end;

procedure TSaleDocuments.CalSubTotal(const ARow: integer);
var
  tmp: integer;
  SC, ST: double;
begin
  if ARow < 0 then
    Exit;

  tmp := ARow;
  ST := 0.0;
  SC := 0.0;

  while (tmp > 0) do
  begin
    Dec(tmp);
    if GridLines.CellsT['cType', tmp] = 'ST' then
      break;
    if GridLines.Rows[tmp].NodeIndex > 0 then
      continue;
    if GridLines.CellsT['cType', tmp] = '' then
      continue;

    SC := SC + StrToFloatDef(GridLines.CellsT['cTotalPrice', tmp], 0);
    ST := ST + StrToFloatDef(GridLines.CellsT['cTotalPVP', tmp], 0);
  end;

  GridLines.CellsT['cTotalPrice', ARow] := FloatToStr(SC);
  if (ST <> 0) and (SC <> 0) then
    GridLines.CellsT['cBenefit', ARow] := FloatToStr((ST / SC - 1) * 100);
  GridLines.CellsT['cTotalPVP', ARow] := FloatToStr(ST);
end;

procedure TSaleDocuments.UpdateCodeIndexSince(Idx: integer);
var
  Ind: string;
  i: integer;
begin
  ind := '';
  i := Idx - 1;
  while i >= 0 do
  begin
    if not (TObject(FLines.ItemList[i]) is TItem) then
    begin
      Dec(i);
      continue;
    end;
    ind := TItem(FLines.ItemList[i]).IndexCode;
    Break;
  end;

  if ind <> '' then
    ind := IncStr(ind, 1)
  else
    ind := '1';

  i := Idx;
  TItem(FLines.ItemList[i]).IndexCode := ind;
  GridLines.CellsT['cIndex', TNiceRow(TItem(FLines.ItemList[i]).Row).Index] := ind;

  for i := i + 1 to FLines.ItemList.Count - 1 do
  begin
    if not (TObject(FLines.ItemList[i]) is TItem) then
      Break;
    ind := IncStr(ind, 1);
    TItem(FLines.ItemList[i]).IndexCode := ind;
    GridLines.CellsT['cIndex', TNiceRow(TItem(FLines.ItemList[i]).Row).Index] := ind;
  end;
end;

function TSaleDocuments.InsertarItem(Dato: ansistring; ARow: integer;
  aParent: TObject): integer;
var
  zqElem, zqElemCom: TZQuery;
  i, df: integer;
  aItem: TItem;
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

  if Assigned(GridLines.Rows[ARow].ExternalObject) then
  begin
    aItem := TItem(GridLines.Rows[ARow].ExternalObject);
    aItem.Clear;
  end
  else
    aItem := FLines.CreateItem(aParent, GridLines.Rows[ARow]);

  aItem.Code := zqElem.FieldByName('CODE').Text;
  aItem.TypeOfElement := zqElem.FieldByName('TYPE').Text;
  aItem.Title := zqElem.FieldByName('TITLE').Text;
  aItem.Description := zqElem.FieldByName('DESCRIPTION').AsString;
  aItem.UnitOfElement := zqElem.FieldByName('UNIT_ID').AsString;
  aItem.Price := zqElem.FieldByName('PURCHASE_PRICE').AsFloat;

  GridLines.CellsT['cCode', aRow] := aItem.Code;
  GridLines.CellsT['cTitle', aRow] := aItem.Title;
  GridLines.CellsT['cDescription', aRow] := aItem.Description;
  GridLines.CellsT['cUnit', aRow] := aItem.UnitOfElement;
  GridLines.CellsT['cUnitPrice', aRow] := FloatToStr(aItem.Price);
  GridLines.CellsT['cType', aRow] := aItem.TypeOfElement;

  i := 0;
  if zqElem.FieldByName('TYPE').Text = 'UO' then
  begin
    zqElemCom := TZQuery.Create(self);
    try
      zqElemCom.Connection := MainWindow.zcMainConnection;
      sqlEXEC(zqElemCom, 'SELECT * FROM ELEMENTCOMPOSITION WHERE CODE = ' +
        QuotedStr(zqElem.FieldByName('CODE').Text));

      df := 0;
      while not zqElemCom.EOF do
      begin
        Application.ProcessMessages;
        Inc(i);
        GridLines.InsertRow(ARow + i);
        df := InsertarItem(zqElemCom.FieldByName('ELEMENT_CODE').Text,
          ARow + i, aItem);
        TItem(aItem.Items[aItem.Items.Count - 1]).UnitAmount :=
          zqElemCom.FieldByName('ELEMENT_AMOUNT').AsFloat;
        GridLines.CellsT['cUnitAmount', ARow + i] :=
          zqElemCom.FieldByName('ELEMENT_AMOUNT').Text;
        i := i + df;
        zqElemCom.Next;
      end;
    finally
      zqElemCom.Free;
    end;
  end;

  zqElem.Free;

  Result := i;

  if GridLines.Rows[ARow].NodeIndex > 0 then
    Exit;

  UpdateCodeIndexSince(FLines.IndexOf(aItem));
  //addTasks(aItem);
end;

procedure TSaleDocuments.BorrarItem(ARow: integer);
begin

  if not Assigned(GridLines.Rows[Arow].ExternalObject) then
  begin
    GridLines.DeleteRow(ARow);
  end
  else
  begin
    if TItem(GridLines.Rows[Arow].ExternalObject).Parent = FLines then
      FLines.ItemList.Delete(FLines.ItemList.IndexOf(
        GridLines.Rows[Arow].ExternalObject));
    TItem(GridLines.Rows[Arow].ExternalObject).Free;
    CalPrecioTotal();
  end;

end;

procedure TSaleDocuments.bClientEditClick(Sender: TObject);
begin
  // Abrir el cliente
  TClient.Create(Application, edCID.Text);
end;

procedure TSaleDocuments.bCloseInfoPanelClick(Sender: TObject);

  procedure AnimateToSize(aVal: integer);
  var
    step: double;
    i: integer;
  begin
    step := (aVal - pInfoPanel.Height) / 10;
    for i := 0 to 9 do
    begin
      pInfoPanel.Height := pInfoPanel.Height + round(step);
      Repaint;
      Sleep(1);
    end;
    pInfoPanel.Height := aVal;
  end;

begin
  if pInfoPanel.Height = 102 then
    AnimateToSize(34)
  else
    AnimateToSize(102);
end;

procedure TSaleDocuments.bCloseClick(Sender: TObject);
begin
  inherited;
end;

procedure TSaleDocuments.bFontMinus1Click(Sender: TObject);
begin
  bFontMinus1.Down := not bFontMinus1.Down;
  // toggle visibility of packets
end;

procedure TSaleDocuments.bFontPlusClick(Sender: TObject);
begin
  GridLines.Font.Size := GridLines.Font.Size + 1;
  GridLines.HeaderFont.Size := GridLines.Font.Size;
end;

procedure TSaleDocuments.bFontMinusClick(Sender: TObject);
begin
  GridLines.Font.Size := GridLines.Font.Size - 1;
  GridLines.HeaderFont.Size := GridLines.Font.Size;
end;

procedure TSaleDocuments.bSaveClick(Sender: TObject);
var
  ZQ: TZQuery;
  num, NumRow, i: integer;
begin
  // Condiciones:
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

  Screen.Cursor := crHourGlass;
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

    for i := 0 to Max(GridLines.RowCount, NumRow) - 1 do
    begin
      if (i >= GridLines.RowCount) then   // Borrar registros
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

      GridLines.CellsT['cIndex', i] := GridLines.CellsT['cIndex', i];
      zqDocVentaData.FieldByName('NODEINDEX').Text := GridLines.CellsT['cIndex', i];
      zqDocVentaData.FieldByName('ELEMENT_CODE').Text := GridLines.CellsT['cCode', i];
      zqDocVentaData.FieldByName('ELEMENT_TITLE').Text := GridLines.CellsT['cTitle', i];
      zqDocVentaData.FieldByName('ELEMENT_DESCRIPTION').AsString := GridLines.CellsT['cDescription', i];
      zqDocVentaData.FieldByName('ELEMENT_UNIT_AMOUNT').Text := GridLines.CellsT['cUnitAmount', i];
      zqDocVentaData.FieldByName('ELEMENT_TOTAL_AMOUNT').Text := GridLines.CellsT['cTotalAmount', i];
      zqDocVentaData.FieldByName('ELEMENT_UNIT').Text := GridLines.CellsT['cUnit', i];
      zqDocVentaData.FieldByName('ELEMENT_PRICE').Text := GridLines.CellsT['cUnitPrice', i];
      zqDocVentaData.FieldByName('BENEFIT').Text := GridLines.CellsT['cBenefit', i];
      zqDocVentaData.FieldByName('DISCOUNT').Text := GridLines.CellsT['cDiscount', i];
      zqDocVentaData.FieldByName('ELEMENT_TYPE').Text := GridLines.CellsT['cType', i];
      zqDocVentaData.FieldByName('ELEMENT_INDEX').AsInteger := GridLines.Rows[i].NodeIndex;

      if Assigned(GridLines.Rows[i].ExternalObject) then
        if TItem(GridLines.Rows[i].ExternalObject).Parent is TItem then
          zqDocVentaData.FieldByName('PARENT').AsInteger :=
            TNiceRow(TItem(TItem(GridLines.Rows[i].ExternalObject).Parent).Row).Index;


      zqDocVentaData.Post;
      zqDocVentaData.Next;
    end;
  end;

  // Salvar gantt:
  //if FGanttNeedSave then
  //SaveGantt(FGantt, DocCode, edTitle.Text, True);

  case (zqDocVenta.State) of
    dsEdit,
    dsInsert: zqDocVenta.Post;
  end;

  ButtonSaveEnabled := False;
  Screen.Cursor := crDefault;
end;

procedure TSaleDocuments.dsDocVentaStateChange(Sender: TObject);
begin
  case zqDocVenta.State of
    dsEdit, dsInsert:
      ButtonSaveEnabled := True;
    else
      ButtonSaveEnabled := False;
  end;
end;

procedure TSaleDocuments.edCIDAfterDropDown(Sender: TObject);
begin
  //edCID.ListSource.DataSet.Refresh;
end;

procedure TSaleDocuments.edPCodeAfterDropDown(Sender: TObject);
begin
  zqProjects.SQL.Text := 'SELECT CODE, TITLE, CUSTOMER_ID, CUSTOMER_NAME FROM PROJECT';
  if edCID.Text <> '' then
    zqProjects.SQL.Text := zqProjects.SQL.Text + ' WHERE CUSTOMER_ID = ' +
      QuotedStr(edCID.Text);
end;

procedure TSaleDocuments.edPCodeLookupClose(Sender: TObject; LookupResult: TStringList);
begin
  zqDocVenta.FieldByName('PROJECT_TITLE').Text := zqProjects.FieldByName('TITLE').Text;

  if zqDocVenta.FieldByName('CUSTOMER_CODE').Text = '' then
  begin
    zqDocVenta.FieldByName('CUSTOMER_CODE').Text :=
      zqProjects.FieldByName('CUSTOMER_CODE').Text;
    zqDocVenta.FieldByName('CUSTOMER_NAME').Text :=
      zqProjects.FieldByName('CUSTOMER_NAME').Text;
  end;
end;

procedure TSaleDocuments.edCIDChange(Sender: TObject);
begin
  if edCID.Text = '' then
    bClientEdit.Enabled := False
  else
    bClientEdit.Enabled := True;
end;

procedure TSaleDocuments.edCIDCloseUp(Sender: TObject);
begin

end;

procedure TSaleDocuments.edCIDDragDrop(Sender, Source: TObject; X, Y: integer);
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

procedure TSaleDocuments.edCIDDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  Accept := (Source = ClientList.Grid) or Source.ClassNameIs('TControlDragObject');
end;

procedure TSaleDocuments.edCIDLookupClose(Sender: TObject; LookupResult: TStringList);
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

procedure TSaleDocuments.edStateSelect(Sender: TObject);

  procedure AddToProject(aNew: boolean);
  var
    aForm: TProjects;
  begin
    if aNew then
    begin
      aForm := TProjects.Create(Application, '', 0, doNew);
      aForm.zqProject.FieldByName('CUSTOMER_CODE').Text :=
        zqDocVenta.FieldByName('CUSTOMER_CODE').Text;
      aForm.zqProject.FieldByName('CUSTOMER_NAME').Text :=
        zqDocVenta.FieldByName('CUSTOMER_NAME').Text;
    end
    else
      aForm := TProjects.Create(Application, zqDocVenta.FieldByName(
        'PROJECT_CODE').Text, 0, doNew);

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
        mrYes: AddToProject(True);
      end;
    end
    else
      case MessageDlg('Se ha ACEPTADO el presupuesto:' + #13 + #10 +
          '¿Quiere abregar el documento al Proyecto?', mtConfirmation,
          [mbYes, mbNo, mbCancel], 0) of
        mrCancel: Exit;
        mrYes: AddToProject(False);
      end;
    SetReadOnly;
  end
  else if (edState.ItemIndex = 5) then
    SetReadOnly;
end;

procedure TSaleDocuments.edTitleKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin

  if Key = VK_RETURN then
  begin
    SelectNext(TWinControl(Sender), True, True);
    Key := 0;
    Exit;
  end;
end;

procedure TSaleDocuments.eIVAExit(Sender: TObject);
begin
  Summary;
end;

procedure TSaleDocuments.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  inherited FormClose(Sender, CloseAction);

  zqDocVenta.Cancel;
  zqDocVentaData.Cancel;

end;

procedure TSaleDocuments.FormCreate(Sender: TObject);

  procedure FillFieldGrid(aZQ: TZQuery; aRow: integer);
  begin
    GridLines.CellsT['cIndex', ARow] := aZQ.FieldByName('NODEINDEX').Text;
    GridLines.CellsT['cCode', ARow] := aZQ.FieldByName('ELEMENT_CODE').Text;
    GridLines.CellsT['cTitle', ARow] := aZQ.FieldByName('ELEMENT_TITLE').Text;
    GridLines.CellsT['cDescription', ARow] :=
      aZQ.FieldByName('ELEMENT_DESCRIPTION').AsString;
    GridLines.CellsT['cUnitAmount', ARow] := aZQ.FieldByName('ELEMENT_UNIT_AMOUNT').Text;
    GridLines.CellsT['cTotalAmount', ARow] :=
      aZQ.FieldByName('ELEMENT_TOTAL_AMOUNT').Text;
    GridLines.CellsT['cUnit', ARow] := aZQ.FieldByName('ELEMENT_UNIT').Text;
    GridLines.CellsT['cUnitPrice', ARow] := aZQ.FieldByName('ELEMENT_PRICE').Text;
    GridLines.CellsT['cBenefit', ARow] := aZQ.FieldByName('BENEFIT').Text;
    GridLines.CellsT['cDiscount', ARow] := aZQ.FieldByName('DISCOUNT').Text;
    GridLines.CellsT['cType', ARow] := aZQ.FieldByName('ELEMENT_TYPE').Text;
    GridLines.Rows[ARow].NodeIndex := aZQ.FieldByName('ELEMENT_INDEX').AsInteger;
  end;

  procedure FillFieldItem(aItem: TItem; aZQ: TZQuery; aRow: integer);
  begin
    aItem.Row := GridLines.Rows[aRow];
    aItem.TypeOfElement := aZQ.FieldByName('ELEMENT_TYPE').Text;
    aItem.IndexCode := aZQ.FieldByName('NODEINDEX').Text;
    aItem.Code := aZQ.FieldByName('ELEMENT_CODE').Text;
    aItem.Title := aZQ.FieldByName('ELEMENT_TITLE').Text;
    aItem.Description := aZQ.FieldByName('ELEMENT_DESCRIPTION').AsString;
    aItem.UnitAmount := aZQ.FieldByName('ELEMENT_UNIT_AMOUNT').AsFloat;
    aItem.UnitOfElement := aZQ.FieldByName('ELEMENT_UNIT').Text;
    aItem.Price := aZQ.FieldByName('ELEMENT_PRICE').AsFloat;
    aItem.Benefit := aZQ.FieldByName('BENEFIT').AsFloat;
    aItem.Discount := aZQ.FieldByName('DISCOUNT').AsFloat;

    FillFieldGrid(aZQ, aRow);
    exit;
  end;

  procedure LoadItemFromDB(var aRow: integer; aItem: TItem);
  var
    zq: TZQuery;
    aChild: TItem;
  begin
    zq := TZQuery.Create(self);
    try
      zq.Connection := MainWindow.zcMainConnection;
      sqlEXEC(zq, 'SELECT * FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE = ' +
        QuotedStr(DocCode) + ' AND PARENT = ' + IntToStr(aRow));

      while not zq.EOF do
      begin
        aChild := TItem.Create(aItem);
        GridLines.RowCount := GridLines.RowCount + 1;
        Inc(aRow);
        FillFieldItem(aChild, zq, aRow);

        if zq.FieldByName('ELEMENT_TYPE').Text = 'UO' then
          LoadItemFromDB(aRow, aChild);

        zq.Next;
      end;
    finally
      zq.Free;
    end;
  end;

  procedure OpenDocFormDB(aZQ: TZQuery);
  var
    aRow: integer;
    aItem: TItem;
  begin
    sqlEXEC(aZQ, 'SELECT * FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE = ' +
      QuotedStr(DocCode) + ' AND ELEMENT_INDEX = 0');

    while not aZQ.EOF do
    begin
      ARow := aZQ.FieldByName('ID').AsInteger - 1;
      GridLines.RowCount := ARow + 1;

      case aZQ.FieldByName('ELEMENT_TYPE').Text of
        'UO':
        begin
          aItem := FLines.CreateItem(FLines, GridLines.Rows[aRow]);
          // TItem.Create(FLines);
          FillFieldItem(aItem, aZQ, aRow);
          LoadItemFromDB(ARow, aItem);
        end;
        'MA', 'MO', 'HE', 'DI':
        begin
          aItem := FLines.CreateItem(FLines, GridLines.Rows[aRow]);
          // TItem.Create(FLines);
          FillFieldItem(aItem, aZQ, aRow);
        end;
        'ST':
        begin
          // hacer algo más
          FillFieldGrid(aZQ, aRow);
        end
        else
          FillFieldGrid(aZQ, aRow);
      end;

      //if GridLines.CellsT['cType', ARow] = 'ST' then CalSubTotal(ARow);
      aZQ.Next;
    end;
    CalPrecioTotal;
    if ARow = 0 then
      GridLines.RowCount := 40;
  end;

var
  i: integer;
  ZQ: TZQuery;
begin
  ManualDock(MainWindow.TabDockCenter);
  zqClient.Open;
  zqProjects.Open;

  pmConvertTo.Items[DocType - 1].Visible := false;

  case DocType of
    1: // Factura Preforma
    begin
      Caption := 'Factura Preforma: ';
      TP := 'FP';
    end;
    2: // Factura
    begin
      Caption := 'Factura: ';
      TP := 'BI';
    end;
    3: // Abono
    begin
      Caption := 'Abono: ';
      TP := 'PA';
    end;
    4: // Albarán  DELIVERY NOTE
    begin
      Caption := 'Albarán: ';
      TP := 'DN';
    end;
  end;

  if (DocOperation = doEdit) then // Abrir presupuesto existente
  begin
    sqlEXEC(zqDocVenta, 'SELECT * FROM SALEDOCUMENT WHERE CODE = ' + QuotedStr(DocCode));
    OpenDocFormDB(zqDocVentaData);

    {
    if LoadGantt(FGantt, DocCode) = 0 then
    begin
      for i := 0 to GridLines.RowCount - 1 do
        if GridLines.Rows[i].NodeIndex = 0 then
          addTasks(i, FGantt.IntervalCount);
    end;
    }

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
      OpenDocFormDB(ZQ);
    end
    else
    begin
      GridLines.RowCount := 40;
      TItem.Create(GridLines);
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

  if not FUser.Permits.GetDocPermit(TP).Write then
  begin
    if FUser.Permits.GetDocPermit(TP).Print then
    begin
      bPrint.Enabled := False;
      bPrint.Visible := False;
    end;
  end;
  {$IFDEF DEBUG}
  GridLines.Columns.Items[12].Visible := True;
  {$ENDIF}
end;

procedure TSaleDocuments.FormShow(Sender: TObject);
begin
  inherited;
  pcAllChange(Sender);
end;

procedure TSaleDocuments.InsertarLinea(Sender: TObject);
  {$IFDEF DEBUG}
  procedure ShowFullTree(aItem: TItem);
  var
    i: integer;
    tmp: string;
  begin
    tmp := '';

    for i := 0 to aItem.NodeIndex do
      tmp := tmp + '-';
    dgSetLine(tmp + aItem.Code);

    if aItem.HasChildren then
      for i := 0 to aitem.Items.Count - 1 do
        ShowFullTree(TItem(aitem.Items[i]));
  end;

  procedure showtree(aItem: TItem);
  var
    aP: TItem;

    procedure findParent(tmp: TItem);
    begin
      if tmp.Parent is TItem then
        findParent(TItem(tmp.Parent))
      else
        aP := tmp;
    end;

  begin
    findParent(aItem);
    ShowFullTree(aP);
  end;

{$ENDIF}
var
  aItem: TItem;
begin
  GridLines.InsertRow(GridLines.Row);

  if Assigned(GridLines.Rows[GridLines.Row + 1].ExternalObject) then
  begin
    if (TObject(GridLines.Rows[GridLines.Row + 1].ExternalObject) is TItem) then
    begin
      if TItem(GridLines.Rows[GridLines.Row + 1].ExternalObject).NodeIndex > 0 then
      begin
        aItem := TItem.Create(TItem(GridLines.Rows[GridLines.Row +
          1].ExternalObject).Parent, TItem(GridLines.Rows[GridLines.Row +
          1].ExternalObject).Index);
        aItem.Row := GridLines.Rows[GridLines.Row];
        GridLines.Rows[GridLines.Row].NodeIndex := aItem.NodeIndex;

        {$IFDEF DEBUG}
        dgSetLine('----Item actualizado: ---------------------------------------------------');
        if TItem(GridLines.Rows[GridLines.Row + 1].ExternalObject).Parent is TItem then
          showtree(TItem(TItem(GridLines.Rows[GridLines.Row + 1].ExternalObject).Parent))
        else
          showtree(TItem(GridLines.Rows[GridLines.Row + 1].ExternalObject));
        {$ENDIF}

      end;
    end;
  end;

  case TControl(Sender).Tag of
    1: GridLines.CellsT['cType', GridLines.Row] := 'MA';
    2: GridLines.CellsT['cType', GridLines.Row] := 'MO';
    3: GridLines.CellsT['cType', GridLines.Row] := 'HE';
    4: GridLines.CellsT['cType', GridLines.Row] := 'DI';
  end;

  if TControl(Sender).Tag > 0 then
    GridLines.Rows[GridLines.Row].ImageIndex := TControl(Sender).Tag;
end;

procedure TSaleDocuments.BorrarLinea(Sender: TObject);
begin
  BorrarItem(GridLines.Row);
end;

procedure TSaleDocuments.MenuItem11Click(Sender: TObject);
begin
  // Abrir formulario de configuración con la penstaña adecuada:
  with TConfigWindow.Create(Application) do
  begin
    Show;
    NoteBook2.PageIndex := 3;
  end;

end;

procedure TSaleDocuments.miConvertTo(Sender: TObject);
var
  form: TSaleDocuments;
begin
  form := TSaleDocuments.Create(Application, DocCode, TMenuItem(Sender).MenuIndex +
    1, doCopy);
  form.Show;
  form.SetFocus;
end;

procedure TSaleDocuments.miEditElementClick(Sender: TObject);
var
  form: TElement;
begin

  if StringReplace(GridLines.CellsT['cCode', GridLines.Row], ' ', '',
    [rfReplaceAll]) = '' then
    exit;
  form := TElement.Create(Application, GridLines.CellsT['cCode', GridLines.Row],
    0, doEdit);
  form.Show;
end;

procedure TSaleDocuments.miInsertSutTotalClick(Sender: TObject);
begin

  //TSubTotalItem.Create(FLines).Create();

  GridLines.CellsT['cType', GridLines.Row] := 'ST';
  GridLines.CellsT['cTitle', GridLines.Row] := 'SubTotal';
  GridLines.Rows[GridLines.Row].NodeIndex := 0;

  CalSubTotal(GridLines.Row);
  GridLines.Invalidate;
end;

procedure TSaleDocuments.miShowAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to GridLines.RowCount - 1 do
  begin
    if assigned(GridLines.Rows[i].ExternalObject) then
    begin
      if TItem(GridLines.Rows[i].ExternalObject).NodeIndex = 0 then
        TItem(GridLines.Rows[i].ExternalObject).ShowChildren;
    end;
  end;
end;

procedure TSaleDocuments.miHideAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to GridLines.RowCount - 1 do
  begin
    if assigned(GridLines.Rows[i].ExternalObject) then
    begin
      if TItem(GridLines.Rows[i].ExternalObject).NodeIndex = 0 then
        TItem(GridLines.Rows[i].ExternalObject).HideChildren;
    end;
  end;
end;

procedure TSaleDocuments.miShowCompositionClick(Sender: TObject);
begin
  if assigned(GridLines.Rows[GridLines.Row].ExternalObject) then
    TItem(GridLines.Rows[GridLines.Row].ExternalObject).ShowChildren;
end;

procedure TSaleDocuments.miInsertPackClick(Sender: TObject);
var
  aItem: TItem;
begin

  GridLines.InsertRow(GridLines.Row);
  aItem := CreateItem(GridLines, GridLines.Rows[GridLines.Row]);
  aItem.TypeOfElement := 'UO';

end;

procedure TSaleDocuments.miHideCompositionClick(Sender: TObject);
begin
  if assigned(GridLines.Rows[GridLines.Row].ExternalObject) then
    TItem(GridLines.Rows[GridLines.Row].ExternalObject).HideChildren;
end;

procedure TSaleDocuments.miSaveInDBClick(Sender: TObject);
var
  form: TElement;
  ind, Row, YY: integer;
begin

  Row := GridLines.Row;
  if GridLines.CellsT['cCode', Row] <> '' then
    Exit;
  form := TElement.Create(self);


  form.zqElement.FieldByName('TITLE').AsString := GridLines.CellsT['cTitle', Row];
  form.zqElement.FieldByName('DESCRIPTION').AsString := GridLines.CellsT['cTitle', Row];
  form.zqElement.FieldByName('UNIT_ID').AsString := GridLines.CellsT['cUnit', Row];

  case GridLines.CellsT['cType', Row] of
    'UO':
    begin
      ind := GridLines.Rows[Row].NodeIndex;
      Inc(Row);
      form.eType.ItemIndex := 0;
      form.gComposition.RowCount := 0;

      while GridLines.Rows[Row].NodeIndex > ind do
      begin
        if Row >= GridLines.RowCount then
          break;
        YY := form.gComposition.RowCount;
        form.gComposition.RowCount := YY + 1;
        form.gComposition.CellsT['cCode', YY] := GridLines.CellsT['cCode', Row];
        form.gComposition.CellsT['cTitle', YY] := GridLines.CellsT['cTitle', Row];
        form.gComposition.CellsT['cUnitAmount', YY] :=
          GridLines.CellsT['cUnitAmount', Row];
        form.gComposition.CellsT['cUnit', YY] := GridLines.CellsT['cUnit', Row];
        form.gComposition.CellsT['cUnitPrice', YY] :=
          GridLines.CellsT['cUnitPrice', Row];

        form.gComposition.Rows[YY].NodeIndex :=
          GridLines.Rows[Row].NodeIndex - (ind + 1);

        //SetImageToRow(GridLines.CellsT['cType', Row], GridLines.Rows[YY]);
        Inc(Row);
      end;
    end;
    'MA': form.eType.ItemIndex := 1;
    'MO': form.eType.ItemIndex := 2;
    'HE': form.eType.ItemIndex := 3;
    'DI': form.eType.ItemIndex := 4;
  end;

  form.Show;
end;

procedure TSaleDocuments.GridLinesAfterDrawTextCell(Sender: TObject;
  ACanvas: TCanvas; ACol, ARow: integer; Rc: TRect);
begin

  if GridLines.CellsT['cType', ARow] = 'ST' then
  begin
    ACanvas.Pen.Color := clBlue;
    ACanvas.MoveTo(Rc.Left, Rc.Top + 1);
    ACanvas.LineTo(Rc.Right, Rc.Top + 1);
  end;

end;

procedure TSaleDocuments.GridLinesBeforeShowEdit(Sender: TObject; ARec: TRect;
  var aCanShow: boolean);
begin
  case GridLines.Columns[GridLines.Col].Name of
    'cIndex', 'cDiscount', 'cBenefit':
      if (GridLines.Rows[GridLines.Row].NodeIndex > 0) or
        (GridLines.CellsT['cType', GridLines.Row] = '') then
        aCanShow := False;
    'cTotalAmount', 'cTotalPrice', 'cTotalPVP': aCanShow := False;
  end;
end;

procedure TSaleDocuments.GridLinesCellExit(Sender: TObject; ACol, ARow: integer);
var
  //X: Integer;
  Y: integer;
begin
  if (ACol = -1) or (ARow = -1) then
    Exit;
  if ARow >= GridLines.RowCount then
    Exit;

  if (CellText <> GridLines.Cells[ACol, ARow]) then
  begin
    //X := ACol;
    Y := ARow;
    case GridLines.Columns[ACol].Name of
      'cIndex': // ¿Actualizar el índice de los hijos?
      begin
        TItem(GridLines.Rows[ARow].ExternalObject).IndexCode :=
          GridLines.CellsT['cIndex', ARow];
        //UpdateCodeIndexSince( FLines.IndexOf(TItem(GridLines.Rows[ARow].ExternalObject)) + 1);
      end;
      'cCode':
        InsertarItem(GridLines.CellsT['cCode', Y], Y, FLines{GridLines});
      'cTitle':
      begin
        if (GridLines.CellsT['cType', ARow] = '') and
          (GridLines.CellsT['cTitle', ARow] <> '') then
          GridLines.CellsT['cType', ARow] := 'TI'
        else
        if (GridLines.CellsT['cType', ARow] = 'TI') and
          (GridLines.CellsT['cTitle', ARow] = '') then
          GridLines.CellsT['cType', ARow] := '';
      end;

      'cUnitAmount':
        if assigned(GridLines.Rows[ARow].ExternalObject) then
          TItem(GridLines.Rows[ARow].ExternalObject).UnitAmount :=
            StrToFloatDef(GridLines.CellsT['cUnitAmount', ARow], 0);

      'cUnit':
        if assigned(GridLines.Rows[ARow].ExternalObject) then
          TItem(GridLines.Rows[ARow].ExternalObject).UnitOfElement :=
            GridLines.CellsT['cUnit', ARow];

      'cUnitPrice':
        if assigned(GridLines.Rows[ARow].ExternalObject) then
          TItem(GridLines.Rows[ARow].ExternalObject).Price :=
            StrToFloatDef(GridLines.CellsT['cUnitPrice', ARow], 0);

      'cBenefit':
        if Assigned(GridLines.Rows[ARow].ExternalObject) then
          TItem(GridLines.Rows[ARow].ExternalObject).Benefit :=
            StrToFloatDef(GridLines.CellsT['cBenefit', ARow], 0);

      'cDiscount':
        if Assigned(GridLines.Rows[ARow].ExternalObject) then
          TItem(GridLines.Rows[ARow].ExternalObject).Discount :=
            StrToFloatDef(GridLines.CellsT['cDiscount', ARow], 0);

    end;
    CalPrecioTotal();
    FNeedSave := True;
    bSave.Enabled := True;


    Exit;
    // Actualización de Tasks:
    if Assigned(GridLines.Rows[ARow].ExternalObject) then
    begin
      case GridLines.Columns[ACol].Name of
        //0:;
        'cTitle':
        begin
          TInterval(GridLines.Rows[ARow].ExternalObject).Task :=
            GridLines.Cells[ACol, ARow];
        end;
        'cUnitAmount':
        begin
          //TInterval(GridLines.Rows[ARow].ExternalObject).FinishDate :=
          //  calFinishDate(date, UOIsTask(aRow, False));
        end;
      end;
    end;
  end;
end;

procedure TSaleDocuments.GridLinesClick(Sender: TObject);
begin

end;

procedure TSaleDocuments.GridLinesColRowChanged(Sender: TObject; ACol, ARow: integer);
begin
  if (ACol = -1) or (ARow = -1) then
    Exit;

  CellText := GridLines.Cells[ACol, ARow];

  if GridLines.CellsT['cType', ARow] = 'ST' then
    GridLines.Columns.Items[ACol].ReadOnly := True
  else
    GridLines.Columns.Items[ACol].ReadOnly := False;

end;

procedure TSaleDocuments.GridLinesDragDrop(Sender, Source: TObject; X, Y: integer);
var
  offset, CCol, CRow: integer;
  From: TDBGrid;
  i: integer;
begin
  offset := 0;
  GridLines.MouseToCell(X, Y, CCol, CRow);

  if Source.ClassNameIs('TControlDragObject') then
    From := TDBGrid(TControlDragObject(Source).Control)
  else
    From := TDBGrid(Source);

  for i := 0 to From.SelectedRows.Count - 1 do
  begin
    From.DataSource.DataSet.GotoBookmark(From.SelectedRows.Items[i]);
    offset := 1 + offset + InsertarItem(From.DataSource.DataSet.FieldByName('CODE').Text,
      CRow + offset, Flines{GridLines});

  end;

  GridLines.Row := CRow;
  GridLines.Col := 0;
  GridLines.SetFocus;

  if not FNeedSave then
    FNeedSave := True;

end;

procedure TSaleDocuments.GridLinesDragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
var
  CCol, CRow: integer;
begin
  GridLines.MouseToCell(X, Y, CCol, CRow);

  Accept := (Sender = Source) or (Source = ElementsList.Grid) or
    Source.ClassNameIs('TControlDragObject');

  Accept := True;

  if Accept then
  begin
    GridLines.Row := CRow;
    GridLines.SelectArea := Rect(0, CRow, GridLines.ColCount - 1, CRow);
  end;
end;

procedure TSaleDocuments.GridLinesDrawCell(Sender: TObject; ACanvas: TCanvas;
  ACol, ARow: integer; Rc: TRect; var Handled: boolean);

  procedure PaintFont(aFont: TFont);
  begin
    //ACanvas.Font.Style := aFont.Style;
    ACanvas.Font.Assign(aFont);
    ACanvas.Font.Name := aFont.Name;
    ACanvas.Font.Color := aFont.Color;
  end;

begin

  case GridLines.CellsT['cType', aRow] of
    'UO':
      if GridLines.Rows[ARow].NodeIndex = 0 then
        PaintFont(FConfig.ConfigBudgetForm.FontItemMain)
      else
        PaintFont(FConfig.ConfigBudgetForm.FontCompositionSecundary);

    'MA', 'MO', 'HE', 'DI':
      if GridLines.Rows[ARow].NodeIndex = 0 then
        PaintFont(FConfig.ConfigBudgetForm.FontItemMain)
      else
        PaintFont(FConfig.ConfigBudgetForm.FontItemSecundary);

    'TI': PaintFont(FConfig.ConfigBudgetForm.FontTitle);
    'ST': PaintFont(FConfig.ConfigBudgetForm.FontSummation);
  end;

  Exit;




  if GridLines.Rows[ARow].NodeIndex > 0 then
  begin
    ACanvas.Font.Color := clGray;
  end
  else
  begin
    //GridLines.CellStyle[ACol, ARow].Font.Size = 9; //Style << fsBold << fsUnderline;
    ACanvas.Font.Color := clBlack;
  end;

  //if GridLines.CellsT['cType', ARow] = 'UO' then
  if (GridLines.Rows[ARow].NodeIndex = 0) or
    (GridLines.CellsT['cType', ARow] = 'UO') then
    ACanvas.Font.Style := [fsBold]
  else
    ACanvas.Font.Style := [];
end;

procedure TSaleDocuments.GridLinesGutterClick(Sender: TObject; ARow: integer;
  Button: TMouseButton; Shift: TShiftState);
begin
  if Assigned(GridLines.Rows[ARow].ExternalObject) then
    TItem(GridLines.Rows[ARow].ExternalObject).ToggleChildrenVisibility;

end;

procedure TSaleDocuments.pcAllChange(Sender: TObject);
  procedure ShowToolBarButtons(aTag: integer);
  var
    i: integer;
  begin
    for i := 0 to ToolBar.ControlCount - 1 do
    begin
      if ToolBar.Controls[i].Tag = 0 then
        continue;
      if ToolBar.Controls[i].Tag = aTag then
        ToolBar.Controls[i].Visible := True
      else
        ToolBar.Controls[i].Visible := False;
    end;
  end;
begin
  ShowToolBarButtons(pcAll.TabIndex);

  case pcAll.TabIndex of
    1: ;
    2: Summary;
  end;
end;

end.
