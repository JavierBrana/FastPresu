unit formSupplier;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, BCButton, BCPanel, ZDataset,
  Forms,
  formWorkForm,
  Controls,
  Graphics, Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, ComCtrls, DBGrids,
  ExtDlgs;

type

  { TSupplier }

  TSupplier = class(TWorkForm)
    bClearImage: TBCButton;
    BCPanel2: TBCPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    bLoadImage: TBCButton;
    DBComboBox1: TDBComboBox;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBImage: TDBImage;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    dcFamily: TDataSource;
    dsSupplier: TDataSource;
    dsForm: TDataSource;
    dsSaleDocs: TDataSource;
    edCode: TDBEdit;
    edDir1: TDBEdit;
    edDir2: TDBEdit;
    edDir3: TDBEdit;
    edDir4: TDBEdit;
    edEMail1: TDBEdit;
    edFax: TDBEdit;
    edEMail: TDBEdit;
    edFax1: TDBEdit;
    edWeb: TDBEdit;
    eDirContact: TDBLookupComboBox;
    eDirContact1: TDBLookupComboBox;
    eDirCountryID: TDBLookupComboBox;
    eDirCountryID1: TDBLookupComboBox;
    eDirCP: TDBLookupComboBox;
    eDirCP1: TDBLookupComboBox;
    edMovil: TDBEdit;
    edMovil1: TDBEdit;
    edNIF: TDBEdit;
    edNombre: TDBEdit;
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
    tsDocuments: TTabSheet;
    tsGeneral: TTabSheet;
    zqSupplier: TZQuery;
    ztFamily: TZTable;
    ztForm: TZTable;
    ztSaleDocs: TZQuery;
    procedure bClearImageClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure bLoadImageClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);override;
    procedure DBImageDblClick(Sender: TObject);
    procedure dsSupplierDataChange(Sender: TObject; Field: TField);
    procedure edCodeKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
		procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
		procedure FormDeactivate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Supplier: TSupplier;

implementation

uses
  formMainWindow, Utiles;

{$R *.lfm}
procedure TSupplier.BitBtn4Click(Sender: TObject);
var
  i: integer;
begin
  if not ButtonSaveEnabled then zqSupplier.Edit;
  for i := 0 to 11 do
    zqSupplier.Fields.FieldByNumber(i + 18).Text := zqSupplier.Fields.FieldByNumber(i + 6).Text;
end;

procedure TSupplier.bLoadImageClick(Sender: TObject);
begin
  if MainWindow.OpenPictureDialog.Execute then
    DBImage.Picture.LoadFromFile(MainWindow.OpenPictureDialog.FileName);
end;

procedure TSupplier.bSaveClick(Sender: TObject);
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
    sqlEXEC(ZQ, 'SELECT ID FROM SUPPLIER ORDER by ID DESC LIMIT 1');

    num := ZQ.FieldByName('ID').AsInteger;
    if num = 0 then
      DocCode := FormatFloat('SU00000000', 1)
    else
      DocCode := FormatFloat('SU00000000', num + 1);
    zqSupplier.FieldByName('CODE').Text := DocCode;
    Caption := 'Proveedor: ' + DocCode;
  end;
  zqSupplier.Post;
end;

procedure TSupplier.bClearImageClick(Sender: TObject);
begin
  DBImage.Picture.Clear;
end;

procedure TSupplier.DBImageDblClick(Sender: TObject);
begin
  bLoadImageClick(Sender);
end;

procedure TSupplier.dsSupplierDataChange(Sender: TObject; Field: TField);
begin
  { TDataSetState = (dsInactive, dsBrowse, dsEdit, dsInsert, dsSetKey,
    dsCalcFields, dsFilter, dsNewValue, dsOldValue, dsCurValue, dsBlockRead,
    dsInternalCalc, dsOpening);}
  case dsSupplier.State of
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

procedure TSupplier.edCodeKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    SelectNext(TWinControl(Sender), True, True);
  end;
end;

procedure TSupplier.FormActivate(Sender: TObject);
begin
  //CreateToolBar(MainWindow.TopPanel);
end;

procedure TSupplier.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited FormClose(Sender, CloseAction);
  zqSupplier.Close;
end;

procedure TSupplier.FormCreate(Sender: TObject);
begin

  ztFamily.Active := True;
  ztForm.Active := True;

  if DocCode = '' then
  begin
    sqlEXEC(zqSupplier, 'SELECT * FROM SUPPLIER WHERE ID = -1 LIMIT 1');
    zqSupplier.Append;
    DocCode := 'Nuevo';
  end
  else
  begin
    sqlEXEC(zqSupplier, 'SELECT * FROM SUPPLIER WHERE CODE = ' + QuotedStr(DocCode));
    sqlEXEC(ztSaleDocs, 'SELECT * FROM BUYDOCUMENT WHERE SUPPLIER_CODE = ' + QuotedStr(DocCode));
    ButtonSaveEnabled := False;
  end;

  Caption := Caption + ': ' + DocCode;

  ztSaleDocs.Active := True;
  ManualDock(MainWindow.TabDockCenter);
  Visible := True;
end;

procedure TSupplier.FormDeactivate(Sender: TObject);
begin
  //DestroyToolBar;
end;

procedure TSupplier.GridDblClick(Sender: TObject);
begin

end;

end.
