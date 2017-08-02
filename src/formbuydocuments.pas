unit formBuyDocuments;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, DBZVDateTimePicker, NiceGrid,
  NiceLookUpComboBox, BCPanel, BCButton, ZDataset, Forms, formWorkForm,
  Controls, Graphics, Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, ComCtrls,
  Menus, DBGrids, Utiles;

type

  { TBuyDocuments }

  TBuyDocuments = class(TWorkForm)
    BCPanel2: TBCPanel;
    bDeleteLine: TBCButton;
    bInsertLine: TBCButton;
    DBMemo1: TDBMemo;
    dpCreateDate: TDBZVDateTimePicker;
    dpValidate: TLabel;
    dpValidDate: TDBZVDateTimePicker;
    dsProveedor: TDataSource;
    dsDocCompra: TDataSource;
    dsDocCompraData: TDataSource;
    dsProject: TDataSource;
    edCID1: TNiceLookUpComboBox;
    edDocCode: TDBEdit;
    edDocCode1: TDBEdit;
    ePVID: TNiceLookUpComboBox;
    ePVName: TDBEdit;
    ePVName1: TDBEdit;
    eTCompra: TDBEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label18: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    lProveedor: TLabel;
    miInsertLine: TMenuItem;
    miDeleteLine: TMenuItem;
    NiceGrid1: TNiceGrid;
    Panel1: TPanel;
    pcAll: TPageControl;
    pmLines: TPopupMenu;
    ScrollBox1: TScrollBox;
    SeparatorBevel1: TBevel;
    Splitter1: TSplitter;
    tsGeneral: TTabSheet;
    tsDocument: TTabSheet;
    tsSummary: TTabSheet;
    zqBuyDocumentCODE: TStringField;
    zqBuyDocumentCREATEDAT: TDateField;
    zqBuyDocumentCREATEDBY: TStringField;
    zqBuyDocumentID: TLargeintField;
    zqBuyDocumentPRICE: TFloatField;
    zqBuyDocumentPROJECT_CODE: TStringField;
    zqBuyDocumentPROJECT_NAME: TStringField;
    zqBuyDocumentREFERENCE: TStringField;
    zqBuyDocumentSUPPLIER_CODE: TStringField;
    zqBuyDocumentSUPPLIER_NAME: TStringField;
    zqBuyDocumentTAX: TLargeintField;
    zqBuyDocumentTYPE: TStringField;
    zqBuyDocumentVALIDTO: TDateField;
    zqDocCompraData: TZQuery;
		zqBuyDocument: TZQuery;
    zqDocCompraDataBUYDOCUMENT_CODE: TStringField;
    zqDocCompraDataCREATEDAT: TDateField;
    zqDocCompraDataCREATEDBY: TStringField;
    zqDocCompraDataDELIVERY_DATE: TDateField;
    zqDocCompraDataELEMENT_AMOUNT: TFloatField;
    zqDocCompraDataELEMENT_CODE: TStringField;
    zqDocCompraDataELEMENT_DISCOUNT: TFloatField;
    zqDocCompraDataELEMENT_MANUFACTURER: TStringField;
    zqDocCompraDataELEMENT_NAME: TStringField;
    zqDocCompraDataELEMENT_PURCHASE_PRICE: TFloatField;
    zqDocCompraDataELEMENT_REAL_PRICE: TFloatField;
    zqDocCompraDataELEMENT_SUPPLIER_CODE: TStringField;
    zqDocCompraDataELEMENT_UNIT: TStringField;
    zqDocCompraDataID: TLargeintField;
    zqProject: TZQuery;
    zqProjectCODE: TStringField;
    zqProjectCUSTOMER_CODE: TStringField;
    zqProjectCUSTOMER_NAME: TStringField;
    zqProjectTITLE: TStringField;
    zqProveedor: TZQuery;
    zqProveedorCODE: TStringField;
    zqProveedorID_NUMBER: TStringField;
    zqProveedorNAME: TStringField;
    procedure bSaveClick(Sender: TObject);override;
    procedure dsDocCompraDataChange(Sender: TObject; Field: TField);
    procedure edDocCodeKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ePVIDEnter(Sender: TObject);
    procedure ePVIDExit(Sender: TObject);
    procedure ePVIDLookupClose(Sender: TObject; LookupResult: TStringList);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure miDeleteLineClick(Sender: TObject);
    procedure miInsertLineClick(Sender: TObject);
    procedure NiceGrid1CellExit(Sender: TObject; ACol, ARow: integer);
    procedure NiceGrid1DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure NiceGrid1DragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure Splitter1CanOffset(Sender: TObject; var NewOffset: Integer;
      var Accept: Boolean);
  private
    { private declarations }
    TP: ansistring;
    FProvID: ansistring;

    procedure UpdateElement(ARow: integer);
  public
    { public declarations }
    {constructor Create(TheOwner: TComponent; Code: ansistring = '';
      DocType: integer = 0; Operation: TDocumentOperations = doNew);}
    function CalcPrecioElemento(ARow: integer): double;
    function InsertarItem(Dato: ansistring; ARow: integer):integer;
  end;

