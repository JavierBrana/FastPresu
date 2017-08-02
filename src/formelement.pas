unit formElement;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, NiceGrid, BCButton, BCPanel,
  JDBLabeledFloatEdit, ZDataset,
  Forms,formWorkForm,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons,
  ComCtrls, DBGrids, DBCtrls, ExtDlgs, Menus,
  u_items_tree, Utiles;

type

  { TElement }

  TElement = class(TWorkForm)
    bClearImage: TBCButton;
    bLoadImage: TBCButton;
    bAddLine: TBCButton;
    bInsertLine: TBCButton;
    bDeleteLine: TBCButton;
    cbCopyCode: TCheckBox;
    DBCheckBox1: TDBCheckBox;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    dsElemComp: TDataSource;
    dsFamily: TDataSource;
    dsUnity: TDataSource;
    DBMemo1: TDBMemo;
    dsElement: TDataSource;
    DBEdit1: TDBEdit;
    edTotal: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBImage: TDBImage;
    edDes: TJDBLabeledFloatEdit;
    edFamily: TDBLookupComboBox;
    edIVA: TJDBLabeledFloatEdit;
    edPCompra: TJDBLabeledFloatEdit;
    edPVP: TJDBLabeledFloatEdit;
    edUnity: TDBLookupComboBox;
    eID: TDBEdit;
    eNom: TDBEdit;
    eType: TComboBox;
    gProveedor: TNiceGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    gComposition: TNiceGrid;
    Label9: TLabel;
    edPTotal: TLabeledEdit;
    miDeleteLine: TMenuItem;
    miAddLine: TMenuItem;
    miInsertLine: TMenuItem;
    Panel1: TBCPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pcAll: TPageControl;
    pmComposition: TPopupMenu;
    ScrollBox1: TScrollBox;
    SeparatorBevel1: TBevel;
    Shape1: TShape;
    Splitter1: TSplitter;
    ToolBarComposite: TBCPanel;
    tsCounts: TTabSheet;
    tsComposition: TTabSheet;
    tsSupplier: TTabSheet;
    tsGeneral: TTabSheet;
    zqElemCompCODE: TStringField;
    zqElemCompCREATEDAT: TDateField;
    zqElemCompCREATEDBY: TStringField;
    zqElemCompELEMENT_AMOUNT: TFloatField;
    zqElemCompELEMENT_CODE: TStringField;
    zqElemCompNORDER: TLargeintField;
    zqElement: TZQuery;
    zqElemComp: TZQuery;
    zqElementBARCODE: TStringField;
    zqElementBENEFIT: TFloatField;
    zqElementCODE: TStringField;
    zqElementCREATEDAT: TDateField;
    zqElementCREATEDBY: TStringField;
    zqElementDATE_UPDATE: TDateField;
    zqElementDESCRIPTION: TBlobField;
    zqElementDISCOUNT: TFloatField;
    zqElementFAMILY_ID: TStringField;
    zqElementGAMMA: TStringField;
    zqElementHEIGHT: TFloatField;
    zqElementID: TLargeintField;
    zqElementIMAGE: TBlobField;
    zqElementLENGHT: TFloatField;
    zqElementMANUFACTURER: TStringField;
    zqElementPURCHASE_PRICE: TFloatField;
    zqElementREAL_PRICE: TFloatField;
    zqElementSTATE: TBooleanField;
    zqElementSUPPLIER_DATE_UPDATE_0: TDateField;
    zqElementSUPPLIER_DATE_UPDATE_1: TDateField;
    zqElementSUPPLIER_DATE_UPDATE_2: TDateField;
    zqElementSUPPLIER_DATE_UPDATE_3: TDateField;
    zqElementSUPPLIER_DATE_UPDATE_4: TDateField;
    zqElementSUPPLIER_DATE_UPDATE_5: TDateField;
    zqElementSUPPLIER_DATE_UPDATE_6: TDateField;
    zqElementSUPPLIER_DATE_UPDATE_7: TDateField;
    zqElementSUPPLIER_DATE_UPDATE_8: TDateField;
    zqElementSUPPLIER_DATE_UPDATE_9: TDateField;
    zqElementSUPPLIER_DEFAULT: TLargeintField;
    zqElementSUPPLIER_DISCOUNT_0: TFloatField;
    zqElementSUPPLIER_DISCOUNT_1: TFloatField;
    zqElementSUPPLIER_DISCOUNT_2: TFloatField;
    zqElementSUPPLIER_DISCOUNT_3: TFloatField;
    zqElementSUPPLIER_DISCOUNT_4: TFloatField;
    zqElementSUPPLIER_DISCOUNT_5: TFloatField;
    zqElementSUPPLIER_DISCOUNT_6: TFloatField;
    zqElementSUPPLIER_DISCOUNT_7: TFloatField;
    zqElementSUPPLIER_DISCOUNT_8: TFloatField;
    zqElementSUPPLIER_DISCOUNT_9: TFloatField;
    zqElementSUPPLIER_ID_0: TStringField;
    zqElementSUPPLIER_ID_1: TStringField;
    zqElementSUPPLIER_ID_2: TStringField;
    zqElementSUPPLIER_ID_3: TStringField;
    zqElementSUPPLIER_ID_4: TStringField;
    zqElementSUPPLIER_ID_5: TStringField;
    zqElementSUPPLIER_ID_6: TStringField;
    zqElementSUPPLIER_ID_7: TStringField;
    zqElementSUPPLIER_ID_8: TStringField;
    zqElementSUPPLIER_ID_9: TStringField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_0: TFloatField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_1: TFloatField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_2: TFloatField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_3: TFloatField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_4: TFloatField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_5: TFloatField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_6: TFloatField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_7: TFloatField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_8: TFloatField;
    zqElementSUPPLIER_MINIMUM_AMOUNT_9: TFloatField;
    zqElementSUPPLIER_NAME_0: TStringField;
    zqElementSUPPLIER_NAME_1: TStringField;
    zqElementSUPPLIER_NAME_2: TStringField;
    zqElementSUPPLIER_NAME_3: TStringField;
    zqElementSUPPLIER_NAME_4: TStringField;
    zqElementSUPPLIER_NAME_5: TStringField;
    zqElementSUPPLIER_NAME_6: TStringField;
    zqElementSUPPLIER_NAME_7: TStringField;
    zqElementSUPPLIER_NAME_8: TStringField;
    zqElementSUPPLIER_NAME_9: TStringField;
    zqElementSUPPLIER_PURCHASE_PRICE_0: TFloatField;
    zqElementSUPPLIER_PURCHASE_PRICE_1: TFloatField;
    zqElementSUPPLIER_PURCHASE_PRICE_2: TFloatField;
    zqElementSUPPLIER_PURCHASE_PRICE_3: TFloatField;
    zqElementSUPPLIER_PURCHASE_PRICE_4: TFloatField;
    zqElementSUPPLIER_PURCHASE_PRICE_5: TFloatField;
    zqElementSUPPLIER_PURCHASE_PRICE_6: TFloatField;
    zqElementSUPPLIER_PURCHASE_PRICE_7: TFloatField;
    zqElementSUPPLIER_PURCHASE_PRICE_8: TFloatField;
    zqElementSUPPLIER_PURCHASE_PRICE_9: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_0: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_1: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_2: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_3: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_4: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_5: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_6: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_7: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_8: TFloatField;
    zqElementSUPPLIER_REAL_PRICE_9: TFloatField;
    zqElementSUPPLIER_REFERENCE_0: TStringField;
    zqElementSUPPLIER_REFERENCE_1: TStringField;
    zqElementSUPPLIER_REFERENCE_2: TStringField;
    zqElementSUPPLIER_REFERENCE_3: TStringField;
    zqElementSUPPLIER_REFERENCE_4: TStringField;
    zqElementSUPPLIER_REFERENCE_5: TStringField;
    zqElementSUPPLIER_REFERENCE_6: TStringField;
    zqElementSUPPLIER_REFERENCE_7: TStringField;
    zqElementSUPPLIER_REFERENCE_8: TStringField;
    zqElementSUPPLIER_REFERENCE_9: TStringField;
    zqElementTAX: TFloatField;
    zqElementTITLE: TStringField;
    zqElementTYPE: TStringField;
    zqElementUNIT_ID: TStringField;
    zqElementWEIGHT: TFloatField;
    zqElementWIDTH: TFloatField;
    ztFamily: TZTable;
    ztUnity: TZTable;
    procedure bClearImageClick(Sender: TObject);
    procedure bLoadImageClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject); override;
    procedure cbCopyCodeChange(Sender: TObject);
    procedure DBMemo1Change(Sender: TObject);
    procedure dsElementStateChange(Sender: TObject);
    procedure edPVPExit(Sender: TObject);
    procedure eIDChange(Sender: TObject);
    procedure eIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eTypeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure gCompositionBeforeShowEdit(Sender: TObject; ARec: TRect;
      var aCanShow: boolean);
    procedure gCompositionCellChange(Sender: TObject; ACol, ARow: integer;
      var Str: string);
    procedure gCompositionCellExit(Sender: TObject; ACol, ARow: integer);
    procedure gCompositionColRowChanged(Sender: TObject; ACol, ARow: integer);
    procedure gCompositionDeleteRow(Sender: TObject; ARow: integer);
    procedure gCompositionDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure gCompositionDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure gCompositionDrawCell(Sender: TObject; ACanvas: TCanvas;
      ACol, ARow: integer; Rc: TRect; var Handled: boolean);
    procedure gCompositionGutterClick(Sender: TObject; ARow: integer;
      Button: TMouseButton; Shift: TShiftState);
    procedure gCompositionInsertRow(Sender: TObject; ARow: integer);
    procedure gProveedorCellChange(Sender: TObject; ACol, ARow: integer;
      var Str: string);
    procedure gProveedorCellExit(Sender: TObject; ACol, ARow: integer);
    procedure gProveedorClick(Sender: TObject);
    procedure gProveedorColRowChanged(Sender: TObject; ACol, ARow: integer);
    procedure gProveedorDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure gProveedorDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure miDeleteLineClick(Sender: TObject);
    procedure miAddLineClick(Sender: TObject);
    procedure miInsertLineClick(Sender: TObject);
    procedure pcAllChange(Sender: TObject);
  private
    { private declarations }
    FCompositionNeedsSave: boolean;
    FCompositionCellText: string;
    FItem: TItem;


    function InsertarItem(Dato: ansistring; Idx, ARow: integer; aParent: TObject): integer;
    procedure DeleteItem(ARow: integer);
  public
    { public declarations }
  end;

