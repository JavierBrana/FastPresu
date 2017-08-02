unit frameDataBaseConfig;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCPanel, ZDataset, Forms, Controls, ExtCtrls,
  StdCtrls, maskedit, Spin, types, LCLType, Graphics;

type

  { TfrDataBaseConfig }

  TfrDataBaseConfig = class(TFrame)
    bAccept: TButton;
    cmbDatabaseType: TComboBox;
    imgDatabaseTypes: TImageList;
    lblPort: TLabel;
    lblSever: TLabel;
    Panel1: TBCPanel;
    Panel2: TPanel;
    txtPassword: TLabeledEdit;
    txtPort: TSpinEdit;
    txtServer: TMaskEdit;
    txtUserName: TLabeledEdit;
    procedure bAcceptClick(Sender: TObject);
    procedure cmbDatabaseTypeChange(Sender: TObject);
    procedure cmbDatabaseTypeDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure cmbDatabaseTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbDatabaseTypeSelect(Sender: TObject);
  private
    { private declarations }
    FDataBase: string;
  public
    { public declarations }
    constructor Create(TheOwner: TComponent); override;
  end;

implementation

uses
  FormMainWindow,
  formCreateCompanyWizard,
  Dialogs, IniFiles, StrUtils, Utiles, u_variables;

{$R *.lfm}

{ TfrDataBaseConfig }

constructor TfrDataBaseConfig.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);


  {$IFNDEF LITTLE_VERSION}
  cmbDatabaseType.AddItem('MySQL', nil);
  cmbDatabaseType.AddItem('MsSQL', nil);
  cmbDatabaseType.AddItem('Oracle', nil);
  cmbDatabaseType.AddItem('PostGreSQL', nil);
  {$ENDIF}
  cmbDatabaseType.ItemIndex := 0;
  cmbDatabaseTypeChange(self);

end;

procedure TfrDataBaseConfig.cmbDatabaseTypeDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  cmb: TComboBox;
  bmpDB: TBitmap;
begin
  cmb := Control as TComboBox;

  if odSelected in State then
  begin
    cmb.Canvas.GradientFill(ARect, clWhite, clSkyBlue, gdVertical);
  end
  else
  begin
    cmb.Canvas.Brush.Color := clWindow;
    cmb.Canvas.FillRect(ARect);
  end;

  bmpDB := TBitmap.Create;
  imgDatabaseTypes.GetBitmap(Index, bmpDB);
  cmb.Canvas.Draw(ARect.Left, ARect.Top, bmpDB);
  cmb.Canvas.Font.Size := 10;
  cmb.Canvas.Brush.Style := bsClear;
  cmb.Canvas.TextOut(ARect.Left + 30, ARect.Top + 3, cmb.Items[Index]);
end;

procedure TfrDataBaseConfig.cmbDatabaseTypeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  if Key = VK_RETURN then
	begin
		SelectNext(TWinControl(Sender), True, True);
    Key := 0;
		Exit;
	end;

end;

procedure TfrDataBaseConfig.cmbDatabaseTypeSelect(Sender: TObject);
begin
  if cmbDatabaseType.ItemIndex = -1 then cmbDatabaseType.Color:= $007777FF
  else cmbDatabaseType.Color:= clDefault;
end;

procedure TfrDataBaseConfig.bAcceptClick(Sender: TObject);

  function ChenkForDB(aDB: string): boolean;
  var
    ZQuery : TZQuery;
  begin
    Result := false;
    if MainWindow.zcMainConnection.Protocol <> 'sqlite-3' then
    begin
      MainWindow.zcMainConnection.Database := 'INFORMATION_SCHEMA';
      ZQuery := TZQuery.Create(self);
      ZQuery.Connection := MainWindow.zcMainConnection;
      try
        sqlEXEC(ZQuery, 'SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA');
        while not ZQuery.EOF do
        begin
          if AnsiContainsText(ZQuery.Fields[0].AsString, aDB) then
          begin
            Result := true;
            Exit;
          end;
          ZQuery.Next;
        end;
      finally
        ZQuery.Free;
      end;
    end
    else Result := FileExists(DefaultDir + aDB + '.db');
  end;

var
  ConfigFile: TIniFile;
  FindEnterprise: boolean;
  ZQ: TZQuery;