var
  BuyDocuments: TBuyDocuments;

implementation

uses
  FormMainWindow,
  formElementsList,
  formSupplier,
  Math;

{$R *.lfm}

{ TBuyDocuments }

procedure TBuyDocuments.UpdateElement(ARow: integer);
var
  ZQ: TZQuery;
  cont, i: integer;
begin
  if ePVID.Text = '' then Exit;
  if NiceGrid1.Cells[1, ARow] = '' then Exit;

  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;

  sqlEXEC(ZQ, 'SELECT * FROM ELEMENT WHERE CODE=' + NiceGrid1.Cells[1, ARow]);

  if ZQ.RecordCount = 0 then
    Exit;

  cont := 10;
  for i := 0 to 9 do
  begin
    if ZQ.Fields.FieldByNumber(18 + 8 * i).Text = '' then
    begin
      if (cont > i) then
        cont := i;
      Continue;
    end;

    if ZQ.Fields.FieldByNumber(18 + 8 * i).Text = ePVID.Text then
    begin
      ZQ.Edit;
      ZQ.Fields.FieldByNumber(20 + 8 * i).Text := NiceGrid1.Cells[0, ARow];
      ZQ.Fields.FieldByNumber(21 + 8 * i).Text := NiceGrid1.Cells[5, ARow];
      ZQ.Fields.FieldByNumber(22 + 8 * i).Text := NiceGrid1.Cells[6, ARow];
      ZQ.Fields.FieldByNumber(23 + 8 * i).Text := NiceGrid1.Cells[7, ARow];
      ZQ.Fields.FieldByNumber(25 + 8 * i).AsDateTime := Date();
      ZQ.Post;
      Exit;
    end;
  end;
  // si no se encuentra se guarda en el primer registro libre:
  ZQ.Edit;
  ZQ.Fields.FieldByNumber(18 + 8 * cont).Text := ePVID.Text;
  ZQ.Fields.FieldByNumber(19 + 8 * cont).Text := ePVName.Text;
  ZQ.Fields.FieldByNumber(20 + 8 * cont).Text := NiceGrid1.Cells[0, ARow];
  ZQ.Fields.FieldByNumber(21 + 8 * cont).Text := NiceGrid1.Cells[5, ARow];
  ZQ.Fields.FieldByNumber(22 + 8 * cont).Text := NiceGrid1.Cells[6, ARow];
  ZQ.Fields.FieldByNumber(23 + 8 * cont).Text := NiceGrid1.Cells[7, ARow];
  ZQ.Fields.FieldByNumber(25 + 8 * cont).AsDateTime := Date();
  ZQ.Post;
end;

function TBuyDocuments.InsertarItem(Dato: ansistring; ARow: integer):integer;
var
  zqElem, zqElemCom: TZQuery;
  tmp: ansistring;
  ProDef, i, j, df: integer;
  find: boolean;
