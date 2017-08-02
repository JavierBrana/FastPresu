unit formSplash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLType, ExtCtrls;

type

  TState = (stFirstTime, stNoConfig, doEdit);

  { TSplashScreen }

  TSplashScreen = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  protected
    { protected declarations }
  private
    { private declarations }
    FState: Integer;
    FLines: TStrings;

    procedure Initialize;
    procedure ReadDCConfig;
  public
    { public declarations }
  end;

var
  SplashScreen: TSplashScreen;

implementation

{$R *.lfm}

uses
  FormMainWindow, formOpenCompany, formCreateCompanyWizard,
  u_variables, Utiles,
  Windows, lclintf, IniFiles;

{ TSplashScreen }
procedure TSplashScreen.FormCreate(Sender: TObject);
begin
  FState := -1;
  BorderStyle := bsNone;
  FLines := TStrings.Create;

  { Place a shadow behind the Form }
  {$ifdef Windows}
  //DropShadow(Handle);
  //SetClassLong(self.Handle, GCL_STYLE,
  //             GetClassLong(self.Handle, GCL_STYLE) or CS_DROPSHADOW);
  {$else}
    // Something to be done for OS <> Windows?
  {$endif}

  { Set Doublebuffered property to reduce flicker. }
  Doublebuffered := True;

end;

procedure TSplashScreen.FormShow(Sender: TObject);
var
  ABitmap: Graphics.TBitmap;
begin
  BorderStyle := bsNone;
  ABitmap := Graphics.TBitmap.Create;
  ABitmap.Monochrome := True;
  ABitmap.Width := Width; // or Form1.Width
  ABitmap.Height := Height; // or Form1.Height

  // We set the background as black (which will be transparent)
  ABitmap.Canvas.Brush.Color := clBlack;
  ABitmap.Canvas.FillRect(0, 0, Width, Height);

  // Now we draw our shape in White
  ABitmap.Canvas.Brush.Color := clWhite;
  ABitmap.Canvas.RoundRect(0, 0, Width, Height, 10, 10);
  //Canvas.Draw(0,0,ABitmap);
  //SetShape(ABitmap);
  ABitmap.Free;

  Timer1.Enabled := true;
end;

procedure TSplashScreen.Timer1Timer(Sender: TObject);
begin
  if Timer1.Tag = 0 then
  begin
    Timer1.Enabled:=false;
    Initialize;
    Timer1.Tag := 1;
  end
  else
  begin
    Timer1.Enabled:=false;
    Close;
  end;
end;

procedure TSplashScreen.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  Hide;
  FLines.Free;

  case FState of
    0:
    begin
      MainWindow.bMenuClick(MainWindow.bMenu);
      MainWindow.bOpenDBConfigFormClick(self);
      MainWindow.Update;
    end;
    1:
    begin
      Application.CreateForm(TCreateCompanyWizard, CreateCompanyWizard);
      CreateCompanyWizard.ShowModal;
    end;
    2:
    begin
      Application.CreateForm(TOpenCompanyWindow, OpenCompanyWindow);
      OpenCompanyWindow.ShowModal;
    end;
  end;

end;

procedure TSplashScreen.Initialize;
var
  List: TStringList;
  {$IFDEF DEBUG}
  i: integer;
  {$ENDIF}
begin
  Label1.Caption := Label1.Caption + #13 + #10 + 'Inicializando ventana principal';
  Application.CreateForm(TMainWindow, MainWindow);
  Mainwindow.Show;

  {
  Things and order for chequing:
  1. Config dir
  2. Config File
  3. Any configuration
  4. Connection to DB
  5. Data exist in DB
  }
  if not DirectoryExists(DefaultDir) then
  begin
    Label1.Caption := Label1.Caption + #13 + #10 + 'Primera vez que se inicia el programa';
    if not ForceDirectories(DefaultDir) then Exit;
  end;

  if not FileExists(DefaultDir + 'config.ini') then
  begin
    FState := 0;
    Label1.Caption := Label1.Caption + #13 + #10 + 'No se ha determinado una base de datos';
  end
  else
  begin
    ReadDCConfig;
    if MainWindow.zcMainConnection.Protocol = '' then
    begin
      FState := 0;
      Label1.Caption := Label1.Caption + #13 + #10 + 'No se ha determinado una base de datos';
    end
    else if not MainWindow.ConnectDB then FState := -1
    else
    begin
      List:= TStringList.Create;
      MainWindow.zcMainConnection.GetCatalogNames(List);
      {$IFDEF DEBUG}
      dgSetLine('GetCatalogNames: ' + IntToStr(List.Count));
      for i := 0 to List.Count - 1 do
      begin;
        dgSetLine('|-' + IntToStr(i) + ': ' + List[i]);
      end;
      {$ENDIF}

      if (List.IndexOf('ENTERPRISES') > -1)  then
      begin
        MainWindow.zcMainConnection.GetTableNames('%', List);
        {$IFDEF DEBUG}
        dgSetLine('--------------------------------------');
        dgSetLine('GetTableNames: ' + IntToStr(List.Count));
        for i := 0 to List.Count - 1 do
        begin;
          dgSetLine('|-' + IntToStr(i) + ': ' + List[i]);
        end;
        {$ENDIF}
        i := List.IndexOf('ENTERPRISES');
        if (List.IndexOf('ENTERPRISES') > -1)  then
        begin
          //Todo: check if enterprises.enterprises is empty
          FState := 2

        end
        else FState := 1;
      end
      else FState := 0;
      List.Free;
    end;
  end;
  Timer1.Enabled := true;

  {$IFDEF DEBUG}
  dgSetLine('State: ' + IntToStr(FState));
  {$ENDIF}
end;

procedure TSplashScreen.ReadDCConfig;
var
  INIFile: TIniFile;
begin
  Label1.Caption := Label1.Caption + #13 + #10 + 'Leyendo configuración de la DB...';
  INIFile := TIniFile.Create(ConfigFile);
  try
    with MainWindow do
    begin
      zcMainConnection.Protocol := INIFile.ReadString('DataBase', 'Protocol', 'sqlite-3');
      zcMainConnection.HostName := INIFile.ReadString('DataBase', 'HostName', 'localhost');
      zcMainConnection.Port := INIFile.ReadInteger('DataBase', 'Port', 0);
      zcMainConnection.Database := INIFile.ReadString('DataBase', 'Database', '');
      //zcMainConnection.Database :='';
      zcMainConnection.User := INIFile.ReadString('DataBase', 'User', '');
      zcMainConnection.Password := INIFile.ReadString('DataBase', 'Password', '');
    end;
  finally
    INIFile.Free;
  end;
end;

end.
