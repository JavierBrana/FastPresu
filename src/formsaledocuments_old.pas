unit formSaleDocuments;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, NiceGrid, NiceLookUpComboBox, gsGantt,
  NiceCustomPanel, CustomNiceListBox, DBZVDateTimePicker, ZDataset, Controls,
  Forms, formWorkForm, BGRABitmapTypes, BCTypes, BCPanel, BCButton, LR_DBSet,
  Graphics, Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, ComCtrls, EditBtn,
  Menus, DBGrids, Grids, Math, Utiles, DB, dbf;

type

  { TSaleDocuments }

  TSaleDocuments = class(TWorkForm)
    BCButton2: TBCButton;
    bClientEdit: TBitBtn;
    BCPanel2: TBCPanel;
    bDeleteLine: TBCButton;
    bInsertLine1: TBCButton;
    bInsertLine2: TBCButton;
    bInsertLine3: TBCButton;
    bInsertLine4: TBCButton;
    bInsertLine5: TBCButton;
    bInsertLine6: TBCButton;
    bInsertLine7: TBCButton;
    bMakeBuyDoc: TBCButton;
    bSaveElementinDB: TBCButton;
    bInsertPaket: TBCButton;
    bDelete: TBCButton;
    bInsertSubTotal: TBCButton;
    bInsertLine: TBCButton;
    bEditElement: TBCButton;
    bZoomMinus1: TBCButton;
    bZoomPlus: TBCButton;
    bZoomMinus: TBCButton;
    CheckBox1: TCheckBox;
    dpCreationDate: TDBZVDateTimePicker;
    dpExpeditionDate: TDBZVDateTimePicker;
    dpValidate: TLabel;
    dpValidDate: TDBZVDateTimePicker;
    dsClient: TDataSource;
    dsProject: TDataSource;
    edCID: TNiceLookUpComboBox;
    edCName: TDBEdit;
    edDocCode: TDBEdit;
    edPCode: TNiceLookUpComboBox;
    edState: TDBComboBox;
    edTitle: TDBEdit;
    edTitle1: TDBEdit;
    edTitle2: TDBEdit;
		frDBDataSet1: TfrDBDataSet;
    DBMemo1: TDBMemo;
    dsDocVenta: TDataSource;
    dsDocVentaData: TDataSource;
    dsProjects: TDataSource;
    edCID2: TDBLookupComboBox;
    edCID3: TDBLookupComboBox;
    edDir1: TDBEdit;
    edDir2: TDBEdit;
    edPais: TDBEdit;
    edPobla: TDBEdit;
    edProvincia: TDBEdit;
    eTCompra: TDBEdit;
    gbNormalDirection: TGroupBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    miEditElement: TMenuItem;
    miDelete: TMenuItem;
    MenuItem10: TMenuItem;
    miShowAll: TMenuItem;
    miHideAll: TMenuItem;
    miInsertJump: TMenuItem;
    miInsertSutTotal: TMenuItem;
    miShowComposition: TMenuItem;
    MenuItem16: TMenuItem;
    miInsertPack: TMenuItem;
    MenuItem3: TMenuItem;
    miHideComposition: TMenuItem;
    miSaveInDB: TMenuItem;
    miSubMenuPack: TMenuItem;
    miSubMenuInsert: TMenuItem;
    miInsertLine: TMenuItem;
    NiceGrid1: TNiceGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    pcAll: TPageControl;
    pmLines: TPopupMenu;
    pmConvertTo: TPopupMenu;
    ScrollBox1: TScrollBox;
    SeparatorBevel1: TBevel;
    SeparatorBevel2: TBevel;
    SeparatorBevel3: TBevel;
    SeparatorBevel4: TBevel;
    SeparatorBevel6: TBevel;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    ToolBarDocument: TBCPanel;
    ToolBarConvertTo: TBCPanel;
    tsPlanner: TTabSheet;
    tsDocument: TTabSheet;
    tsGeneral: TTabSheet;
    tsSummary: TTabSheet;
    zqDocVentaCODE: TStringField;
    zqDocVentaCOST: TFloatField;
    zqDocVentaCREATEDAT: TDateField;
    zqDocVentaCREATEDBY: TStringField;
    zqDocVentaCUSTOMER_CODE: TStringField;
    zqDocVentaCUSTOMER_NAME: TStringField;
    zqDocVentaDELIVERY_DATE: TDateField;
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
    zqProject: TZQuery;
    zqProjectpyCode: TStringField;
    zqProjectpyTitle: TStringField;
    zqProjects: TZQuery;
    zqDocVenta: TZQuery;
    zqDocVentaData: TZQuery;
    zqClient: TZQuery;
    zqClientclCIF: TStringField;
    zqClientclCode: TStringField;
    zqClientclNom: TStringField;
    zqProjectspyCode: TStringField;
    zqProjectspyTitle: TStringField;
    procedure bClientEditClick(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
    procedure bPrintClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);override;
    procedure dsDocVentaStateChange(Sender: TObject);
    procedure edCIDChange(Sender: TObject);
    procedure edCIDDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure edCIDDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure edCIDLookupClose(Sender: TObject; LookupResult: TStringList);
    procedure edDocCodeChange(Sender: TObject);
    procedure edTitleKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InsertarLinea(Sender: TObject);
    procedure BorrarLinea(Sender: TObject);
    procedure miConverTo(Sender: TObject);
    procedure miEditElementClick(Sender: TObject);
    procedure miInsertSutTotalClick(Sender: TObject);
    procedure miShowAllClick(Sender: TObject);
    procedure miHideAllClick(Sender: TObject);
    procedure miShowCompositionClick(Sender: TObject);
    procedure miInsertPackClick(Sender: TObject);
    procedure miHideCompositionClick(Sender: TObject);
    procedure NiceGrid1AfterDrawTextCell(Sender: TObject; ACanvas: TCanvas;
      ACol, ARow: integer; Rc: TRect);
    procedure NiceGrid1CellChange(Sender: TObject; ACol, ARow: integer;
      var Str: string);
    procedure NiceGrid1CellExit(Sender: TObject; ACol, ARow: integer);
    procedure NiceGrid1ColRowChanged(Sender: TObject; ACol, ARow: integer);
    procedure NiceGrid1DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure NiceGrid1DragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure NiceGrid1DrawCell(Sender: TObject; ACanvas: TCanvas;
      ACol, ARow: integer; Rc: TRect; var Handled: boolean);
    procedure NiceGrid1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure pcAllChange(Sender: TObject);
  private
    { private declarations }
    CellText: string;
    TP: ansistring;
    FNeedSave: boolean;

    procedure CalPrecioUO(const aRow: integer);
    procedure CalPrecioElemento(const aRow: integer);
    procedure CalPrecioTotal;
    procedure CalSubTotal(const ARow: integer);

    function InsertarItem(Dato: ansistring; idx, ARow: integer): integer;
    procedure BorrarItem(ARow: integer);

  public
    { public declarations }
  end;