begin
  zqElem := TZQuery.Create(self);
  zqElem.Connection := MainWindow.zcMainConnection;

  sqlEXEC(zqElem, 'SELECT * FROM ELEMENT WHERE CODE=' + QuotedStr(dato));

  //if zqElem.FieldByName('TYPE').Text = 'UO' then Exit;

  tmp := zqElem.FieldByName('CODE').Text;

  if zqElem.FieldByName('SUPPLIER_DEFAULT').Text <> '' then
  begin
    ProDef := zqElem.FieldByName('SUPPLIER_DEFAULT').AsInteger;
    NiceGrid1.Cells[0, ARow] := zqElem.FieldByName('SUPPLIER_DEFAULT' +  IntToStr(ProDef)).Text;
  end;

  NiceGrid1.CellsT['cCode', ARow] := zqElem.FieldByName('CODE').Text;
  NiceGrid1.CellsT['cDescription', ARow] := zqElem.FieldByName('TITLE').Text;
  NiceGrid1.CellsT['cManufacturer', ARow] := zqElem.FieldByName('MANUFACTURER').Text;
  NiceGrid1.CellsT['cUnit', ARow] := zqElem.FieldByName('UNIT_ID').Text;
  NiceGrid1.CellsT['cPVP', ARow] := zqElem.FieldByName('REAL_PRICE').Text;
  NiceGrid1.CellsT['cDismount', ARow] := zqElem.FieldByName('DISCOUNT').Text;
  NiceGrid1.CellsT['cPrice', ARow] := zqElem.FieldByName('PURCHASE_PRICE').Text;

  i := 0;
  if (zqElem.FieldByName('TYPE').Text = 'UO') then
  begin
    zqElemCom := TZQuery.Create(self);
    zqElemCom.Connection := MainWindow.zcMainConnection;

    sqlEXEC(zqElemCom, 'SELECT * FROM ELEMENTCOMPOSITION WHERE CODE = ' +
      QuotedStr(zqElem.FieldByName('CODE').Text));
    df := 0;
    while not zqElemCom.EOF do
    begin
      //UBTIT0G22X3C
      Application.ProcessMessages;
      Inc(i);
      NiceGrid1.InsertRow(ARow + i);
      df := InsertarItem(zqElemCom.FieldByName('ELEMENT_CODE').Text, {idx + 1,} ARow + i);
      NiceGrid1.CellsT['cAmount', ARow + i] := zqElemCom.FieldByName('ELEMENT_AMOUNT').Text;
      i := i + df;
      zqElemCom.Next;
    end;
  end;
  Result := i;

  // Buscar y poner los precios del proveedor
  find := False;
  if ePVID.Text <> '' then
  begin
    for j := 0 to 9 do
    begin
      if zqElem.Fields.FieldByNumber(22 + 8 * j).Text = ePVID.Text then
      begin
        NiceGrid1.CellsT['cSuID', ARow] := zqElem.Fields.FieldByNumber(26 + 8 * j).Text;
        NiceGrid1.CellsT['cPVP', ARow] := zqElem.Fields.FieldByNumber(27 + 8 * j).Text;
        NiceGrid1.CellsT['cDismount', ARow] := zqElem.Fields.FieldByNumber(28 + 8 * j).Text;
        NiceGrid1.CellsT['cPrice', ARow] := zqElem.Fields.FieldByNumber(29 + 8 * j).Text;
        find := True;
        break;
      end;
    end;
  end;

  if not find then
  begin
    NiceGrid1.CellsT['cPVP', ARow] := zqElem.FieldByName('REAL_PRICE').Text;
    NiceGrid1.CellsT['cDismount', ARow] := zqElem.FieldByName('DISCOUNT').Text;
    NiceGrid1.CellsT['cPrice', ARow] := zqElem.FieldByName('PURCHASE_PRICE').Text;
  end;
end;

function TBuyDocuments.CalcPrecioElemento(ARow: integer): double;
var
  can, pvp, des, pre, pt: double;
  i: integer;
begin
  pt := 0;

  can := StrToFloatDef(NiceGrid1.CellsT['cAmount', ARow], 0);
  pvp := StrToFloatDef(NiceGrid1.CellsT['cPVP', ARow], 0);
  des := StrToFloatDef(NiceGrid1.CellsT['cDismount', ARow], 0);
  pre := pvp * (1 - des / 100);
  NiceGrid1.CellsT['cPrice', ARow] := FormatFloat('0.0000', pre);
  NiceGrid1.CellsT['cTotalPrice', ARow] := FormatFloat('0.0000', can * pre);

  for i := 0 to NiceGrid1.RowCount - 1 do
  begin
    if NiceGrid1.Cells[9, i] <> '' then
      pt := pt + StrToFloatDef(NiceGrid1.CellsT['cTotalPrice', i], 0);
  end;

  eTCompra.Text := FloatToStr(pt);
  Result := can * pre;
