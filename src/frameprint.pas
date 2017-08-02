unit framePrint;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil,
  BCButton, BCPanel, BGRAShape,
  PrintersDlgs, ZDataset, NiceDividerBevel,
  Forms, Controls, ExtCtrls, ComCtrls, StdCtrls, Spin,
  Buttons, types, Graphics, Dialogs, ExtDlgs, Grids,
  LR_View, LR_Class, LR_BarC, LR_RRect, LR_Shape, LR_ChBox, LR_E_HTM,
  LR_E_CSV, LR_PGrid, LR_Desgn, LR_DBSet, lr_e_pdf, LR_e_img, LR_e_htmldiv,
  Variants, StrUtils, fpcsvexport;

type

  { TPrintFrame }

  TPrintFrame = class(TFrame)
    BCButton1: TBCButton;
    BCPanel1: TBCPanel;
    BCPanel2: TBCPanel;
    BGRAShape1: TBGRAShape;
    bPrint4: TBitBtn;
    eFromDoc: TEdit;
    eToDoc: TEdit;
    frDBDataSet1: TfrDBDataSet;
    Label3: TLabel;
    Label4: TLabel;
    lPreviewTitle: TLabel;
    lTemplateName1: TLabel;
    lTemplateName2: TLabel;
    lAuthor: TLabel;
    NewTemplateButton: TSpeedButton;
    EditTemplateButton: TSpeedButton;
    NiceDividerBevel3: TNiceDividerBevel;
    NiceDividerBevel6: TNiceDividerBevel;
    Panel5: TPanel;
    SelectTemplateButton: TSpeedButton;
    bPrint: TBitBtn;
    bSaveToDoc: TBitBtn;
    bZoomMinus: TBCButton;
    bPrevPage: TBCButton;
    bNextPage: TBCButton;
    bZoomPlus: TBCButton;
    cbSelectPrinter: TComboBox;
    cbSelectDocType: TComboBox;
    ePages: TLabeledEdit;
    frBarCodeObject1: TfrBarCodeObject;
    frCheckBoxObject1: TfrCheckBoxObject;
    frCSVExport1: TfrCSVExport;
    frDesigner1: TfrDesigner;
    frHtmlDivExport1: TfrHtmlDivExport;
    frImageExport1: TfrImageExport;
    frPreview1: TfrPreview;
    frReport1: TfrReport;
    frRoundRectObject1: TfrRoundRectObject;
    frShapeObject1: TfrShapeObject;
    frTNPDFExport1: TfrTNPDFExport;
    iPreviewTemplate: TImage;
    Icons32x32: TImageList;
    Icon64x64: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    lvTemplatesList: TListView;
    lTemplateName: TLabel;
    lZoom: TLabel;
    SaveDialog1: TSaveDialog;
    SavePictureDialog1: TSavePictureDialog;
    SelectTemplatePage: TPage;
    PrintConfigPage: TPage;
    NiceDividerBevel1: TNiceDividerBevel;
    NiceDividerBevel2: TNiceDividerBevel;
    NiceDividerBevel4: TNiceDividerBevel;
    NiceDividerBevel5: TNiceDividerBevel;
    mbPrintPages: TNotebook;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    seCopiesNumber: TSpinEdit;
    DeleteTemplateButton: TSpeedButton;
    tbZoomValue: TTrackBar;
    ztLazReportTemplates: TZTable;
    procedure BCButton1Click(Sender: TObject);
    procedure bPrintClick(Sender: TObject);
    procedure cbSelectPrinterSelect(Sender: TObject);
    procedure eFromDocChange(Sender: TObject);
    procedure frDesigner1SaveReport(Report: TfrReport; var ReportName: string;
      SaveAs: boolean; var Saved: boolean);
    procedure NewTemplateButtonClick(Sender: TObject);
    procedure EditTemplateButtonClick(Sender: TObject);
    procedure SelectTemplateButtonClick(Sender: TObject);
    procedure bPrevPageClick(Sender: TObject);
    procedure bNextPageClick(Sender: TObject);
    procedure bSaveToDocClick(Sender: TObject);
    procedure bPrint4Click(Sender: TObject);
    procedure bZoomMinusClick(Sender: TObject);
    procedure bZoomPlusClick(Sender: TObject);
    procedure cbSelectPrinterDrawItem(Control: TWinControl; Index: integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure cbSelectDocTypeDrawItem(Control: TWinControl; Index: integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure lvTemplatesListSelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure DeleteTemplateButtonClick(Sender: TObject);
    procedure tbZoomValueChange(Sender: TObject);
  private
    { private declarations }
    DocNumber: integer;
    FZQList: TList;
  public
    { public declarations }
    constructor Create(TheOwner: TComponent); override;
    constructor Create(TheOwner: TComponent; FromDoc, ToDoc: string);

    procedure SetDocsToPrint(FromDoc: string; ToDoc: string = '');
    procedure sqlData(Code: string);
  end;

implementation

uses
  formMainWindow,
  Printers, Math, LCLType, Utiles;

{$R *.lfm}

procedure TPrintFrame.cbSelectPrinterDrawItem(Control: TWinControl;
  Index: integer; ARect: TRect; State: TOwnerDrawState);
begin
{
odSelected, odGrayed, odDisabled, odChecked,
odFocused, odDefault, odHotLight, odInactive, odNoAccel,
odNoFocusRect, odReserved1, odReserved2, odComboBoxEdit,
odPainted  // item already painted
}
  Caption := cbSelectPrinter.Caption + ' - ' + cbSelectPrinter.Items[index];
  with cbSelectPrinter.Canvas do
  begin
    // odSelected, odfocused, odComboBoxEdit
    if (odSelected in State) and not (odfocused in State) then
    begin
      Brush.Color := $C2F1FC;
      Pen.Color := $3695F2;
      RoundRect(ARect, 2, 2);
      InflateRect(ARect, -2, -2);
      GradientFill(ARect, $3695F2, $C2F1FC, gdVertical);
      Brush.Style := bsClear;
      RoundRect(ARect, 2, 2);
      Font.Color := clBlack;
    end
    else if (odSelected in State) and (odfocused in State) then
      //if index = cbSelectPrinter.ItemIndex then
    begin
      Brush.Color := $C2F1FC;
      Pen.Color := $3695F2;
      RoundRect(ARect, 2, 2);
      Font.Color := clSkyBlue;
    end
    else
    begin
      Brush.Color := clWhite;
      Pen.Color := clBlack;
      FillRect(ARect);
      Font.Color := clBlack;
    end;
    TextOut(45, ARect.Top + 2, cbSelectPrinter.Items[Index]);
{    TextOut(45, ARect.Top + 2 + TextHeight(cbSelectPrinter.Items[Index]),
            Printer.PrinterState);                           }
    Icons32x32.Draw(cbSelectPrinter.Canvas, 4, ARect.Top + 2, 0);
  end;
end;

procedure TPrintFrame.cbSelectDocTypeDrawItem(Control: TWinControl;
  Index: integer; ARect: TRect; State: TOwnerDrawState);
var
  sList: TStringList;
begin

  sList := TStringList.Create;
  sList.Clear;
  sList.StrictDelimiter := True;
  sList.Delimiter := '|';
  sList.DelimitedText := cbSelectDocType.Items[Index];

  with cbSelectDocType.Canvas do
  begin
    if (odSelected in State) and not (odfocused in State) then
    begin
      Brush.Color := $C2F1FC;
      Pen.Color := $3695F2;
      RoundRect(ARect, 2, 2);
      InflateRect(ARect, -2, -2);
      GradientFill(ARect, $3695F2, $C2F1FC, gdVertical);
      Brush.Style := bsClear;
      RoundRect(ARect, 2, 2);
    end
    else if (odSelected in State) and (odfocused in State) then
    begin
      Brush.Color := $C2F1FC;
      Pen.Color := $3695F2;
      RoundRect(ARect, 2, 2);
    end
    else
    begin
      Brush.Color := clWhite;
      Pen.Color := clBlack;
      FillRect(ARect);
    end;
    Font.Size := 10;
    Font.Color := clBlack;
    TextOut(50, ARect.Top + 2, sList[0]);
    Font.Size := 8;
    Font.Color := clGray;
    TextOut(50, ARect.Top + 4 + TextHeight(sList[0]), sList[1]);
    Icons32x32.Draw(cbSelectDocType.Canvas, 4, ARect.Top + 2, Index + 1);
  end;
end;

procedure TPrintFrame.lvTemplatesListSelectItem(Sender: TObject; Item: TListItem;
  Selected: boolean);
begin
  lTemplateName.Caption := Item.Caption;
  //Image1.Stretch := true;  // to make it as large as Image1
  //Image1.Proportional := true;  // to keep width/height ratio
  Icon64x64.GetBitmap(item.ImageIndex, iPreviewTemplate.Picture.Bitmap);

  DocNumber := Item.Index + 1;
  frReport1.LoadFromDB(ztLazReportTemplates, DocNumber);
  lAuthor.Caption := frReport1.Subject + ' - ' + frReport1.ReportAutor;
{
property Subject : string read FSubject write FSubject;
property KeyWords : string read FKeyWords write FKeyWords;
property Comments : TStringList read FComments write SetComments;
property ReportAutor : string read FReportAutor write FReportAutor;
property ReportVersionMajor : string read FReportVersionMajor write FReportVersionMajor;
property ReportVersionMinor : string read FReportVersionMinor write FReportVersionMinor;
property ReportVersionRelease : string read FReportVersionRelease write FReportVersionRelease;
property ReportVersionBuild : string read FReportVersionBuild write FReportVersionBuild;
property ReportCreateDate : TDateTime read FReportCreateDate write FReportCreateDate;
property ReportLastChange : TDateTime read FReportLastChange write FReportLastChange;
}
end;

procedure TPrintFrame.DeleteTemplateButtonClick(Sender: TObject);
begin
  // Borrar la plantilla de la base de datos
  ztLazReportTemplates.First;
  while not ztLazReportTemplates.EOF do
  begin
    if ztLazReportTemplates.Fields[0].AsInteger = (lvTemplatesList.ItemIndex + 1) then
    begin
      ztLazReportTemplates.Delete;
      break;
    end;
    ztLazReportTemplates.Next;
  end;
  lvTemplatesList.Items[lvTemplatesList.ItemIndex].Delete;

end;

procedure TPrintFrame.tbZoomValueChange(Sender: TObject);
var
  zoom: double;
begin
  zoom := tbZoomValue.Position;
  frPreview1.Zoom := zoom;
  lZoom.Caption := FloatToStr(zoom) + '%';
end;

procedure TPrintFrame.bPrevPageClick(Sender: TObject);
var
  page: integer;
begin
  page := frPreview1.Page - 1;
  if page > 0 then
    frPreview1.Page := page
  else
    frPreview1.Page := 1;
  ePages.Text := IntToStr(frPreview1.Page);
end;

procedure TPrintFrame.NewTemplateButtonClick(Sender: TObject);
begin
  frReport1.Clear;
  frReport1.DesignReport;
  //frDesigner.ManualDock(MainWindow.TabDockCenter);
end;

procedure TPrintFrame.cbSelectPrinterSelect(Sender: TObject);
var
  PInd: integer;
begin
  PInd := cbSelectPrinter.ItemIndex;
  Printer.PrinterIndex := PInd;
  if frReport1.CanRebuild or frReport1.ChangePrinter(0, PInd) then
    frReport1.PrepareReport; //... and reformat for new printer
end;

procedure TPrintFrame.eFromDocChange(Sender: TObject);
begin
  if eFromDoc.Text <> '' then
    sqlData(eFromDoc.Text);
end;

procedure TPrintFrame.frDesigner1SaveReport(Report: TfrReport;
  var ReportName: string; SaveAs: boolean; var Saved: boolean);
var
  pic: TPicture;
begin

  if SaveAs then
  begin
    ReportName := InputBox('Nombre del Archivo',
      'Especificar el nombre de la plantilla', '');
    if ReportName = '' then
      Exit;
    DocNumber := ztLazReportTemplates.RecordCount + 1;
  end;

  ztLazReportTemplates.Edit;
  Report.SaveToDB(ztLazReportTemplates, DocNumber);
  ztLazReportTemplates.Edit;
  ztLazReportTemplates.FieldByName('NAME').AsString := ReportName;
  ztLazReportTemplates.FieldByName('TYPE').AsString := '';

  if frReport1.PrepareReport then
    frReport1.ExportTo(TfrImageExportFilter, 'd:\tmp.jpg');

  pic := TPicture.Create;
  pic.LoadFromFile('d:\tmp.jpg');
  //StorePicture(pic, ztLazReportTemplates, 'IMAGE');


  ztLazReportTemplates.Post;

  Saved := True;
end;

procedure TPrintFrame.bPrintClick(Sender: TObject);
begin

  // Prepare the report and just stop if we hit an error as continuing makes no sense
  if not frReport1.PrepareReport then
    Exit;

  // Print the report using the supplied pages & copies
  frReport1.PrintPreparedReport('1-' + IntToStr(frReport1.EMFPages.Count),
    seCopiesNumber.Value);

end;

procedure TPrintFrame.BCButton1Click(Sender: TObject);
begin
  mbPrintPages.PageIndex := 0;
end;

procedure TPrintFrame.EditTemplateButtonClick(Sender: TObject);
begin
  frReport1.LoadFromDB(ztLazReportTemplates, lvTemplatesList.ItemIndex + 1);
  frReport1.FileName := lvTemplatesList.Items[lvTemplatesList.ItemIndex].Caption;
  frReport1.DesignReport;
end;

procedure TPrintFrame.SelectTemplateButtonClick(Sender: TObject);
begin
  frReport1.LoadFromDB(ztLazReportTemplates, DocNumber);
  frReport1.ShowReport;

  ePages.Text := '1';
  ePages.EditLabel.Caption := IntToStr(frPreview1.AllPages);

  mbPrintPages.PageIndex := 0;
  lPreviewTitle.Caption := lvTemplatesList.Items[lvTemplatesList.ItemIndex].Caption;
end;

procedure TPrintFrame.bNextPageClick(Sender: TObject);
var
  page: integer;
begin
  page := frPreview1.Page + 1;
  if page <= frPreview1.AllPages then
    frPreview1.Page := page
  else
    frPreview1.Page := frPreview1.AllPages;
  ePages.Text := IntToStr(frPreview1.Page);
end;

procedure TPrintFrame.bSaveToDocClick(Sender: TObject);

  function GetExportFilter(ind: integer): TfrExportFilterClass;
  begin
    case ind of
      0: Result := TfrTNPDFExportFilter;
      1: Result := TfrImageExportFilter;
      2: Result := TfrHtmlDivExportFilter;
      3: Result := TfrCSVExportFilter;
    end;
  end;

var
  dir: ansistring;
begin

  if cbSelectDocType.ItemIndex = 1 then
  begin
    SavePictureDialog1.Filter :=
      'Imagen en formáto PNG|*.PNG|Imagen en formáto JPG|*.JPG';
    if SavePictureDialog1.Execute then
      dir := SavePictureDialog1.FileName;
  end
  else
  begin
    case cbSelectDocType.ItemIndex of
      0: SaveDialog1.Filter := 'Archivo en formato PDF|*.PDF';
      2: SaveDialog1.Filter := 'Archivo en formato HTML|*.HTML';
      3: SaveDialog1.Filter := 'Archivo en formato EXCEL|*.XLS';
    end;
    if SaveDialog1.Execute then
      dir := SaveDialog1.FileName;
  end;

  if FileExists(dir) then
  begin
    case MessageDlg('El fichero ya existe ¿Quieres sustituirlo?',
        mtConfirmation, [mbYes, mbNo], 0) of
      mrNo: Exit;
    end;
  end;

  if frReport1.PrepareReport and (dir <> '') then
  begin
    frReport1.ExportTo(GetExportFilter(cbSelectDocType.ItemIndex), dir);
    MainWindow.bMenuClick(MainWindow.bMenu);
  end;
end;

procedure TPrintFrame.bPrint4Click(Sender: TObject);
begin
  mbPrintPages.PageIndex := 1;
end;

procedure TPrintFrame.bZoomMinusClick(Sender: TObject);
var
  zoom: double;
begin
  zoom := tbZoomValue.Position - 10;
  if zoom < 10 then
    zoom := 10;
  tbZoomValue.Position := Round(zoom);
end;

procedure TPrintFrame.bZoomPlusClick(Sender: TObject);
var
  zoom: double;
begin
  zoom := tbZoomValue.Position + 10;
  if zoom > 200 then
    zoom := 200;
  tbZoomValue.Position := Round(zoom);
end;

constructor TPrintFrame.Create(TheOwner: TComponent);
var
  LI: TListItem;
begin
  inherited Create(TheOwner);

  cbSelectPrinter.Items.Assign(Printer.Printers);
  cbSelectPrinter.ItemIndex := Printer.PrinterIndex;
  ztLazReportTemplates.Active := True;

  // ListView:
  while not ztLazReportTemplates.EOF do
  begin
    LI := lvTemplatesList.Items.Add;
    LI.Caption := ztLazReportTemplates.FieldByName('NAME').Text;
    //Icon64x64.Add();
    LI.ImageIndex := Icon64x64.Count - 1;
    ztLazReportTemplates.Next;
  end;
  if lvTemplatesList.Items.Count > 0 then
    lvTemplatesList.ItemIndex := 0;
  frReport1.ChangePrinter(0, Printer.PrinterIndex);

  FZQList := TList.Create;

  DocNumber := -1;
end;

constructor TPrintFrame.Create(TheOwner: TComponent; FromDoc, ToDoc: string);
begin
  Create(TheOwner);
  self.SetDocsToPrint(FromDoc, ToDoc);
end;

procedure TPrintFrame.SetDocsToPrint(FromDoc: string; ToDoc: string = '');
begin
  //if not Visible then exit;
  eFromDoc.Text := FromDoc;
  eToDoc.Text := ToDoc;

  Exit;
  sqlData(FromDoc);
  if DocNumber = -1 then
    DocNumber := lvTemplatesList.ItemIndex + 1;
  frReport1.LoadFromDB(ztLazReportTemplates, DocNumber);
  frReport1.ShowReport;
end;

procedure TPrintFrame.sqlData(Code: string);

  procedure CreateSQL(Name, command: string);
  var
    ZQ : TZQuery;
  begin
    ZQ := TZQuery.Create(self);
    ZQ.Connection := MainWindow.zcMainConnection;
    ZQ.Name := Name;
    FZQList.Add(ZQ);

    sqlEXEC(ZQ, command);
  end;

var
  Data, docType: string;
  i: integer;
begin
  docType := AnsiLeftStr(Code, 2);

  for i:= 0 to FZQList.Count - 1 do
    TZQuery(FZQList[i]).Free;
  FZQList.Clear;

  // FZQList[0] = Información de la empresa:
  CreateSQL('ENTERPRISINFO', 'SELECT * FROM ENTERPRISESINFO WHERE NAME =' +
                             QuotedStr(MainWindow.Company));

  case docType of
    'PR', 'FP', 'BI', 'PA', 'DN':
    begin
      CreateSQL('SALEDOCUMENT', 'SELECT * FROM SALEDOCUMENT WHERE CODE =' + QuotedStr(Code));
      CreateSQL('SALEDOCUMENTDATA', 'SELECT * FROM SALEDOCUMENTDATA WHERE SALEDOCUMENT_CODE =' + QuotedStr(Code));
      CreateSQL('CUSTOMER', 'SELECT * FROM CUSTOMER WHERE CODE =' +
                            QuotedStr(TZQuery(FZQList[1]).FieldByName('CUSTOMER_CODE').Text));
      CreateSQL('PROJECT', 'SELECT * FROM PROJECT WHERE CODE =' +
                            QuotedStr(TZQuery(FZQList[1]).FieldByName('PROJECT_CODE').Text));
      frDBDataSet1.DataSet := TZQuery(FZQList[2]);
    end;
    'BP', 'OR', 'WB', 'RO', 'PY', 'BB':
    begin
      CreateSQL('BUYDOCUMENT', 'SELECT * FROM BUYDOCUMENT WHERE CODE =' + QuotedStr(Code));
      CreateSQL('BUYDOCUMENTDATA', 'SELECT * FROM BUYDOCUMENTDATA WHERE BUYDOCUMENT_CODE =' + QuotedStr(Code));
      CreateSQL('SUPPLIER', 'SELECT * FROM SUPPLIER WHERE CODE =' +
                            QuotedStr(TZQuery(FZQList[1]).FieldByName('SUPPLIER_CODE').Text));
      CreateSQL('PROJECT', 'SELECT * FROM PROJECT WHERE CODE =' +
                            QuotedStr(TZQuery(FZQList[1]).FieldByName('PROJECT_CODE').Text));
      frDBDataSet1.DataSet := TZQuery(FZQList[2]);
    end;
    'CL':
    begin
      CreateSQL('CUSTOMER', 'SELECT * FROM CUSTOMER WHERE CODE =' + QuotedStr(Code));
      CreateSQL('SALEDOCUMENT', 'SELECT * FROM SALEDOCUMENT WHERE CUSTOMER_CODE =' +
                                QuotedStr(TZQuery(FZQList[1]).FieldByName('CODE').Text));
      frDBDataSet1.DataSet := TZQuery(FZQList[2]);
    end;
    'SU':
    begin
      CreateSQL('SUPPLIER', 'SELECT * FROM SUPPLIER WHERE CODE =' + QuotedStr(Code));
      CreateSQL('BUYDOCUMENT', 'SELECT * FROM BUYDOCUMENT WHERE SUPPLIER_CODE =' +
                                QuotedStr(TZQuery(FZQList[1]).FieldByName('CODE').Text));
      frDBDataSet1.DataSet := TZQuery(FZQList[2]);
    end;
  end;


  exit;
  case docType of
    // Documentos de venta:
    'PR', 'FP', 'BI', 'PA', 'DN':
      Data := 'SELECT * FROM DocVenta, DataDocVenta, Client WHERE ' +
        'DocVenta.dvdoID = ' + QuotedStr(Code) + ' AND ' +
        'DataDocVenta.vddvdoID = DocVenta.dvdoID AND ' +
        'Client.clCode = DocVenta.dvclID';
    // Documentos de compra:
    'BP', 'OR', 'WB', 'RO', 'PY', 'BB':
      Data := 'SELECT * FROM DocCompra, DataDocCompra, Proveedor WHERE ' +
        'DocCompra.dcdoID = ' + QuotedStr(Code) + ' AND ' +
        'DataDocCompra.cddcID = DocCompra.dcdoID AND ' +
        'Proveedor.prCode = DocCompra.dcdoID';

    'CL',
    'SU': Data := '';
    else
      Data := '';
  end;

  Exit;

  {if Data <> '' then
  begin
    ZQuery1.Connection := MainWindow.zcMainConnection;
    sqlEXEC(ZQuery1, Data);
	end;}
end;

end.