var
  Budgets: TSaleDocuments;

implementation

uses
  ControlDragObject, LCLType,
  formMainWindow,
  formClient,
  formClientList,
  formElement,
  formElementsList,
  formBuyDocuments;

{$R *.lfm}

procedure TSaleDocuments.CalPrecioUO(const aRow: integer);
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
  ben := StrToFloatDef(NiceGrid1.Cells[8, aRow], 0);
  des := StrToFloatDef(NiceGrid1.CellsT['cTotalPVP', aRow], 0);

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

procedure TSaleDocuments.CalPrecioElemento(const aRow: integer);
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
  ben := StrToFloatDef(NiceGrid1.Cells[8, tmp], 0);
  des := StrToFloatDef(NiceGrid1.CellsT['cTotalPVP', tmp], 0);
  pretotal := pre * (1 + ben / 100) * (1 - des / 100);
  NiceGrid1.CellsT['cTotalPVP', tmp] := FloatToStr(pretotal);
end;

procedure TSaleDocuments.CalPrecioTotal;
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
end;

procedure TSaleDocuments.CalSubTotal(const ARow: integer);
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

function TSaleDocuments.InsertarItem(Dato: ansistring; idx, ARow: integer): integer;
var
  zqElem, zqElemCom: TZQuery;
  i, df: integer;