end;

procedure TBuyDocuments.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TBuyDocuments.dsDocCompraDataChange(Sender: TObject; Field: TField);
begin
  case zqBuyDocument.State of
    dsEdit, dsInsert: ButtonSaveEnabled := True;
    else
      ButtonSaveEnabled := False;
  end;
end;

procedure TBuyDocuments.bSaveClick(Sender: TObject);
var
  ZQ: TZQuery;
  num: integer;
  NumRow: integer;
  i: integer;
begin
  if ePVID.Text = '' then
  begin
    ePVID.SetFocus;
    Exit;
  end;

  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;
  if edDocCode.Text = '' then // Salvar el documento
  begin
    sqlEXEC(ZQ, 'SELECT ID FROM BUYDOCUMENT ORDER BY ID DESC LIMIT 1');
    num := ZQ.FieldByName('ID').AsInteger;
    DocCode := FormatFloat(TP + '00000000', num + 1);
    zqBuyDocument.FieldByName('CODE').Text := DocCode;
    Caption := Caption + DocCode;
  end;

{   sqlEXEC(ZQ, 'SELECT COUNT(1) AS "NumRow" FROM DataDocCompra WHERE cddcID=' +
              QuotedStr(DocCode));
   NumRow := ZQ.Fields.FieldByName('NumRow').AsInteger;}

  sqlEXEC(zqDocCompraData, 'SELECT * FROM BUYDOCUMENTDATA WHERE BUYDOCUMENT_CODE = ' +
    QuotedStr(DocCode));
  NumRow := zqDocCompraData.RecordCount;

  for i := 0 to Max(NiceGrid1.RowCount, NumRow) - 1 do
  begin
    if (i >= NiceGrid1.RowCount) then  // Borrar registros
    begin
      sqlEXEC(zqDocCompraData, 'DELETE FROM BUYDOCUMENTDATA WHERE ID >='
        + IntToStr(i + 1) + ' AND BUYDOCUMENT_CODE = ' +
        QuotedStr(DocCode));
      Break;
    end;

    if i < NumRow then         // Actualizar registro
    begin
      sqlEXEC(zqDocCompraData, 'SELECT * FROM BUYDOCUMENTDATA WHERE ID='
        + IntToStr(i + 1) + ' AND BUYDOCUMENT_CODE=' +
        QuotedStr(DocCode));
      zqDocCompraData.Edit;
    end
    else               //  Añadir registro
    begin
      zqDocCompraData.Append;
      zqDocCompraData.FieldByName('ID').AsInteger := i + 1;
      zqDocCompraData.FieldByName('BUYDOCUMENT_CODE').Text := DocCode;
    end;

    zqDocCompraData.FieldByName('ELEMENT_SUPPLIER_CODE').Text := NiceGrid1.Cells[0, i];
    zqDocCompraData.FieldByName('ELEMENT_CODE').Text := NiceGrid1.Cells[1, i];
    zqDocCompraData.FieldByName('ELEMENT_NAME').Text := NiceGrid1.Cells[2, i];
    zqDocCompraData.FieldByName('ELEMENT_MANUFACTURER').Text := NiceGrid1.Cells[3, i];
    zqDocCompraData.FieldByName('ELEMENT_AMOUNT').Text := NiceGrid1.Cells[4, i];
    zqDocCompraData.FieldByName('ELEMENT_UNIT').Text := NiceGrid1.Cells[5, i];
    zqDocCompraData.FieldByName('ELEMENT_REAL_PRICE').Text := NiceGrid1.Cells[6, i];
    zqDocCompraData.FieldByName('ELEMENT_DISCOUNT').Text := NiceGrid1.Cells[7, i];
    zqDocCompraData.FieldByName('ELEMENT_PURCHASE_PRICE').Text := NiceGrid1.Cells[8, i];
    zqDocCompraData.FieldByName('DELIVERY_DATE').Text := NiceGrid1.Cells[10, i];

    zqDocCompraData.Post;
  end;

  case zqBuyDocument.State of
    dsEdit, dsInsert:
      zqBuyDocument.Post;
  end;
  ButtonSaveEnabled := False;
end;

procedure TBuyDocuments.edDocCodeKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    SelectNext(TWinControl(Sender), True, True);
  end;
end;

