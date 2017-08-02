unit formClient;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, NiceGrid, NiceLookUpComboBox, BCButton, BCPanel,
  DBZVDateTimePicker, ZDataset, Forms, formWorkForm, Controls, Graphics,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Buttons, ComCtrls, EditBtn, ExtDlgs,
  Grids, DBGrids, DB;

type

  { TClient }

  TClient = class(TWorkForm)
    bClearImage: TBCButton;
    BCPanel2: TBCPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    bLoadImage: TBCButton;
    DBComboBox1: TDBComboBox;
    DBImage: TDBImage;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    dsSaleDocs: TDataSource;
    edCode: TDBEdit;
    edDir3: TDBEdit;
    edDir4: TDBEdit;
    edEMail1: TDBEdit;
    edFax1: TDBEdit;
    eDirContact: TDBLookupComboBox;
    eDirContact1: TDBLookupComboBox;
    eDirCountryID1: TDBLookupComboBox;
    eDirCP: TDBLookupComboBox;
    eDirCountryID: TDBLookupComboBox;
    dsClient: TDataSource;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    dcFamily: TDataSource;
    dsForm: TDataSource;
    edDir1: TDBEdit;
    edDir2: TDBEdit;
    edFax: TDBEdit;
    edEMail: TDBEdit;
    edNIF: TDBEdit;
    edNombre: TDBEdit;
    edWeb: TDBEdit;
    eDirCP1: TDBLookupComboBox;
    edMovil: TDBEdit;
    edMovil1: TDBEdit;
    edPais: TDBEdit;
    edPais1: TDBEdit;
    edPobla: TDBEdit;
    edPobla1: TDBEdit;
    edProvincia: TDBEdit;
    edProvincia1: TDBEdit;
    edTel: TDBEdit;
    edTel1: TDBEdit;
    gbNormalDirection: TGroupBox;
    gbNormalDirection1: TGroupBox;
    Grid: TDBGrid;
    GroupBox2: TGroupBox;
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
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel4: TPanel;
    pcAll: TPageControl;
    tsBancData: TTabSheet;
    tsGeneral: TTabSheet;
    tsDocuments: TTabSheet;
    zqClient: TZQuery;
    zqSaleDocs: TZQuery;
    zqSaleDocsdvDateCre: TDateField;
    zqSaleDocsdvDateVal: TDateField;
    zqSaleDocsdvdoDes: TStringField;
    zqSaleDocsdvdoID: TStringField;
    zqSaleDocsdvEstado: TStringField;
    zqSaleDocsdvPVP: TFloatField;
    ztFamily: TZTable;
    ztForm: TZTable;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure bLoadImageClick(Sender: TObject);
    procedure bClearImageClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);override;
    procedure DBEdit16KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBImageDblClick(Sender: TObject);
    procedure dsClientDataChange(Sender: TObject; Field: TField);
    procedure edCodeKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
    procedure GridDblClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Client: TClient;

implementation

uses
  Utiles, formMainWindow, LCLIntf;

{$R *.lfm}

{ TClient }

procedure TClient.BitBtn4Click(Sender: TObject);
var
  i: integer;
begin
  if not ButtonSaveEnabled then
    zqClient.Edit;
  for i := 0 to 11 do
    zqClient.Fields.FieldByNumber(i + 18).Text :=
      zqClient.Fields.FieldByNumber(i + 6).Text;
end;

procedure TClient.BitBtn2Click(Sender: TObject);
begin
  if edWeb.Text <> '' then
    OpenURL(edWeb.Text);
end;

procedure TClient.bLoadImageClick(Sender: TObject);
begin
  if MainWindow.OpenPictureDialog.Execute then
  begin
    if (zqClient.State <> dsEdit) or (zqClient.State <> dsInsert) then zqClient.Edit;
    DBImage.Picture.LoadFromFile(MainWindow.OpenPictureDialog.FileName);
  end;
end;

procedure TClient.bClearImageClick(Sender: TObject);
begin
  if (zqClient.State <> dsEdit) or (zqClient.State <> dsInsert) then zqClient.Edit;
  DBImage.Picture.Clear;
end;

procedure TClient.bSaveClick(Sender: TObject);
var
  ZQ: TZQuery;
  num: integer;
begin

  if edNombre.Text = '' then
  begin
    edNombre.SetFocus;
    Exit;
  end;

  if edNIF.Text = '' then
  begin
    edNIF.SetFocus;
    Exit;
  end;

   {if not ValidaCif(edNIF.Text)) then
   begin
      Page.ActivePage := tabDatos;
      edNIF.SetFocus;
      Exit;
   end;}

  if edCode.Text = '' then
  begin
    ZQ := TZQuery.Create(self);
    ZQ.Connection := MainWindow.zcMainConnection;
    sqlEXEC(ZQ, 'SELECT ID FROM CUSTOMER ORDER by ID DESC LIMIT 1');

    num := ZQ.FieldByName('ID').AsInteger;
    if num = 0 then
      DocCode := FormatFloat('CL00000000', 1)
    else
      DocCode := FormatFloat('CL00000000', num + 1);
    zqClient.FieldByName('CODE').Text := DocCode;
    Caption := 'Cliente: ' + DocCode;
  end;
  zqClient.Post;
end;

procedure TClient.DBEdit16KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if CheckIBAN(DBEdit16.Text) or (DBEdit16.Text = '')  then
    DBEdit16.Color := clDefault
  else
    DBEdit16.Color := $007777FF;

end;

procedure TClient.DBImageDblClick(Sender: TObject);
begin
  bLoadImageClick(Sender);
end;

procedure TClient.dsClientDataChange(Sender: TObject; Field: TField);
begin
  { TDataSetState = (dsInactive, dsBrowse, dsEdit, dsInsert, dsSetKey,
    dsCalcFields, dsFilter, dsNewValue, dsOldValue, dsCurValue, dsBlockRead,
    dsInternalCalc, dsOpening);}
  case dsClient.State of
    dsEdit, dsInsert:
    begin
      ButtonSaveEnabled:=True;
    end;
    else
    begin
      ButtonSaveEnabled:= False;
    end;
  end;
end;

procedure TClient.edCodeKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    SelectNext(TWinControl(Sender), True, True);
  end;
end;

procedure TClient.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited FormClose(Sender, CloseAction);
  zqClient.Close;
end;

procedure TClient.FormCreate(Sender: TObject);
begin

  ztFamily.Active := True;
  ztForm.Active := True;

  if DocCode = '' then
  begin
    sqlEXEC(zqClient, 'SELECT * FROM CUSTOMER WHERE ID = -1 LIMIT 1');
    zqClient.Append;
    DocCode := 'Nuevo';
  end
  else
  begin
    sqlEXEC(zqClient, 'SELECT * FROM CUSTOMER WHERE CODE = ' + QuotedStr(DocCode));
    sqlEXEC(zqSaleDocs, 'SELECT * FROM SALEDOCUMENT WHERE CUSTOMER_CODE = ' + QuotedStr(DocCode));
    ButtonSaveEnabled:= False;
  end;

  Caption := 'Cliente: ' + DocCode;

  pcAll.PageIndex := 0;
  ManualDock(MainWindow.TabDockCenter);
end;

procedure TClient.FormDropFiles(Sender: TObject; const FileNames: array of String);
begin
  if (DBimage.DataSource.State <> dsEdit) or (DBimage.DataSource.State <> dsInsert) then
    DBimage.DataSource.DataSet.Edit;
  DBImage.Picture.LoadFromFile(FileNames[0]);
end;

procedure TClient.GridDblClick(Sender: TObject);
begin

end;


end.
