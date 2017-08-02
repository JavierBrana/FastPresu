unit formCreateCompanyWizard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, BCPanel, ZDataset, ZConnection, Forms,
  Controls, Graphics, Dialogs, ButtonPanel, ExtCtrls, StdCtrls, ComCtrls,
  EditBtn, DBCtrls, Buttons, ExtDlgs, Grids, DBGrids, ActnList, strutils;

type

  { TCreateCompanyWizard }

  TCreateCompanyWizard = class(TForm)
    bBack: TBitBtn;
    bCancel: TBitBtn;
    bNext: TBitBtn;
    bAccept: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    edBanco: TEdit;
    edBICSWIFT: TEdit;
    edCIFCom: TEdit;
    edCNAE: TEdit;
    edCP: TEdit;
    edDCNAE: TEdit;
    edDir1: TEdit;
    edDir2: TEdit;
    edFax: TEdit;
    edIAE: TEdit;
    edIBAN: TEdit;
    edMail: TEdit;
    edMovil: TEdit;
    edNIF: TEdit;
    edNombre: TEdit;
    edPais: TEdit;
    edPobla: TEdit;
    edProvincia: TEdit;
    edTel: TEdit;
    edWeb: TEdit;
    iLogo1: TImage;
    iLogo2: TImage;
    iLogo3: TImage;
    laBanco: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label21: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    laBICSWIFT: TLabel;
    laCIFC: TLabel;
    laCNAE: TLabel;
    laDCNAE: TLabel;
    laIAE: TLabel;
    laIBAN: TLabel;
    laNIF: TLabel;
    laNombre: TLabel;
    ListBox1: TListBox;
    lTitle: TLabel;
    lDescription: TLabel;
    Panel4: TPanel;
    PC: TNotebook;
    Page1: TPage;
    Page2: TPage;
    Page3: TPage;
    Page4: TPage;
    Page5: TPage;
    Page6: TPage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pError: TBCPanel;
    pHeader: TPanel;
    Timer1: TTimer;
    Timer2: TTimer;
    ZQuery: TZQuery;
    procedure bBackClick(Sender: TObject);
    procedure bNextClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure OpenLogosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageBeforeShow(ASender: TObject; ANewPage: TPage; ANewIndex: integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { private declarations }
    function CreateEmpresaDB: boolean;
    procedure Animation(aMsg: String);
  public
    { public declarations }
  end;

var
  CreateCompanyWizard: TCreateCompanyWizard;

implementation

{$R *.lfm}
uses
  LCLType,

  formMainWindow,
  Utiles,
  DatabaseDefine, databasedefine_MySql,
  dbDefaultValues,
  u_units,
  u_variables;

{ TCreateCompanyWizard }

procedure TCreateCompanyWizard.FormShow(Sender: TObject);
begin
  ZQuery.Connection := MainWindow.zcMainConnection;
  PC.PageIndex := 0;
  ActiveControl := edNombre;

  lTitle.Caption := 'Nombre de la empresa';
  lDescription.Caption := 'Nombre original de la empesa que se quiere crear';
end;

procedure TCreateCompanyWizard.PageBeforeShow(ASender: TObject;
  ANewPage: TPage; ANewIndex: integer);
begin
  //PCChange(ASender);
  case ANewIndex of
    0:
    begin
      lTitle.Caption := 'Nombre de la empresa';
      lDescription.Caption := 'Nombre original de la empesa que se quiere crear';
      bBack.Visible := false;
      bNext.Visible := true;
      bCancel.Visible := true;
      bAccept.Visible := false;
    end;
    1:
    begin
      lTitle.Caption := 'Datos generales de la empresa';
      lDescription.Caption := 'Direción de la empresa, teléfonos, correo electrónico';
      bBack.Visible := true;
      bNext.Visible := true;
      bCancel.Visible := true;
      bAccept.Visible := false;
    end;
    2:
    begin
      lTitle.Caption := 'Datos de la identidad publica de la empresa';
      lDescription.Caption := 'CIF y similares';
      bBack.Visible := true;
      bNext.Visible := true;
      bCancel.Visible := true;
      bAccept.Visible := false;
    end;
    3:
    begin
      lTitle.Caption := 'Datos bancarios de la empresa';
      lDescription.Caption := 'Cuenta principal con la que trabajar';
      bBack.Visible := true;
      bNext.Visible := true;
      bCancel.Visible := true;
      bAccept.Visible := false;
    end;
    4:
    begin
      lTitle.Caption := 'Logos de la empresa';
      lDescription.Caption := 'Logo principal y dos logos secundarios';
      bBack.Visible := true;
      bNext.Visible := true;
      bCancel.Visible := true;
      bAccept.Visible := false;
    end;
    5:
    begin
      lTitle.Caption := 'Creando empresa';
      lDescription.Caption := 'Proceso de creación';
      bBack.Visible := false;
      bNext.Visible := false;
      bCancel.Visible := false;
      bAccept.Visible := true;
      CreateEmpresaDB
    end;
  end;
end;

procedure TCreateCompanyWizard.Timer1Timer(Sender: TObject);
begin
  if pError.tag = 0 then
    if pError.Height < 65 then pError.Height := pError.Height + 5
    else
    begin
      pError.tag := 1;
      Timer1.Enabled := false;
      Timer2.Enabled := true;
    end
  else
    if pError.Height > 0 then pError.Height := pError.Height - 5
    else
    begin
      pError.tag := 0;
      Timer1.Enabled := false;
    end
end;

procedure TCreateCompanyWizard.Timer2Timer(Sender: TObject);
begin
  Timer1.Enabled:=true;
  Timer2.Enabled:=false;
end;

procedure TCreateCompanyWizard.FormCreate(Sender: TObject);
begin
  //PCChange(Sender);
  PC.PageIndex := 0;
end;

procedure TCreateCompanyWizard.OpenLogosClick(Sender: TObject);
begin
  with MainWindow.OpenPictureDialog do
  begin
    if Execute then
      case TButton(Sender).Tag of
        0: iLogo1.Picture.LoadFromFile(FileName);
        1: iLogo2.Picture.LoadFromFile(FileName);
        2: iLogo3.Picture.LoadFromFile(FileName);
      end;
  end;
end;

procedure TCreateCompanyWizard.CancelButtonClick(Sender: TObject);
begin
  if PC.PageIndex <> 0 then
    PC.PageIndex := PC.PageIndex - 1;
end;

procedure TCreateCompanyWizard.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
	begin
		SelectNext(TWinControl(Sender), True, True);
    Key := 0;
		Exit;
	end;
end;

procedure TCreateCompanyWizard.bNextClick(Sender: TObject);
var
  List: TStringList;
  error: Boolean;
begin
  error := false;
  case PC.PageIndex of
    0:
    begin
      if edNombre.Text = '' then
      begin
        laNombre.Font.Color := clRed;
        laNombre.Font.Style := [fsBold, fsUnderline];
        edNombre.SetFocus;

        Animation('Debe escribir un nombre');
        Exit;
      end
      else
      begin
        laNombre.Font.Color := clDefault;
        laNombre.Font.Style := [];

        //TODO: check if the exits a db with this name:
        try
          List:= TStringList.Create;
          MainWindow.zcMainConnection.GetTableNames('%', List);
          if (List.IndexOf(edNombre.Text) > -1) then error := true;
          MainWindow.zcMainConnection.GetCatalogNames(List);
          if (List.IndexOf(edNombre.Text) > -1) then error := true;
          if error then
          begin
            laNombre.Font.Color := clRed;
            laNombre.Font.Style := [fsBold, fsUnderline];
            edNombre.SetFocus;

            Animation('Nombre invalido o ya existe');
            Exit;
          end;

        finally
          List.Free;
        end;
      end;
    end;

    2:
    begin
      if edNIF.Text = '' then
      begin
        laNIF.Font.Color := clRed;
        laNIF.Font.Style := [fsBold, fsUnderline];
        edNIF.SetFocus;
        Animation('Debe escribir, al menos, del NIF');
        Exit;
      end
      else
      begin
        laNIF.Font.Color := clDefault;
        laNIF.Font.Style := [];
      end;
    end;
  end;

  if PC.PageIndex < 5 then
    PC.PageIndex := PC.PageIndex + 1;
end;

procedure TCreateCompanyWizard.bBackClick(Sender: TObject);
begin
  if PC.PageIndex > 0 then
    PC.PageIndex := PC.PageIndex - 1;
end;

procedure TCreateCompanyWizard.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  CreateCompanyWizard := nil;
end;

function TCreateCompanyWizard.CreateEmpresaDB: boolean;

  function Parsename(name: AnsiString): AnsiString;
  var
    tmp: AnsiString;
  begin
    tmp := StringReplace(name,' ', '_',  [rfReplaceAll,rfIgnoreCase]);
    tmp := StringReplace(tmp,'.', '',  [rfReplaceAll,rfIgnoreCase]);
    Result := StringReplace(tmp,',', '',  [rfReplaceAll,rfIgnoreCase]);
  end;

var
  i,j: integer;
  dbname: ansistring;
  ZQ: TZQuery;
  slist: TStringList;
begin

  Application.ProcessMessages;

  dbname := Parsename(edNombre.Text);

  if MainWindow.zcMainConnection.Protocol <> 'sqlite-3' then
  begin
    ZQ := TZQuery.Create(self);
    ZQ.Connection := MainWindow.zcMainConnection;
    try
      //ExecuteSQLScript(tEmpresas_MySQL);
      sqlEXEC(ZQ, tEmpresas_MySQL, false);
    finally
      ZQ.Free;
    end;
  end
  else
  begin
    //MainWindow.zcMainConnection.Connected := False;
    //MainWindow.zcMainConnection.Database := Default;
    //MainWindow.zcMainConnection.Connected := True;
    sqlEXEC(ZQ, tEmpresas);
  end;

  // Insertar la fila en la tabla 'Empresas'
  sqlEXEC(ZQuery, 'SELECT * FROM ENTERPRISES LIMIT 1');
  ZQuery.Insert;
  ZQuery.FieldByName('NAME').Text := edNombre.Text;
  ZQuery.FieldByName('DBNAME').Text := dbname;
  ZQuery.FieldByName('ID_NUMBER').Text := edNIF.Text;
  StorePicture(iLogo1.Picture, ZQuery, 'LOGO');
  ZQuery.Post;

  if MainWindow.zcMainConnection.Protocol <> 'sqlite-3' then
  begin
    sqlEXEC(ZQuery, 'CREATE DATABASE IF NOT EXISTS ' + dbname, false);
    //ExecuteSQLScript('CREATE DATABASE IF NOT EXISTS ' + dbname);
  end
  else dbname := DefaultDir + dbName + '.db';

  // Crear la base de datos de la empresa y las distintas tablas:
  MainWindow.zcMainConnection.Connected := False;
  MainWindow.zcMainConnection.Database := dbname;
  MainWindow.zcMainConnection.Connected := True;

  for i := 1 to Length(List_SQLLite) do
  begin
    Application.ProcessMessages;
    case MainWindow.zcMainConnection.Protocol of
      'sqlite-3': sqlEXEC(ZQuery, List_SQLLite[i]);
      'mssql': ;
      'MariaDB-5', 'mysql', 'mysql-5': sqlEXEC(ZQuery, List_MySQL[i], false);//ExecuteSQLScript(List_MySQL[i]);
      'postgresql-9':;
      'oracle-9i':;
    end;
    ListBox1.AddItem('Create Table: ' + IntToStr(i), nil);
    ListBox1.Invalidate;
  end;

  sqlEXEC(ZQuery, 'SELECT * FROM ENTERPRISESINFO');
  ZQuery.Insert;
  ZQuery.FieldByName('NAME').Text := edNombre.Text;
  ZQuery.FieldByName('ID_NUMBER').Text := edNIF.Text;
  //ZQuery.FieldByName('PATH').Text := dbname;

  ZQuery.FieldByName('ADDRESS1').Text := edDir1.Text;
  ZQuery.FieldByName('ADDRESS2').Text := edDir2.Text;
  ZQuery.FieldByName('POSTCODE').Text := edCP.Text;
  ZQuery.FieldByName('CITY').Text := edPobla.Text;
  ZQuery.FieldByName('PROVINCE').Text := edProvincia.Text;
  ZQuery.FieldByName('COUNTRY').Text := edPais.Text;
  ZQuery.FieldByName('PHONE').Text := edTel.Text;
  ZQuery.FieldByName('MOBILE').Text := edMovil.Text;
  ZQuery.FieldByName('FAX').Text := edFax.Text;
  ZQuery.FieldByName('EMAIL').Text := edMail.Text;
  ZQuery.FieldByName('WEB').Text := edWeb.Text;

  ZQuery.FieldByName('COMMUNITY_CIF').Text := edCIFCom.Text;
  ZQuery.FieldByName('IAE').Text := edIAE.Text;
  ZQuery.FieldByName('CNAE').Text := edCNAE.Text;
  ZQuery.FieldByName('DCNAE').Text := edDCNAE.Text;

  ZQuery.FieldByName('BANK_NAME').Text := edBanco.Text;
  ZQuery.FieldByName('IBAN').Text := edIBAN.Text;
  ZQuery.FieldByName('BIC_SWIFT').Text := edBICSWIFT.Text;

  StorePicture(iLogo1.Picture, ZQuery, 'LOGO1');
  StorePicture(iLogo2.Picture, ZQuery, 'LOGO2');
  StorePicture(iLogo3.Picture, ZQuery, 'LOGO3');
  ZQuery.Post;



  // Insertar valores por defecto en las DB:
  slist := TStringList.Create;
  try
    for i:=1 to Length(DBValues) do
    begin
      slist.Clear;
      slist.StrictDelimiter := true;
      slist.Delimiter := ',';
      slist.DelimitedText := DBValues[i];
      sqlEXEC(ZQuery, 'SELECT * FROM ' + slist[0]);
      //ZQuery.Edit;
      ZQuery.Append;
      for j := 1 to slist.Count - 1 do
      begin
        ZQuery.Fields.FieldByNumber(j).AsString := sList[j];
      end;
      ZQuery.Post;
    end;
  finally
    slist.Free;
  end;

  {for i := 0 to Length(UnitOfPercent) - 1 do
  begin
    sqlEXEC(ZQuery, 'SELECT * FROM ' + slist[0]);
    //ZQuery.Edit;
    ZQuery.Append;
    for j := 1 to slist.Count - 1 do
    begin
      ZQuery.Fields.FieldByNumber(j).AsString := sList[j];
    end;
    ZQuery.Post;
  end;}


  // una vez que se hace esto se crea conectado a las bases de datos de
  // las empresas y a la propia de la empresa
  MainWindow.SetDataBase(dbname, edNombre.Text);
end;

procedure TCreateCompanyWizard.Animation(aMsg: String);
begin
  pError.Caption := aMsg;
  Timer1.Enabled:=true;
end;

end.