var
  Element: TElement;

implementation

uses

  formSupplierstList,
  formMainWindow,
  formElementsList,
  Math, LCLType;

{$R *.lfm}

{ TElement }

procedure TElement.bLoadImageClick(Sender: TObject);
begin
  if MainWindow.OpenPictureDialog.Execute then
    DBImage.Picture.LoadFromFile(MainWindow.OpenPictureDialog.FileName);
end;

procedure TElement.bSaveClick(Sender: TObject);
var
  ZQ: TZQuery;

  procedure SaveComposition;
  var
    i, idx: integer;
    NumRow: integer;
  begin
    sqlEXEC(ZQ, 'SELECT COUNT(1) AS "NumRow" FROM ELEMENTCOMPOSITION WHERE CODE = '
                + QuotedStr(DocCode));
    NumRow := ZQ.Fields.FieldByName('NumRow').AsInteger;
    idx := 0;

    zqElemComp.Open;
    for i := 0 to Max(gComposition.RowCount, NumRow) - 1 do
    begin
      if gComposition.RowIsEmpty(i) then Continue;
      if gComposition.Rows[i].NodeIndex > 0 then Continue;

      if idx < NumRow then   // Update registros
      begin
        sqlEXEC(zqElemComp, 'SELECT * FROM ELEMENTCOMPOSITION WHERE NORDER = ' +
          IntToStr(idx) + ' AND CODE = ' + QuotedStr(DocCode));
        zqElemComp.Edit;
      end
      else                   // Añadir registros
      begin
        zqElemComp.Insert;
        zqElemComp.FieldByName('NORDER').AsInteger := idx;
      end;

      zqElemComp.FieldByName('CODE').Text := eID.Text;
      zqElemComp.FieldByName('ELEMENT_CODE').Text := gComposition.CellsT['cCode', i];
      zqElemComp.FieldByName('ELEMENT_AMOUNT').Text := gComposition.CellsT['cUnitAmount', i];
      zqElemComp.Post();
      inc(idx);
    end;
    if idx <= NumRow then    // Borrar registros
    begin
      sqlEXEC(zqElemComp, 'DELETE FROM ELEMENTCOMPOSITION WHERE NORDER >= ' +
        IntToStr(idx) + ' AND CODE = ' + QuotedStr(DocCode));
    end;
    zqElemComp.Close();
  end;