procedure TBuyDocuments.ePVIDEnter(Sender: TObject);
begin
  FProvID := ePVID.Text;
end;

procedure TBuyDocuments.ePVIDExit(Sender: TObject);
var
  ZQ: TZQuery;
  i, j: integer;
  found : boolean;
begin
  // Actualizar precios si cambia
  // primero se comprueba si se cambia de proveedor para no hacer calculos imnecesarios
  if (ePVID.Text = '') or (ePVID.Text = FProvID) then
    Exit;

  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;
  for i := 0 to NiceGrid1.RowCount - 1 do
  begin
    if NiceGrid1.Rows[i].IsEmpty then
      continue;

    sqlEXEC(ZQ, 'SELECT * FROM ELEMENT WHERE CODE = ' +
      QuotedStr(NiceGrid1.Cells[1, i]));

    found := false;
    for j := 0 to 9 do
    begin
      if ZQ.Fields.FieldByNumber(18 + 8 * j).Text = ePVID.Text then
      begin
        NiceGrid1.Cells[0, i] := FormatFloat('0.00',ZQ.Fields.FieldByNumber(20 + 8 * j).AsFloat);
        NiceGrid1.Cells[6, i] := FormatFloat('0.00',ZQ.Fields.FieldByNumber(21 + 8 * j).AsFloat);
        NiceGrid1.Cells[7, i] := FormatFloat('0.00',ZQ.Fields.FieldByNumber(22 + 8 * j).AsFloat);
        NiceGrid1.Cells[8, i] := FormatFloat('0.00',ZQ.Fields.FieldByNumber(23 + 8 * j).AsFloat);
        found := true;
        Break;
      end;
    end;

    if not found then
    begin
      NiceGrid1.Cells[0, i] := '';
      NiceGrid1.Cells[6, i] := FormatFloat('0.00',ZQ.FieldByName('REAL_PRICE').AsFloat);
      NiceGrid1.Cells[7, i] := FormatFloat('0.00',ZQ.FieldByName('DISCOUNT').AsFloat);
      NiceGrid1.Cells[8, i] := FormatFloat('0.00',ZQ.FieldByName('PURCHASE_PRICE').AsFloat);
		end;

    // finalmente calcular precios
    CalcPrecioElemento(i);
  end;
end;

procedure TBuyDocuments.ePVIDLookupClose(Sender: TObject;
  LookupResult: TStringList);
begin
  zqBuyDocument.FieldByName('SUPPLIER_NAME').Text := zqProveedor.FieldByName('NAME').Text;
end;

procedure TBuyDocuments.FormCreate(Sender: TObject);
var
  ARow: integer;
  pcomtotal: double;
  i: integer;
  ZQ: TZQuery;
  pvptotal: double;