begin

  zqElem := TZQuery.Create(self);
  zqElem.Connection := MainWindow.zcMainConnection;

  sqlEXEC(zqElem, 'SELECT * FROM ELEMENT WHERE CODE = ' + QuotedStr(dato));

  NiceGrid1.Rows[ARow].NodeIndex := idx;
  NiceGrid1.CellsT['cCode', ARow] := zqElem.FieldByName('CODE').Text;
  NiceGrid1.CellsT['cDescription', ARow] := zqElem.FieldByName('TITLE').Text;
  NiceGrid1.CellsT['cUnit', ARow] := zqElem.FieldByName('UNIT_ID').Text;
  NiceGrid1.CellsT['cUnitPrice', ARow] := zqElem.FieldByName('PURCHASE_PRICE').Text;
  NiceGrid1.CellsT['cType', ARow] := zqElem.FieldByName('TYPE').Text;

  i := 0;
  if (NiceGrid1.CellsT['cType', ARow] = 'UO') then
  begin
    zqElemCom := TZQuery.Create(self);
    zqElemCom.Connection := MainWindow.zcMainConnection;

    sqlEXEC(zqElemCom, 'SELECT * FROM ELEMENTCOMPOSITION WHERE CODE = ' +
      QuotedStr(zqElem.FieldByName('CODE').Text));
    df := 0;
    while not zqElemCom.EOF do
    begin
      Application.ProcessMessages;
      Inc(i);
      NiceGrid1.InsertRow(ARow + i);
      df := InsertarItem(zqElemCom.FieldByName('ELEMENT_CODE').Text, idx + 1, ARow + i);
      NiceGrid1.CellsT['cUnitAmount', ARow + i] := zqElemCom.FieldByName('ELEMENT_AMOUNT').Text;
      i := i + df;
      zqElemCom.Next;
    end;
  end;

  case NiceGrid1.CellsT['cType', ARow] of
    'UO': NiceGrid1.Rows[ARow].ImageIndex := 0;
    'MA': NiceGrid1.Rows[ARow].ImageIndex := 1;
    'MO': NiceGrid1.Rows[ARow].ImageIndex := 2;
    'HE': NiceGrid1.Rows[ARow].ImageIndex := 3;
    'DI': NiceGrid1.Rows[ARow].ImageIndex := 4;
  end;
  Result := i;
end;

procedure TSaleDocuments.BorrarItem(ARow: integer);
var
  row, Ind: integer;
begin

  row := ARow + 1;
  Ind := NiceGrid1.Rows[ARow].NodeIndex;

  if NiceGrid1.CellsT['cType', ARow] = 'UO' then
  begin
    while True do
    begin
      if row >= NiceGrid1.RowCount then
        break;
      if Ind >= NiceGrid1.Rows[row].NodeIndex then
        break;

      NiceGrid1.DeleteRow(row);
    end;
  end;
  NiceGrid1.DeleteRow(ARow);
  // Recalcular precio total
  if (Ind > 0) then
    CalPrecioElemento(ARow - 1);
  CalPrecioTotal();
end;

procedure TSaleDocuments.bClientEditClick(Sender: TObject);
begin
  // Abrir el cliente
  TClient.Create(Application, edCID.Text);
end;

procedure TSaleDocuments.bCloseClick(Sender: TObject);
begin
  inherited;
end;

procedure TSaleDocuments.bPrintClick(Sender: TObject);
begin
  MainWindow.bMenuClick(MainWindow.bMenu);
  MainWindow.MenuButtonsClick(MainWindow.bMenuPrint);

  MainWindow.frame.frReport1.Dataset := frDBDataSet1;
  MainWindow.frame.SetDocsToPrint(DocCode);
end;