var
  num: integer;
  i, j: integer;

begin
  case eType.ItemIndex of
    0: zqElement.FieldByName('TYPE').Text := 'UO';
    1: zqElement.FieldByName('TYPE').Text := 'MA';
    2: zqElement.FieldByName('TYPE').Text := 'MO';
    3: zqElement.FieldByName('TYPE').Text := 'DI';
    4: zqElement.FieldByName('TYPE').Text := 'HE';
    else
    begin
      eType.SetFocus;
      Exit;
    end;
  end;

  if eNom.Text = '' then
  begin
    eNom.SetFocus();
    Exit;
  end;

  if eID.Text = '' then
  begin
    ZQ := TZQuery.Create(self);
    ZQ.Connection := MainWindow.zcMainConnection;
    sqlEXEC(ZQ, 'SELECT ID FROM ELEMENT ORDER BY ID DESC LIMIT 1');

    num := ZQ.FieldByName('ID').AsInteger;
    DocCode := FormatFloat(zqElement.FieldByName('TYPE').Text + '00000000', num + 1);
    zqElement.FieldByName('CODE').Text := DocCode;
  end;

  zqElement.FieldByName('CODE').Text := DocCode;
  zqElement.FieldByName('STATE').AsBoolean := False;

  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;

  case eType.ItemIndex of
    0:  // Composición si es UO:
    begin
      if FCompositionNeedsSave then
        SaveComposition;
    end
    else // Proveedores:
    begin
      for i := 0 to gProveedor.RowCount - 1 do
      begin
        //for j := 1 to gProveedor.ColCount do
        //  zqElement.Fields.FieldByNumber(17 + i * 8 + j).Text := gProveedor.Cells[j, i];
        if gProveedor.CellsT['cCode', i] = '1' then
          zqElement.FieldByName('SUPPLIER_DEFAULT').AsInteger := i;
      end;
    end;
  end;

  case (zqElement.State) of
    dsEdit, dsInsert: zqElement.Post;
  end;

  ZQ.Free;
  Caption := 'Elemento: ' + DocCode;
  bSave.Enabled := False;