begin
  pcAll.TabIndex := 1;

  zqProveedor.Open;
  zqProject.Open;

  case DocType of
    0:
    begin
      Caption := 'Presupuesto: ';
      TP := 'BP';
    end;
    1:
    begin
      Caption := 'Pedido: ';
      TP := 'OR';
    end;
    2:
    begin
      Caption := 'Albarán: ';
      TP := 'WB';
    end;
    3:
    begin
      Caption := 'Orden de Devolución: ';
      TP := 'RO';
    end;
    4:
    begin
      Caption := 'Abono: ';
      TP := 'PY';
    end;
    5:
    begin
      Caption := 'Factura: ';
      TP := 'BB';
    end;
  end;

  if DocOperation = doEdit then  // Abrir presupuesto existente
  begin
    sqlEXEC(zqBuyDocument, 'SELECT * FROM BUYDOCUMENT WHERE CODE = ' +
            QuotedStr(DocCode));
    sqlEXEC(zqDocCompraData, 'SELECT * FROM BUYDOCUMENTDATA WHERE BUYDOCUMENT_CODE = ' +
            QuotedStr(DocCode));
    NiceGrid1.RowCount := 0;
    while not zqDocCompraData.EOF do
    begin
      ARow := NiceGrid1.RowCount;
      NiceGrid1.RowCount := NiceGrid1.RowCount + 1;


      NiceGrid1.CellsT['cSuID', ARow] := zqDocCompraData.FieldByName('ELEMENT_SUPPLIER_CODE').Text;
      NiceGrid1.CellsT['cCode', ARow] := zqDocCompraData.FieldByName('ELEMENT_CODE').Text;
      NiceGrid1.CellsT['cDescription', ARow] := zqDocCompraData.FieldByName('ELEMENT_NAME').Text;
      NiceGrid1.CellsT['cAmount', ARow] := zqDocCompraData.FieldByName('ELEMENT_AMOUNT').Text;
      NiceGrid1.CellsT['cUnit', ARow] := zqDocCompraData.FieldByName('ELEMENT_UNIT').Text;
      NiceGrid1.CellsT['cPVP', ARow] := zqDocCompraData.FieldByName('ELEMENT_REAL_PRICE').Text;
      NiceGrid1.CellsT['cDismount', ARow] := zqDocCompraData.FieldByName('ELEMENT_DISCOUNT').Text;
      NiceGrid1.CellsT['cPrice', ARow] := zqDocCompraData.FieldByName('ELEMENT_PURCHASE_PRICE').Text;
      NiceGrid1.CellsT['cTotalPrice', ARow] :=
        FloatToStr(zqDocCompraData.FieldByName('ELEMENT_AMOUNT').AsFloat *
                   zqDocCompraData.FieldByName('ELEMENT_PURCHASE_PRICE').AsFloat);
      NiceGrid1.CellsT['cDate', ARow] := zqDocCompraData.FieldByName('DELIVERY_DATE').Text;
      zqDocCompraData.Next;
    end;
    //***********************************************************************
    pcomtotal := 0;

    for i := 0 to NiceGrid1.RowCount - 1 do
    begin
      if NiceGrid1.CellsT['cTotalPrice', i] <> '' then
        pcomtotal := pcomtotal + StrToFloatDef(NiceGrid1.CellsT['cTotalPrice', i], 0);
    end;
    eTCompra.Text := FloatToStr(pcomtotal);
    //eTVenta.Text := FloatToStr(pcomtotal * 1.21);
    //***********************************************************************
    ButtonSaveEnabled := False;
  end
  else    // Presupuesto nuevo
  begin
    sqlEXEC(zqBuyDocument, 'SELECT * FROM BUYDOCUMENT WHERE ID = -1');
    zqBuyDocument.Append;
    if DocOperation = doCopy then    // Duplicar
    begin
      ZQ := TZQuery.Create(self);
      ZQ.Connection := MainWindow.zcMainConnection;

      sqlEXEC(ZQ, 'SELECT * FROM BUYDOCUMENT WHERE CODE = ' + QuotedStr(DocCode));
      for i := 4 to ZQ.FieldCount - 1 do
        zqBuyDocument.Fields.FieldByNumber(i).AsVariant :=
          ZQ.Fields.FieldByNumber(i).AsVariant;

      sqlEXEC(ZQ, 'SELECT * FROM BUYDOCUMENTDATA WHERE BUYDOCUMENT_CODE = ' + QuotedStr(DocCode));

      while not zqDocCompraData.EOF do
      begin
        ARow := zqDocCompraData.FieldByName('ID').AsInteger;
        NiceGrid1.RowCount := ARow;
        Inc(ARow);
        NiceGrid1.Cells[0, ARow] := zqDocCompraData.FieldByName('ELEMENT_SUPPLIER_CODE').Text;
        NiceGrid1.Cells[1, ARow] := zqDocCompraData.FieldByName('ELEMENT_CODE').Text;
        NiceGrid1.Cells[2, ARow] := zqDocCompraData.FieldByName('ELEMENT_NAME').Text;
        NiceGrid1.Cells[3, ARow] := zqDocCompraData.FieldByName('ELEMENT_AMOUNT').Text;
        NiceGrid1.Cells[4, ARow] := zqDocCompraData.FieldByName('ELEMENT_UNIT').Text;
        NiceGrid1.Cells[5, ARow] := zqDocCompraData.FieldByName('ELEMENT_REAL_PRICE').Text;
        NiceGrid1.Cells[6, ARow] := zqDocCompraData.FieldByName('ELEMENT_DISCOUNT').Text;
        NiceGrid1.Cells[7, ARow] := zqDocCompraData.FieldByName('ELEMENT_PURCHASE_PRICE').Text;
        NiceGrid1.Cells[8, ARow] :=
          FloatToStr(zqDocCompraData.FieldByName('ELEMENT_AMOUNT').AsFloat *
                     zqDocCompraData.FieldByName('ELEMENT_PURCHASE_PRICE').AsFloat);
        NiceGrid1.Cells[9, ARow] := zqDocCompraData.FieldByName('DELIVERY_DATE').Text;
        zqDocCompraData.Next;
      end;
      //***********************************************************************
      pcomtotal := 0;
      pvptotal := 0;

      for i := 0 to NiceGrid1.RowCount - 1 do
      begin
        if NiceGrid1.Cells[8, i] <> '' then
        begin
          pcomtotal := StrToFloatDef(NiceGrid1.Cells[7, i], 0);
          pvptotal := StrToFloatDef(NiceGrid1.Cells[10, i], 0);
        end;
      end;
      eTCompra.Text := FloatToStr(pcomtotal);
      //***********************************************************************
    end
    else
      NiceGrid1.RowCount := 40;

    zqBuyDocument.FieldByName('TYPE').Text := TP;
    DocCode := 'Nuevo';
    zqBuyDocument.FieldByName('CREATEDAT').AsDateTime := Date();
    zqBuyDocument.FieldByName('VALIDTO').AsDateTime := Date();
  end;

  Caption := Caption + DocCode;
  ManualDock(MainWindow.TabDockCenter);