procedure TSaleDocuments.bSaveClick(Sender: TObject);
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

      NiceGrid1.Cells[0, i] := NiceGrid1.Cells[0, i];
      zqDocVentaData.FieldByName('NODEINDEX').Text := NiceGrid1.CellsT['cIndex', i];
      zqDocVentaData.FieldByName('ELEMENT_CODE').Text := NiceGrid1.CellsT['cCode', i];
      zqDocVentaData.FieldByName('ELEMENT_TITLE').Text := NiceGrid1.CellsT['cDescription', i];
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

  case (zqDocVenta.State) of
    dsEdit,
    dsInsert: zqDocVenta.Post;
  end;

  ButtonSaveEnabled := False;
  Screen.Cursor:=crDefault;
end;

procedure TSaleDocuments.dsDocVentaStateChange(Sender: TObject);
begin
  case zqDocVenta.State of
    dsEdit, dsInsert: ButtonSaveEnabled := True;
    else
      ButtonSaveEnabled := False;
  end;
end;

procedure TSaleDocuments.edCIDChange(Sender: TObject);
begin
  if edCID.Text = '' then
    bClientEdit.Enabled := False
  else
    bClientEdit.Enabled := True;
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
end;

procedure TSaleDocuments.edCIDDragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
begin
  Accept := (Source = ClientList.Grid) or Source.ClassNameIs('TControlDragObject');
end;