end;

procedure TElement.bClearImageClick(Sender: TObject);
begin
  DBImage.Picture.Clear;
end;

procedure TElement.cbCopyCodeChange(Sender: TObject);
begin
  if cbCopyCode.Checked then
  begin
    if dsElement.State <> dsEdit then
      zqElement.Edit;
    zqElement.FieldByName('BARCODE').Text := zqElement.FieldByName('CODE').Text;
  end;
end;

procedure TElement.DBMemo1Change(Sender: TObject);
begin
  if eNom.Text = '' then
    zqElement.FieldByName('TITLE').Text := DBMemo1.Text;
end;

procedure TElement.dsElementStateChange(Sender: TObject);
begin
  { TDataSetState = (dsInactive, dsBrowse, dsEdit, dsInsert, dsSetKey,
    dsCalcFields, dsFilter, dsNewValue, dsOldValue, dsCurValue, dsBlockRead,
    dsInternalCalc, dsOpening);}
  case dsElement.State of
    dsEdit, dsInsert:
    begin
      ButtonSaveEnabled := True;
    end;
    else
    begin
      ButtonSaveEnabled := False;
    end;
  end;
end;

procedure TElement.edPVPExit(Sender: TObject);
var
  PVP, Des, PCom, IVA: double;
begin

  //if zqElement.State < 2 then Exit;

  PVP := StrToFloatDef(edPVP.Text, 0);
  Des := StrToFloatDef(edDes.Text, 0);
  IVA := StrToFloatDef(edIVA.Text, 0);
  PCom := PVP * (1 - Des / 100);

  if zqElement.FieldByName('PURCHASE_PRICE').AsFloat <> PCom then
  begin
    if not (zqElement.State = dsEdit) or not (zqElement.State = dsInsert) then
          zqElement.Edit;
    zqElement.FieldByName('PURCHASE_PRICE').AsFloat := PCom;
  end;
  edPTotal.Text := FloatToStr(PCom * (1 + IVA / 100));
  edPTotal.Text := FormatFloat('#,##0.00', PCom * (1 + IVA / 100));
end;

procedure TElement.eIDChange(Sender: TObject);
begin
  if cbCopyCode.Checked then
    zqElement.FieldByName('BARCODE').Text := zqElement.FieldByName('CODE').Text;
end;

procedure TElement.eIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
	begin
		SelectNext(TWinControl(Sender), True, True);
    Key := 0;
		Exit;
	end;
end;

procedure TElement.eTypeChange(Sender: TObject);
begin
  if (eType.ItemIndex = 0) then
  begin
    gComposition.Enabled := True;
    tsComposition.TabVisible := True;
    gProveedor.Enabled := False;
    tsSupplier.TabVisible := False;
    edPVP.Enabled := False;
    edDes.Enabled := False;
  end
  else
  begin
    gComposition.Enabled := False;
    tsComposition.TabVisible := False;
    gProveedor.Enabled := True;
    tsSupplier.TabVisible := True;
    edPVP.Enabled := True;
    edDes.Enabled := True;
  end;
end;