begin
  if cmbDatabaseType.ItemIndex = -1 then
  begin
    cmbDatabaseType.Color:= $007777FF;
    Exit;
  end;

  //mind this order Server,Port,Database; when database is set, if oracle then server and port must be filled
  MainWindow.zcMainConnection.HostName := '127.0.0.1';//txtServer.Text;
  //MainWindow.zcMainConnection.Port := txtPort.Value;
  MainWindow.zcMainConnection.Database := '';
  MainWindow.zcMainConnection.User := txtUserName.Text;
  MainWindow.zcMainConnection.Password := txtPassword.Text;

  try
    MainWindow.zcMainConnection.Connected := true;
  except on E:Exception do
    MessageDlg( E.Message, mtError, [mbOK], 0);
  end;

  FindEnterprise := ChenkForDB('ENTERPRISES');
  if not FindEnterprise then
  begin
    // Se crea la DB:
    if MainWindow.zcMainConnection.Protocol <> 'sqlite-3' then
    begin
      ZQ := TZQuery.Create(self);
      ZQ.Connection := MainWindow.zcMainConnection;
      try
        {MainWindow.ZSQLProcessor1.Clear;
        MainWindow.ZSQLProcessor1.Script.Add('CREATE DATABASE IF NOT EXISTS ENTERPRISES');
        MainWindow.ZSQLProcessor1.Execute;}
        sqlEXEC(ZQ, 'CREATE DATABASE IF NOT EXISTS ENTERPRISES', false);


        if not ChenkForDB('GENERAL') then
        begin
          {MainWindow.ZSQLProcessor1.Clear;
          MainWindow.ZSQLProcessor1.Script.Add('CREATE DATABASE IF NOT EXISTS GENERAL');
          MainWindow.ZSQLProcessor1.Execute;}
          sqlEXEC(ZQ, 'CREATE DATABASE IF NOT EXISTS GENERAL', false);
        end;
      finally
        ZQ.Free;
      end;
    end
    else
    begin
      MainWindow.zcMainConnection.Connected := false;
      MainWindow.zcMainConnection.Database := DefaultDir + 'GENERAL.db';
      MainWindow.zcMainConnection.Connected := true;
    end;
  end;

  MainWindow.zcMainConnection.Connected := false;
  MainWindow.zcMainConnection.Database := FDataBase;
  MainWindow.zcMainConnection.Connected := true;

  if MainWindow.zcMainConnection.Connected then
  begin
    // 1 - Salvar archivo de configuración:
    ConfigFile := TIniFile.Create(DefaultDir + 'config.ini');
    try
      ConfigFile.WriteString('DataBase', 'Protocol', MainWindow.zcMainConnection.Protocol);
      ConfigFile.WriteString('DataBase', 'HostName', MainWindow.zcMainConnection.HostName);
      ConfigFile.WriteInteger('DataBase', 'Port', MainWindow.zcMainConnection.Port);
      ConfigFile.WriteString('DataBase', 'Database', MainWindow.zcMainConnection.Database);
      ConfigFile.WriteString('DataBase', 'User', MainWindow.zcMainConnection.User);
      ConfigFile.WriteString('DataBase', 'Password', MainWindow.zcMainConnection.Password);
    finally
      ConfigFile.Free;
    end;

    // 2 - Cerrar ventana
    MainWindow.bMenu.Enabled := true;
    //MainWindow.nbPages.PageIndex := 0;

    // 3 - Crear empresa nueva
    if not FindEnterprise then
    begin
      if CreateCompanyWizard = nil then
        CreateCompanyWizard := TCreateCompanyWizard.Create(Application);
      CreateCompanyWizard.ShowModal;
    end;
  end;
end;

procedure TfrDataBaseConfig.cmbDatabaseTypeChange(Sender: TObject);
begin
  txtUserName.Visible := True;
  txtPassword.Visible := True;
  lblPort.Visible := True;
  txtPort.Visible := True;
  lblSever.Visible := True;
  txtServer.Visible := True;

  case cmbDatabaseType.ItemIndex of
    0: // SQLite
    begin
      txtUserName.Visible := False;
      txtPassword.Visible := true;
      lblPort.Visible := False;
      txtPort.Visible := False;
      lblSever.Visible := False;
      txtServer.Visible := False;
      txtServer.Text:='';
      txtUserName.Text:='';
      txtPassword.Text:='';
      MainWindow.zcMainConnection.Protocol := 'sqlite-3';
      FDataBase := DefaultDir + 'ENTERPRISES.db';
    end;
    {$IFNDEF LITTLE_VERSION}
    1: // MySQL
    begin
      txtPort.Text := '3306';
      txtUserName.Text := 'root';
      txtPassword.Text := '';
      MainWindow.zcMainConnection.Protocol := 'mysql';
      //MainWindow.zcMainConnection.LibraryLocation := ExtractFilePath(Application.ExeName) + 'libmysql.dll';
      //MainWindow.zcMainConnection.LibLocation := ExtractFilePath(Application.ExeName) + 'libmysql.dll';
      FDataBase := 'ENTERPRISES';
    end;
    2: //MS SQL lblSever
    begin
      txtPort.Text := '0';
      txtUserName.Text := 'sa';
      txtPassword.Text := '';
      MainWindow.zcMainConnection.Protocol := 'mssql';
      FDataBase := 'ENTERPRISES';
    end;
    3: //Oracle
    begin
      txtPort.Text := '1521';
      txtUserName.Text := 'sa';
      txtPassword.Text := '';
      MainWindow.zcMainConnection.Protocol := 'oracle';
      //if Is64Bit then
      //begin
      //  cmbDbEngine.Enabled:=False;
      //end;
      //cmbDbEngine.ItemIndex:=1;
      FDataBase := 'ENTERPRISES';
    end;
    4: //PostgreSQL
    begin
      txtUserName.Visible := True;
      txtPassword.Visible := true;
      lblPort.Visible := True;
      txtPort.Visible := True;
      lblSever.Visible := True;
      txtServer.Visible := True;
      txtPort.Text:='5432';
      txtUserName.Text := 'postgres';
      txtPassword.Text := '';
      MainWindow.zcMainConnection.Protocol := 'postgresql-9';
      //cmbDbEngine.ItemIndex:=1;
      FDataBase := 'ENTERPRISES';
    end;
    5: // Firebird
    begin
      txtUserName.Visible := True;
      txtPassword.Visible := true;
      lblPort.Visible := True;
      txtPort.Visible := True;
      lblSever.Visible := True;
      txtServer.Visible := True;
      txtPort.Text:='3050';
      txtUserName.Text := 'SYSDBA';
      txtPassword.Text := '';
      MainWindow.zcMainConnection.Protocol := 'firebirdd-2.5';
      FDataBase := DefaultDir + 'ENTERPRISES.db';
    end;
    {$ENDIF}
  end;
end;

end.