procedure TSaleDocuments.edCIDLookupClose(Sender: TObject;
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

procedure TSaleDocuments.edDocCodeChange(Sender: TObject);
begin
  if edDocCode.Text <> '' then ToolBarConvertTo.Visible := true;
end;

procedure TSaleDocuments.edTitleKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin

  if Key = VK_RETURN then
	begin
		SelectNext(TWinControl(Sender), True, True);
    Key := 0;
		Exit;
	end;
end;

procedure TSaleDocuments.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited FormClose(Sender, CloseAction);

  zqDocVenta.Cancel;
  zqDocVentaData.Cancel;

end;

procedure TSaleDocuments.FormCreate(Sender: TObject);
var
  ARow: integer;
  i: integer;
  pvptotal: double;
  pcomtotal: double;
  ZQ: TZQuery;
begin

  ManualDock(MainWindow.TabDockCenter);

  zqClient.Open;
  //zqProjects.Open;
  FNeedSave := false;
  bSave.Enabled := false;
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
    sqlEXEC(zqDocVentaData, 'SELECT * FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE = ' +
      QuotedStr(DocCode));

    NiceGrid1.RowCount := 0;
    while not zqDocVentaData.EOF do
    begin
      ARow := zqDocVentaData.FieldByName('ID').AsInteger - 1;
      NiceGrid1.RowCount := NiceGrid1.RowCount + 1;

      NiceGrid1.CellsT['cIndex', ARow] := zqDocVentaData.FieldByName('NODEINDEX').Text;
      NiceGrid1.CellsT['cCode', ARow] := zqDocVentaData.FieldByName('ELEMENT_CODE').Text;
      NiceGrid1.CellsT['cDescription', ARow] := zqDocVentaData.FieldByName('ELEMENT_TITLE').Text;
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

    if NiceGrid1.RowCount = 0 then NiceGrid1.RowCount := 10
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
            //pcomtotal := ToFloat(NiceGrid1.CellsT['cTotalPrice', i]);
            pvptotal := StrToFloatDef(NiceGrid1.CellsT['pvptotal', i], 0);
          end;
        end;
      end;
    end;
    FNeedSave := false;
    bSave.Enabled := false;
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
      for i := 4 to ZQ.FieldCount - 2 do
      begin
        {$IFDEF DEBUG}
        dgSetLine(IntToStr(i){ + ': ' + zqDocVenta.Fields.FieldByNumber(i).Name});
        {$ENDIF}
        zqDocVenta.Fields.FieldByNumber(i).Value := ZQ.Fields.FieldByNumber(i).Value;
        //zqDocVenta.Fields.FieldByNumber(i).AsVariant := ZQ.Fields.FieldByNumber(i).AsVariant;
      end;

      sqlEXEC(ZQ, 'SELECT * FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE = ' + QuotedStr(DocCode));

      NiceGrid1.RowCount := 0;
      ARow := 0;
      while not ZQ.EOF do
      begin
        //if (ZQ.FieldByName('ELEMENT_TYPE').Text = 'UO')  or (ZQ.FieldByName('ELEMENT_TYPE').Text = 'TI') then
        begin
          NiceGrid1.RowCount := NiceGrid1.RowCount + 1;

          NiceGrid1.CellsT['cIndex', ARow] := ZQ.FieldByName('NODEINDEX').Text;
          NiceGrid1.CellsT['cCode', ARow] := ZQ.FieldByName('ELEMENT_CODE').Text;
          NiceGrid1.CellsT['cDescription', ARow] := ZQ.FieldByName('ELEMENT_TITLE').Text;
          NiceGrid1.CellsT['cUnitAmount', ARow] := ZQ.FieldByName('ELEMENT_UNIT_AMOUNT').Text;
          NiceGrid1.CellsT['cTotalAmount', ARow] := ZQ.FieldByName('ELEMENT_TOTAL_AMOUNT').Text;
          NiceGrid1.CellsT['cUnit', ARow] := ZQ.FieldByName('ELEMENT_UNIT').Text;
          NiceGrid1.CellsT['cUnitPrice', ARow] := ZQ.FieldByName('ELEMENT_PRICE').Text;
          NiceGrid1.CellsT['cBenefit', ARow] := ZQ.FieldByName('BENEFIT').Text;
          NiceGrid1.CellsT['cDiscount', ARow] := ZQ.FieldByName('DISCOUNT').Text;
          NiceGrid1.CellsT['cType', ARow] := ZQ.FieldByName('ELEMENT_TYPE').Text;
          NiceGrid1.Rows[ARow].NodeIndex := ZQ.FieldByName('ELEMENT_INDEX').AsInteger;

          case NiceGrid1.CellsT['cType', ARow] of
            'UO': NiceGrid1.Rows[ARow].ImageIndex := 0;
            'MA': NiceGrid1.Rows[ARow].ImageIndex := 1;
            'MO': NiceGrid1.Rows[ARow].ImageIndex := 2;
            'HE': NiceGrid1.Rows[ARow].ImageIndex := 3;
            'DI': NiceGrid1.Rows[ARow].ImageIndex := 4;
          end;

          if NiceGrid1.CellsT['cType', ARow] = 'ST' then
            CalSubTotal(ARow);

          inc(aRow);
        end;

        ZQ.Next;
      end;
      for i := 0 to NiceGrid1.RowCount - 1 do
      begin
        if NiceGrid1.Rows[i].NodeIndex = 0 then
        begin
          CalPrecioElemento(i);
          if NiceGrid1.CellsT['cTotalPVP', i] <> '' then
          begin
            //pcomtotal := StrToFloatDef(NiceGrid1.CellsT['cTotalPrice', i], 0);
            pvptotal := StrToFloatDef(NiceGrid1.CellsT['cTotalPVP', i], 0);
          end;
        end;
      end;
      eTCompra.Text := FloatToStr(pvptotal);
      FNeedSave := true;
    end
    else NiceGrid1.RowCount := 40;

    zqDocVenta.FieldByName('TYPE').Text := TP;
    zqDocVenta.FieldByName('CREATEDAT').AsDateTime := Date();
    zqDocVenta.FieldByName('DELIVERY_DATE').AsDateTime := Date();
    zqDocVenta.FieldByName('VALIDTO').AsDateTime := Date();
    edState.ItemIndex := 1;

    DocCode := 'Nuevo';
    bSave.Enabled := true;
  end;

  Caption := Caption + DocCode;
  pcAll.PageIndex := 1;

  //TNumericField(zqDocVenta.FieldByName('COST')).DisplayFormat := '#,##0.00';
  //TNumericField(zqDocVenta.FieldByName('PRICE')).DisplayFormat := '#,##0.00';
end;

procedure TSaleDocuments.FormShow(Sender: TObject);
begin
  inherited;
end;

procedure TSaleDocuments.InsertarLinea(Sender: TObject);
begin
  NiceGrid1.InsertRow(NiceGrid1.Row);
  NiceGrid1.Rows[NiceGrid1.Row].NodeIndex :=
    NiceGrid1.Rows[NiceGrid1.Row + 1].NodeIndex;
end;

procedure TSaleDocuments.BorrarLinea(Sender: TObject);
begin
  BorrarItem(NiceGrid1.Row);
end;

procedure TSaleDocuments.miConverTo(Sender: TObject);
var
  form: TSaleDocuments;
begin
  form := TSaleDocuments.Create(Application, DocCode, TMenuItem(Sender).MenuIndex, doCopy);
  form.Show;
  form.SetFocus;
end;

procedure TSaleDocuments.miEditElementClick(Sender: TObject);
var
  form: TElement;
begin

  if StringReplace(NiceGrid1.CellsT['cCode', NiceGrid1.Row], ' ', '', [rfReplaceAll]) = '' then exit;
  form := TElement.Create(Application, NiceGrid1.CellsT['cCode', NiceGrid1.Row],
          0, doEdit);
  form.Show;
end;

procedure TSaleDocuments.miInsertSutTotalClick(Sender: TObject);
begin
  NiceGrid1.CellsT['cType', NiceGrid1.Row] := 'ST';
  NiceGrid1.CellsT['cDescription', NiceGrid1.Row] := 'SubTotal';
  NiceGrid1.Rows[NiceGrid1.Row].NodeIndex := 0;

  CalSubTotal(NiceGrid1.Row);
  NiceGrid1.Invalidate;
end;

procedure TSaleDocuments.miShowAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to NiceGrid1.RowCount - 1 do
  begin
    if NiceGrid1.Rows[i].NodeIndex > 0 then
      NiceGrid1.Rows[i].Visible := True;
  end;
end;

procedure TSaleDocuments.miHideAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to NiceGrid1.RowCount - 1 do
  begin
    if NiceGrid1.Rows[i].NodeIndex > 0 then
      NiceGrid1.Rows[i].Visible := False;
  end;
end;

procedure TSaleDocuments.miShowCompositionClick(Sender: TObject);
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

procedure TSaleDocuments.miInsertPackClick(Sender: TObject);
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

procedure TSaleDocuments.miHideCompositionClick(Sender: TObject);
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

procedure TSaleDocuments.NiceGrid1AfterDrawTextCell(Sender: TObject;
  ACanvas: TCanvas; ACol, ARow: integer; Rc: TRect);
begin

  if NiceGrid1.CellsT['cType', ARow] = 'ST' then
  begin
    ACanvas.Pen.Color := clBlue;
    ACanvas.MoveTo(Rc.Left, Rc.Top + 1);
    ACanvas.LineTo(Rc.Right, Rc.Top + 1);
  end;

end;

procedure TSaleDocuments.NiceGrid1CellChange(Sender: TObject; ACol,
  ARow: integer; var Str: string);

  procedure UpdateResources(aTask:TInterval; val: double);
  var
    i: Integer;
  begin
  end;

var
  tmp: double;
begin

  if Assigned(NiceGrid1.Rows[ARow].ExternalObject) then
  begin
    case ACol of
      0:;
      2:
        begin
          TInterval(NiceGrid1.Rows[ARow].ExternalObject).Task := NiceGrid1.Cells[ACol, ARow];
        end;
      4:
        begin
          TInterval(NiceGrid1.Rows[ARow].ExternalObject).Task := NiceGrid1.Cells[ACol, ARow];
        end;
    end;
  end;
end;

procedure TSaleDocuments.NiceGrid1CellExit(Sender: TObject; ACol, ARow: integer);
var
  //X: Integer;
  Y: integer;
begin
  if (ACol = -1) or (ARow = -1) then Exit;
  if ARow >= NiceGrid1.RowCount then Exit;

  if (CellText <> NiceGrid1.Cells[ACol, ARow]) then
  begin
    //X := ACol;
    Y := ARow;
    case ACol of
      2:
      begin
        if (NiceGrid1.CellsT['cType', ARow] = '') and
           (NiceGrid1.CellsT['cDescription', ARow] <> '') then
            NiceGrid1.CellsT['cType', ARow] := 'TI'
        else
        if (NiceGrid1.CellsT['cType', ARow] = 'TI') and
           (NiceGrid1.CellsT['cDescription', ARow] = '')  then
            NiceGrid1.CellsT['cType', ARow] := '';
      end;
			3:
        if NiceGrid1.Rows[ARow].NodeIndex = 0 then
          NiceGrid1.CellsT['cTotalAmount', ARow] := NiceGrid1.CellsT['cUnitAmount', ARow];

      8, 9:
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
    CalPrecioElemento(ARow);
    CalPrecioTotal();
    FNeedSave := true;

    if Assigned(NiceGrid1.Rows[ARow].ExternalObject) then
    begin
      case ACol of
        0:;
        2:
          begin
            TInterval(NiceGrid1.Rows[ARow].ExternalObject).Task := NiceGrid1.Cells[ACol, ARow];
          end;
        3, 4:
          begin
            TInterval(NiceGrid1.Rows[ARow].ExternalObject).Task := NiceGrid1.Cells[ACol, ARow];
          end;
      end;
    end;

  end;
end;

procedure TSaleDocuments.NiceGrid1ColRowChanged(Sender: TObject; ACol, ARow: integer);
begin

  if (ACol = -1) or (ARow = -1) then Exit;
  CellText := NiceGrid1.Cells[ACol, ARow];

  if NiceGrid1.CellsT['cType', ARow] = 'ST' then
  begin
    NiceGrid1.Columns.Items[ACol].ReadOnly := True;
    Exit;
  end;

  NiceGrid1.Columns.Items[ACol].ReadOnly := False;

  case ACol of
    0: if (NiceGrid1.Rows[ARow].NodeIndex > 0) or (NiceGrid1.CellsT['cType', ARow] = '') then
        NiceGrid1.Columns.Items[ACol].ReadOnly := True;
    1:
    begin
      //zqElemento.Open;
      //NiceGrid1.Edit.DataSource := dsElemento;
      //NiceGrid1.Edit.ShowGridTitleRow := true;
    end;

    4: NiceGrid1.Columns.Items[ACol].ReadOnly := true;

    5:
    begin
      //NiceGrid1.Edit.DataSource := dsUnidad;
      //NiceGrid1.Edit.ShowGridTitleRow := false;
    end;
  end;

end;

procedure TSaleDocuments.NiceGrid1DragDrop(Sender, Source: TObject; X, Y: integer);
var
  offset, CCol, CRow: integer;
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
  else
    From := TDBGrid(Source);

  for i := 0 to From.SelectedRows.Count - 1 do
  begin
    From.DataSource.DataSet.GotoBookmark(From.SelectedRows.Items[i]);
    if CRow < (NiceGrid1.RowCount - 1) then
      offset := offset + 1 + InsertarItem(From.DataSource.DataSet.FieldByName('CODE').Text, NiceGrid1.Rows[CRow + 1 + offset].NodeIndex, CRow + offset)
    else
      offset := offset + 1 + InsertarItem(from.DataSource.DataSet.FieldByName('CODE').Text, NiceGrid1.Rows[CRow + offset].NodeIndex, CRow + offset);
  end;

  NiceGrid1.Row := CRow;
  NiceGrid1.Col := 0;
  NiceGrid1.SetFocus;

  if not FNeedSave then
    FNeedSave := True;

end;

procedure TSaleDocuments.NiceGrid1DragOver(Sender, Source: TObject;
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

procedure TSaleDocuments.NiceGrid1DrawCell(Sender: TObject; ACanvas: TCanvas;
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

procedure TSaleDocuments.NiceGrid1KeyDown(Sender: TObject; var Key: word;
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

procedure TSaleDocuments.pcAllChange(Sender: TObject);

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
end;
end.