procedure TElement.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  inherited FormClose(Sender, CloseAction);

  {if ButtonSaveEnabled then
    case MessageDlg('El documento ha sido modificado.'+ #10 + #13 +
                    '¿Quieres guardar los cambios?',
        mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrCancel: Abort;
      mrYes: bSaveClick(Sender);
    end;

  //zqElement.Free;
  //ztFamily.Free;
  //ztUnity.Free;

  if not Floating then
  begin
    Visible := False;
    ManualFloat(Rect(0, 0, Width, Height));
  end;}
end;

procedure TElement.FormCreate(Sender: TObject);

  procedure OpenDocFormDB(aZQ: TZQuery);
  var
    aRow: integer;
  begin
    aZQ.First;
    gComposition.RowCount := 0;
    while not aZQ.EOF do
    begin
      aRow := gComposition.RowCount;
      gComposition.RowCount := aRow + 1;
      InsertarItem(aZQ.FieldByName('ELEMENT_CODE').Text, 0, aRow, FItem);
      TItem(FItem.Items[FItem.Items.Count - 1]).UnitAmount := aZQ.FieldByName('ELEMENT_AMOUNT').AsFloat;
      gComposition.CellsT['cUnitAmount', aRow] := aZQ.FieldByName('ELEMENT_AMOUNT').AsString;
      aZQ.Next;
    end;
  end;

var
  ZQ: TZQuery;
  i, j: integer;
begin
  FItem := TItem.Create(gComposition);
  FItem.UnitAmount := 1;

  ztFamily.Active := True;
  ztUnity.Active := True;
  pcAll.TabIndex := 0;

  if DocOperation = doEdit then  // Abrir elemento existente
  begin
    sqlEXEC(zqElement, 'SELECT * FROM ELEMENT WHERE CODE = ' + QuotedStr(DocCode));

    if zqElement.FieldByName('TYPE').Text = 'UO' then
    begin
      sqlEXEC(zqElemComp, 'SELECT * FROM ELEMENTCOMPOSITION WHERE CODE = ' +
        QuotedStr(DocCode));
      eType.ItemIndex := 0;
      OpenDocFormDB(zqElemComp);

      if zqElement.FieldByName('PURCHASE_PRICE').AsFloat <> FItem.TotalPrice then
      begin
        zqElement.Edit;
        zqElement.FieldByName('PURCHASE_PRICE').AsFloat := FItem.TotalPrice;
      end;
    end
    else if zqElement.FieldByName('TYPE').Text = 'MA' then
      eType.ItemIndex := 1
    else if zqElement.FieldByName('TYPE').Text = 'MO' then
      eType.ItemIndex := 2
    else if zqElement.FieldByName('TYPE').Text = 'DI' then
      eType.ItemIndex := 3
    else if zqElement.FieldByName('TYPE').Text = 'HE' then
      eType.ItemIndex := 4;

    if eType.ItemIndex > 0 then
    begin
      for i := 0 to gProveedor.RowCount - 1 do
        for j := 1 to gProveedor.ColCount - 1 do
          gProveedor.Cells[j, i] := zqElement.Fields.FieldByNumber(17 + i * 8 + j).Text;
      if zqElement.FieldByName('SUPPLIER_DEFAULT').Text <> '' then
        gProveedor.CellsT['cCode', zqElement.FieldByName('SUPPLIER_DEFAULT').AsInteger] := '1';
    end;
    edPVPExit(self);

    eType.Enabled := False;
    FCompositionNeedsSave := false;
  end
  else    // Elemento nuevo
  begin
    sqlEXEC(zqElement, 'SELECT * FROM ELEMENT WHERE ID = "-1"');
    zqElement.Append;
    FCompositionNeedsSave := false;
    bSave.Enabled := false;

    if DocOperation = doCopy then// Copiamos el elemento
    begin
      ZQ := TZQuery.Create(self);
      ZQ.Connection := MainWindow.zcMainConnection;
      sqlEXEC(ZQ, 'SELECT * FROM Element WHERE CODE = ' + QuotedStr(DocCode));

      for i := 3 to zqElement.FieldCount - 1 do
        zqElement.Fields.FieldByNumber(i).AsVariant :=
          ZQ.Fields.FieldByNumber(i).AsVariant;

      if ZQ.FieldByName('TYPE').Text = 'UO' then
      begin
        eType.ItemIndex := 0;
        sqlEXEC(ZQ, 'SELECT * FROM ELEMENTCOMPOSITION WHERE CODE = ' + QuotedStr(DocCode));
        OpenDocFormDB(ZQ);

        zqElement.FieldByName('PURCHASE_PRICE').AsFloat := FItem.TotalPrice;
        FCompositionNeedsSave := true;
      end;
      eType.Enabled := False;
    end
    else gComposition.RowCount := 5;

    zqElement.FieldByName('DATE_UPDATE').AsDateTime := Date();
    zqElement.FieldByName('STATE').AsBoolean := False;
    eType.ItemIndex := DocType;
    bSave.Enabled := True;
    DocCode := 'Nuevo';
  end;

  eTypeChange(Sender);
  Caption := Caption + ': ' + DocCode;


  ManualDock(MainWindow.TabDockCenter);
  Visible := True;
end;

procedure TElement.gCompositionBeforeShowEdit(Sender: TObject; ARec: TRect;
  var aCanShow: boolean);
var
  ARow: Integer;
begin
  ARow := gComposition.Row;

  case gComposition.Columns[gComposition.Col].Name of
    'cCode', 'cUnitAmount':
    begin
      if gComposition.Rows[ARow].NodeIndex = 0 then
        aCanShow := true
      else
        aCanShow := false;
    end;
    else aCanShow := false;
  end;
end;

procedure TElement.gCompositionCellChange(Sender: TObject;
  ACol, ARow: integer; var Str: string);
begin
  bSave.Enabled := True;
  FCompositionNeedsSave := True;
end;

procedure TElement.gCompositionCellExit(Sender: TObject; ACol, ARow: integer);
begin
  if (aCol = -1) or (aRow = -1) then Exit;
  if (aRow >= gComposition.RowCount) or (aCol >= gComposition.ColCount) then Exit;

  if FCompositionCellText <> gComposition.Cells[aCol, aRow] then
    case gComposition.Columns[ACol].Name of
      'cUnitAmount':
      begin
        if assigned(gComposition.Rows[ARow].ExternalObject) then
          TItem(gComposition.Rows[ARow].ExternalObject).UnitAmount :=
            StrToFloatDef(gComposition.CellsT['cUnitAmount', ARow], 0);

        //CalPrecioElemento(aRow);

        if not (zqElement.State = dsEdit) or not (zqElement.State = dsInsert) then
          zqElement.Edit;
        zqElement.FieldByName('REAL_PRICE').AsFloat := FItem.TotalPrice;
        zqElement.FieldByName('PURCHASE_PRICE').AsFloat := FItem.TotalPrice;
      end;
    end;
end;

procedure TElement.gCompositionColRowChanged(Sender: TObject; ACol, ARow: integer);
begin
  if (aCol = -1) or (aRow = -1) then Exit;

  FCompositionCellText := gComposition.Cells[aCol, aRow];
end;

procedure TElement.gCompositionDeleteRow(Sender: TObject; ARow: integer);
begin
  bSave.Enabled := True;
  FCompositionNeedsSave := True;
end;

procedure TElement.gCompositionDragDrop(Sender, Source: TObject; X, Y: integer);
var
  CCol, CRow, offset: integer;
  ind, row, i: integer;
begin
  if not gComposition.Enabled then Exit;

  offset := 0;
  gComposition.MouseToCell(X, Y, CCol, CRow);

  if (gComposition.CellsT['Tipo', CRow] = 'UO') then
  begin
    ind := gComposition.Rows[CRow].NodeIndex;
    row := CRow + 1;
    while True do
    begin
      if row >= gComposition.RowCount then
        break;
      if ind >= gComposition.Rows[row].NodeIndex then
        break;

      gComposition.DeleteRow(row);
    end;
  end;

  for i := 0 to TDBGrid(Source).SelectedRows.Count - 1 do
  begin
    TDBGrid(Source).DataSource.DataSet.GotoBookmark(
      TDBGrid(Source).SelectedRows.Items[i]);
    if (CRow < (gComposition.RowCount - 1)) then
      offset := offset + 1 + InsertarItem(
        TDBGrid(Source).DataSource.DataSet.FieldByName('CODE').Text,
        gComposition.Rows[CRow + 1 + offset].NodeIndex,
        CRow + offset, FItem)
    else
      offset := offset + 1 + InsertarItem(
        TDBGrid(Source).DataSource.DataSet.FieldByName('CODE').Text,
        gComposition.Rows[CRow + offset].NodeIndex, CRow + offset, FItem);
  end;

  gComposition.Row := CRow;
  gComposition.Col := 0;
  gComposition.SetFocus;
end;

procedure TElement.gCompositionDragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
var
  CCol, CRow: integer;
begin
  Accept := False;
  if not gComposition.Enabled then Exit;
  if (gComposition.RowCount = 0) or (gComposition.ColCount = 0) then Exit;

  gComposition.MouseToCell(X, Y, CCol, CRow);
  gComposition.Row := CRow;
  gComposition.SelectArea := Rect(0, CRow, gComposition.ColCount - 1, CRow);

  if (gComposition.Rows[CRow].NodeIndex > 0) then Exit;

  Accept := (Source = ElementsList.Grid) and gComposition.Enabled and
            (TDBGrid(Source).DataSource.DataSet.FieldByName('CODE').Text <> DocCode);

end;

procedure TElement.gCompositionDrawCell(Sender: TObject; ACanvas: TCanvas;
  ACol, ARow: integer; Rc: TRect; var Handled: boolean);
begin
  if (gComposition.RowCount < 0) or (gComposition.ColCount < 0) then Exit;

  if gComposition.Rows[ARow].NodeIndex > 0 then
  begin
    ACanvas.Font.Color := clGray;
  end
  else
  begin
    ACanvas.Font.Color := clBlack;
  end;

  if (gComposition.CellsT['cTotalPrice', ARow] = 'UO') then
    ACanvas.Font.Style := [fsBold]
  else
    ACanvas.Font.Style := [];
end;

procedure TElement.gCompositionGutterClick(Sender: TObject; ARow: integer;
  Button: TMouseButton; Shift: TShiftState);
begin
  if Assigned(gComposition.Rows[ARow].ExternalObject) then
    TItem(gComposition.Rows[ARow].ExternalObject).ToggleChildrenVisibility;
end;

procedure TElement.gCompositionInsertRow(Sender: TObject; ARow: integer);
begin
  bSave.Enabled := True;
  FCompositionNeedsSave := True;
end;

procedure TElement.gProveedorCellChange(Sender: TObject; ACol, ARow: integer;
  var Str: string);
var
  i: integer;
begin
  case ACol of
    0:
    begin
      for i := 0 to gProveedor.RowCount - 1 do
        if ARow <> i then
          gProveedor.CellsT['cUsed', i] := '0';

      if not (zqElement.State = dsInsert) or not (zqElement.State = dsEdit) then zqElement.Edit;
      if gProveedor.CellsT['cTotalPrice', ARow] = '' then
      begin
        gProveedor.CellsT['cUnit', ARow] := zqElement.FieldByName('REAL_PRICE').Text;
        gProveedor.CellsT['cUnitPrice', ARow] := zqElement.FieldByName('DISCOUNT').Text;
        gProveedor.CellsT['cTotalPrice', ARow] := zqElement.FieldByName('PURCHASE_PRICE').Text;
      end
      else
      begin
        zqElement.FieldByName('REAL_PRICE').Text := gProveedor.CellsT['cUnit', ARow];
        zqElement.FieldByName('DISCOUNT').Text := gProveedor.CellsT['cUnitPrice', ARow];
        zqElement.FieldByName('PURCHASE_PRICE').Text := gProveedor.CellsT['cTotalPrice', ARow];
      end;
    end;
    6: gProveedor.Cells[8, ARow] := DateToStr(Date());
  end;

  if (zqElement.State <> dsInsert) then zqElement.Edit;
  bSave.Enabled := true;
  FCompositionNeedsSave := True;

end;

procedure TElement.gProveedorCellExit(Sender: TObject; ACol, ARow: integer);
var
  pvp, des, pre: double;
begin

  case ACol of
    4, 5:
    begin
      pvp := StrToFloatDef(gProveedor.CellsT['cUnit', ARow], 0);
      des := StrToFloatDef(gProveedor.CellsT['cUnitPrice', ARow], 0);
      pre := pvp * (1 - des / 100);
      gProveedor.CellsT['cTotalPrice', ARow] := FloatToStr(pre);
    end;
  end;
end;

procedure TElement.gProveedorClick(Sender: TObject);
var
  s: string;
begin
  if gProveedor.Col = 0 then
  begin
    s := '';
    gProveedorCellChange(Sender, gProveedor.Col, gProveedor.Row, s);
  end;
end;

procedure TElement.gProveedorColRowChanged(Sender: TObject; ACol, ARow: integer);
begin

  case gProveedor.Columns[aCol].Name of
    'cCode':
    begin
      gProveedor.Columns[0].ReadOnly := false;
      gProveedor.Edit.ShowButton := True
    end
    else
    begin
      if gProveedor.CellsT['cCode', ARow] = '' then
        gProveedor.Columns[0].ReadOnly := true
      else gProveedor.Columns[0].ReadOnly := false;
    end;
  end;

end;

procedure TElement.gProveedorDragDrop(Sender, Source: TObject; X, Y: integer);
var
  offset, CCol, CRow: integer;
  i: integer;
begin
  offset := 0;
  //gProveedor.MouseToCell(X, Y, CCol, i);

  i := 10;
  CRow := i;
  while i > 0 do
  begin
    if gProveedor.CellsT['cCode', i - 1] = TDBGrid(Source).DataSource.DataSet.FieldByName('CODE').Text then
    begin
      gProveedor.Row := i;
      exit;
    end;
    if gProveedor.CellsT['cCode', i - 1] = '' then
      CRow := i - 1;
    dec(i);
  end;

  gProveedor.CellsT['cCode', CRow] := TDBGrid(Source).DataSource.DataSet.FieldByName('CODE').Text;
  gProveedor.CellsT['cName', CRow] := TDBGrid(Source).DataSource.DataSet.FieldByName('NAME').Text;

  gProveedor.Row := CRow;
  gProveedor.Col := 0;
  gProveedor.SetFocus;

  if not bSave.Enabled then
    zqElement.Edit;
end;

procedure TElement.gProveedorDragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
var
  CCol, CRow: integer;
begin
  gProveedor.MouseToCell(X, Y, CCol, CRow);


  if eType.ItemIndex = 0 then
  begin
    Accept := false;
    Exit;
  end;

  Accept := (Source = SupplierstList.Grid) or gProveedor.Enabled;

  if Accept then
  begin
    gProveedor.Row := CRow;
    gProveedor.SelectArea := Rect(0, CRow, gProveedor.ColCount - 1, CRow);
  end;
end;

procedure TElement.miDeleteLineClick(Sender: TObject);
begin
  if gComposition.Row > -1 then
    DeleteItem(gComposition.Row);

end;

procedure TElement.miAddLineClick(Sender: TObject);
begin
  gComposition.RowCount := gComposition.RowCount + 1;
end;

procedure TElement.miInsertLineClick(Sender: TObject);
begin
  if (gComposition.Row > -1) then
    if gComposition.Rows[gComposition.Row].NodeIndex = 0 then
      gComposition.InsertRow(gComposition.Row);
end;

procedure TElement.pcAllChange(Sender: TObject);
begin
  case pcAll.PageIndex of
    1:   ToolBarComposite.Visible := true
    else ToolBarComposite.Visible := false;
  end;
end;

function TElement.InsertarItem(Dato: ansistring; Idx, ARow: integer;
  aParent: TObject): integer;
var
  zqElem, zqElemCom: TZQuery;
  i, df: integer;
  aItem: TItem;
begin
  zqElem := TZQuery.Create(self);
  zqElem.Connection := MainWindow.zcMainConnection;

  sqlEXEC(zqElem, 'SELECT * FROM ELEMENT WHERE CODE = ' + QuotedStr(Dato));
  if zqElem.RecordCount = 0 then
  begin
    Result := -1;
    Exit;
  end;

  if Assigned(gComposition.Rows[ARow].ExternalObject) then
  begin
    aItem := TItem(gComposition.Rows[ARow].ExternalObject);
    aItem.Clear;
  end
  else
    aItem := CreateItem(aParent, gComposition.Rows[ARow]);

  aItem.Code := zqElem.FieldByName('CODE').Text;
  aItem.TypeOfElement := zqElem.FieldByName('TYPE').Text;
  aItem.Title := zqElem.FieldByName('TITLE').Text;
  aItem.UnitOfElement := zqElem.FieldByName('UNIT_ID').AsString;
  aItem.Price := zqElem.FieldByName('PURCHASE_PRICE').AsFloat;


  gComposition.CellsT['cCode', ARow] := zqElem.FieldByName('CODE').Text;
  gComposition.CellsT['cTitle', ARow] := zqElem.FieldByName('TITLE').Text;
  gComposition.CellsT['cUnit', ARow] := zqElem.FieldByName('UNIT_ID').Text;
  gComposition.CellsT['cUnitPrice', ARow] := zqElem.FieldByName('PURCHASE_PRICE').Text;
  gComposition.CellsT['cType', ARow] := zqElem.FieldByName('TYPE').Text;
  gComposition.Rows[ARow].NodeIndex := gComposition.Rows[ARow].NodeIndex - 1;

  i := 0;
  if zqElem.FieldByName('TYPE').Text = 'UO' then
  begin
    zqElemCom := TZQuery.Create(self);
    try
      zqElemCom.Connection := MainWindow.zcMainConnection;
      sqlEXEC(zqElemCom, 'SELECT * FROM ELEMENTCOMPOSITION WHERE CODE = ' +
        QuotedStr(Dato));

      df := 0;
      while not zqElemCom.EOF do
      begin
        //UBTIT0G22X3C
        Application.ProcessMessages;
        Inc(i);
        gComposition.InsertRow(ARow + i);
        df := InsertarItem(zqElemCom.FieldByName('ELEMENT_CODE').Text, idx + 1,
                           ARow + i, aItem);
        TItem(aItem.Items[aItem.Items.Count - 1]).UnitAmount := zqElemCom.FieldByName('ELEMENT_AMOUNT').AsFloat;
        gComposition.CellsT['cUnitAmount', ARow + i] := zqElemCom.FieldByName('ELEMENT_AMOUNT').Text;
        i := i + df;
        zqElemCom.Next;
      end;
    finally
      zqElemCom.Free;
    end;
  end;
  Result := i;
end;

procedure TElement.DeleteItem(ARow: integer);
begin

  if Assigned(gComposition.Rows[ARow].ExternalObject) then
    TItem(gComposition.Rows[ARow].ExternalObject).Free
  else
    gComposition.DeleteRow(ARow);

  zqElement.FieldByName('PURCHASE_PRICE').AsFloat := FItem.TotalPrice;
end;
end.