end;

procedure TBuyDocuments.miDeleteLineClick(Sender: TObject);
begin
  NiceGrid1.DeleteRow(NiceGrid1.Row);
end;

procedure TBuyDocuments.miInsertLineClick(Sender: TObject);
begin
  NiceGrid1.InsertRow(NiceGrid1.Row);
end;

procedure TBuyDocuments.NiceGrid1CellExit(Sender: TObject; ACol, ARow: integer);
var
  can, pvp, des, pre, pt: double;
  i: integer;
begin
  pt := 0;
  case ACol of
    4, 6, 7, 8:
    begin
      can := StrToFloatDef(NiceGrid1.Cells[4, ARow], 0);
      pvp := StrToFloatDef(NiceGrid1.Cells[6, ARow], 0);
      des := StrToFloatDef(NiceGrid1.Cells[7, ARow], 0);
      pre := pvp * (1 - des / 100);
      NiceGrid1.Cells[8, ARow] := FormatFloat('#.00', pre);
      NiceGrid1.Cells[9, ARow] := FormatFloat('#.00', can * pre);

      for i := 0 to NiceGrid1.RowCount - 1 do
      begin
        if NiceGrid1.Cells[9, i] <> '' then
          pt := pt + StrToFloatDef(NiceGrid1.Cells[9, i], 0);
      end;
      eTCompra.Text := FloatToStr(pt);
    end;
  end;
end;

procedure TBuyDocuments.NiceGrid1DragDrop(Sender, Source: TObject; X, Y: integer);
var
  CCol, CRow, i: integer;
begin
  NiceGrid1.MouseToCell(X, Y, CCol, CRow);

  for i := 0 to TDBGrid(Source).SelectedRows.Count - 1 do
  begin
    TDBGrid(Source).DataSource.DataSet.GotoBookmark(
      TDBGrid(Source).SelectedRows.Items[i]);
    if CRow < (NiceGrid1.RowCount - 1) then
      InsertarItem(TDBGrid(Source).DataSource.DataSet.FieldByName('CODE').Text,
        CRow + i)
    else
      InsertarItem(TDBGrid(Source).DataSource.DataSet.FieldByName('CODE').Text,
        CRow + i);
  end;

  NiceGrid1.Row := CRow;
  NiceGrid1.Col := 0;
  NiceGrid1.SetFocus;
  if not ButtonSaveEnabled then
    ButtonSaveEnabled := True;
end;

procedure TBuyDocuments.NiceGrid1DragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
var
  CCol, CRow: integer;
begin
  NiceGrid1.MouseToCell(X, Y, CCol, CRow);

  Accept := (Sender = Source) or (Source = ElementsList.Grid);

  if Accept then
  begin
    NiceGrid1.Row := CRow;
    NiceGrid1.SelectArea := Rect(0, CRow, NiceGrid1.ColCount - 1, CRow);
  end;
end;

procedure TBuyDocuments.Splitter1CanOffset(Sender: TObject;
  var NewOffset: Integer; var Accept: Boolean);
begin

end;

end.
