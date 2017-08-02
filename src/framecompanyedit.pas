unit framecompanyedit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil,
  BGRABitmapTypes, BCTypes, BCPanel, BCButton,
  NiceDividerBevel, ZDataset, ZConnection, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBCtrls, ExtDlgs, ExtCtrls, ButtonPanel, ComCtrls;

type

  { TEditCompany }

  TEditCompany = class(TFrame)
    bClearImage: TBCButton;
    bClearImage1: TBCButton;
    bClearImage2: TBCButton;
    BCPanel1: TBCPanel;
    BCPanel2: TBCPanel;
    BCPanel3: TBCPanel;
    BCPanel4: TBCPanel;
    BCPanel5: TBCPanel;
    bLoadImage: TBCButton;
    bLoadImage1: TBCButton;
    bLoadImage2: TBCButton;
    DBText1: TDBText;
    dsEmpresas: TDataSource;
    edBanco: TDBEdit;
    edBICSWIFT: TDBEdit;
    edCIFCom: TDBEdit;
    edCNAE: TDBEdit;
    edCP: TDBEdit;
    edDCNAE: TDBEdit;
    edDir1: TDBEdit;
    edDir2: TDBEdit;
    edFax: TDBEdit;
    edIAE: TDBEdit;
    edIBAN: TDBEdit;
    edMail: TDBEdit;
    edMovil: TDBEdit;
    edNIF: TDBEdit;
    edNombre: TDBEdit;
    edPais: TDBEdit;
    edPobla: TDBEdit;
    edProvincia: TDBEdit;
    edTel: TDBEdit;
    edWeb: TDBEdit;
    iLogo1: TDBImage;
    iLogo2: TDBImage;
    iLogo3: TDBImage;
    laBanco: TLabel;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
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
    NiceDividerBevel1: TNiceDividerBevel;
    NiceDividerBevel2: TNiceDividerBevel;
    NiceDividerBevel3: TNiceDividerBevel;
    OpenPictureDialog: TOpenPictureDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ScrollBox1: TScrollBox;

    bSave: TBCButton;
    bClose: TBCButton;
    SeparatorBevel : TBevel;

    procedure LoadLogo(Sender: TObject);
    procedure ClearLogo(Sender: TObject);
    procedure dsEmpresasStateChange(Sender: TObject);

    procedure Save(Sender: TObject);
    procedure CloseWindow(Sender: TObject);
  private
    { private declarations }
    procedure CreateToolBar(Panel: TBCPanel);
    function CreateButton(Panel: TBCPanel; ImList: TImageList;
             ImIndex: Integer; OnClickFunction: TNotifyEvent; AnchControl: TControl): TBCButton;
    function CreateBevel(Panel: TBCPanel): TBevel;
    procedure DestroyToolBar;
  public
    { public declarations }
    //FCompany: ansistring;
    constructor Create(TheOwner: TComponent); override;
  end;

//var
//  EditCompany: TEditCompany;

implementation

uses
  FormMainWindow, Utiles, LCLType, IniFiles, u_variables;

{$R *.lfm}

{ TEditCompany }

constructor TEditCompany.Create(TheOwner: TComponent);
begin
  //CreateToolBar(MainWindow.TopPanel);
  inherited Create(TheOwner);
end;

procedure TEditCompany.dsEmpresasStateChange(Sender: TObject);
begin
  if dsEmpresas.State = dsEdit then
    bSave.Enabled := True
  else
    bSave.Enabled := False;
end;

procedure TEditCompany.LoadLogo(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
    dsEmpresas.DataSet.Edit;
    case TBCButton(Sender).Tag of
      0: iLogo1.Picture.LoadFromFile(OpenPictureDialog.FileName);
      1: iLogo2.Picture.LoadFromFile(OpenPictureDialog.FileName);
      2: iLogo3.Picture.LoadFromFile(OpenPictureDialog.FileName);
    end;
end;

procedure TEditCompany.ClearLogo(Sender: TObject);
begin
  case TBCButton(Sender).Tag of
    0: iLogo1.Picture.Clear;
    1: iLogo2.Picture.Clear;
    2: iLogo3.Picture.Clear;
  end;
end;

procedure TEditCompany.CreateToolBar(Panel: TBCPanel);
begin
  SeparatorBevel := self.CreateBevel(Panel);
  bSave := CreateButton(Panel, MainWindow.General_16, 5, @Save, SeparatorBevel);
  bClose := CreateButton(Panel, MainWindow.General_16, 6, @CloseWindow, nil);
  bClose.Align := alRight;
end;

function TEditCompany.CreateButton(Panel: TBCPanel; ImList: TImageList;
  ImIndex: Integer; OnClickFunction: TNotifyEvent; AnchControl: TControl): TBCButton;
var
  l, w: integer;
begin
  Result := TBCButton.Create(Panel);
	with Result do
  begin
		  Parent := Panel;
		  Width := 40;
		  Height := Panel.Height - 4;
		  Top := 2;
		  Align := alLeft;
      if Assigned(AnchControl) then
        Left := AnchControl.Left + AnchControl.Width + 5;

		  Images := ImList;
      ImageIndex := ImIndex;
      ShowCaption := False;
      Caption := 'Back;';

      OnClick := OnClickFunction;

		  StateClicked.Background.Color := 15981500;
		  StateClicked.Background.ColorOpacity := 255;
		  StateClicked.Background.Gradient1.StartColor := 15981500;
		  StateClicked.Background.Gradient1.StartColorOpacity := 255;
		  StateClicked.Background.Gradient1.DrawMode := dmSet;
		  StateClicked.Background.Gradient1.EndColor := 16312531;
		  StateClicked.Background.Gradient1.EndColorOpacity := 255;
		  StateClicked.Background.Gradient1.ColorCorrection := True;
		  StateClicked.Background.Gradient1.GradientType := gtLinear;
		  StateClicked.Background.Gradient1.Point1XPercent := 0;
		  StateClicked.Background.Gradient1.Point1YPercent := 0;
		  StateClicked.Background.Gradient1.Point2XPercent := 0;
		  StateClicked.Background.Gradient1.Point2YPercent := 100;
		  StateClicked.Background.Gradient1.Sinus := False;
		  StateClicked.Background.Gradient2.StartColor := 16113605;
		  StateClicked.Background.Gradient2.StartColorOpacity := 255;
		  StateClicked.Background.Gradient2.DrawMode := dmSet;
		  StateClicked.Background.Gradient2.EndColor := 15981500;
		  StateClicked.Background.Gradient2.EndColorOpacity := 255;
		  StateClicked.Background.Gradient2.ColorCorrection := True;
		  StateClicked.Background.Gradient2.GradientType := gtLinear;
		  StateClicked.Background.Gradient2.Point1XPercent := 0;
		  StateClicked.Background.Gradient2.Point1YPercent := 0;
		  StateClicked.Background.Gradient2.Point2XPercent := 0;
		  StateClicked.Background.Gradient2.Point2YPercent := 100;
		  StateClicked.Background.Gradient2.Sinus := False;
		  StateClicked.Background.Gradient1EndPercent := 100;
		  StateClicked.Background.Style := bbsColor;
		  StateClicked.Border.Color := 15448451;
		  StateClicked.Border.ColorOpacity := 255;
		  StateClicked.Border.LightColor := 16312531;
		  StateClicked.Border.LightOpacity := 255;
		  StateClicked.Border.LightWidth := 0;
		  StateClicked.Border.Style := bboSolid;
		  StateClicked.Border.Width := 1;
		  StateClicked.FontEx.Color := clBlack;
		  StateClicked.FontEx.EndEllipsis := False;
		  StateClicked.FontEx.FontQuality := fqSystemClearType;
		  StateClicked.FontEx.Height := 11;
		  StateClicked.FontEx.Name := 'Verdana';
		  StateClicked.FontEx.SingleLine := True;
		  StateClicked.FontEx.Shadow := False;
		  StateClicked.FontEx.ShadowColor := clBlack;
		  StateClicked.FontEx.ShadowColorOpacity := 255;
		  StateClicked.FontEx.ShadowRadius := 5;
		  StateClicked.FontEx.ShadowOffsetX := 5;
		  StateClicked.FontEx.ShadowOffsetY := 5;
		  StateClicked.FontEx.Style := [];
		  StateClicked.FontEx.TextAlignment := bcaCenter;
		  StateClicked.FontEx.WordBreak := False;
		  StateHover.Background.Color := clBlack;
		  StateHover.Background.ColorOpacity := 255;
		  StateHover.Background.Gradient1.StartColor := 16577773;
		  StateHover.Background.Gradient1.StartColorOpacity := 255;
		  StateHover.Background.Gradient1.DrawMode := dmSet;
		  StateHover.Background.Gradient1.EndColor := 16310217;
		  StateHover.Background.Gradient1.EndColorOpacity := 255;
		  StateHover.Background.Gradient1.ColorCorrection := True;
		  StateHover.Background.Gradient1.GradientType := gtLinear;
		  StateHover.Background.Gradient1.Point1XPercent := 0;
		  StateHover.Background.Gradient1.Point1YPercent := 0;
		  StateHover.Background.Gradient1.Point2XPercent := 0;
		  StateHover.Background.Gradient1.Point2YPercent := 100;
		  StateHover.Background.Gradient1.Sinus := False;
		  StateHover.Background.Gradient2.StartColor := 16310217;
		  StateHover.Background.Gradient2.StartColorOpacity := 255;
		  StateHover.Background.Gradient2.DrawMode := dmSet;
		  StateHover.Background.Gradient2.EndColor := 16577773;
		  StateHover.Background.Gradient2.EndColorOpacity := 255;
		  StateHover.Background.Gradient2.ColorCorrection := True;
		  StateHover.Background.Gradient2.GradientType := gtLinear;
		  StateHover.Background.Gradient2.Point1XPercent := 0;
		  StateHover.Background.Gradient2.Point1YPercent := 0;
		  StateHover.Background.Gradient2.Point2XPercent := 0;
		  StateHover.Background.Gradient2.Point2YPercent := 100;
		  StateHover.Background.Gradient2.Sinus := False;
		  StateHover.Background.Gradient1EndPercent := 100;
		  StateHover.Background.Style := bbsGradient;
		  StateHover.Border.Color := 15515276;
		  StateHover.Border.ColorOpacity := 255;
		  StateHover.Border.LightColor := 16577773;
		  StateHover.Border.LightOpacity := 255;
		  StateHover.Border.LightWidth := 1;
		  StateHover.Border.Style := bboSolid;
		  StateHover.Border.Width := 1;
		  StateHover.FontEx.Color := clBlack;
		  StateHover.FontEx.EndEllipsis := False;
		  StateHover.FontEx.FontQuality := fqSystemClearType;
		  StateHover.FontEx.Height := 11;
		  StateHover.FontEx.Name := 'Verdana';
		  StateHover.FontEx.SingleLine := True;
		  StateHover.FontEx.Shadow := False;
		  StateHover.FontEx.ShadowColor := clBlack;
		  StateHover.FontEx.ShadowColorOpacity := 255;
		  StateHover.FontEx.ShadowRadius := 5;
		  StateHover.FontEx.ShadowOffsetX := 5;
		  StateHover.FontEx.ShadowOffsetY := 5;
		  StateHover.FontEx.Style := [];
		  StateHover.FontEx.TextAlignment := bcaCenter;
		  StateHover.FontEx.WordBreak := False;
		  StateNormal.Background.Color := clBlack;
		  StateNormal.Background.ColorOpacity := 255;
		  StateNormal.Background.Gradient1.StartColor := clWhite;
		  StateNormal.Background.Gradient1.StartColorOpacity := 255;
		  StateNormal.Background.Gradient1.DrawMode := dmSet;
		  StateNormal.Background.Gradient1.EndColor := 15855597;
		  StateNormal.Background.Gradient1.EndColorOpacity := 255;
		  StateNormal.Background.Gradient1.ColorCorrection := True;
		  StateNormal.Background.Gradient1.GradientType := gtLinear;
		  StateNormal.Background.Gradient1.Point1XPercent := 0;
		  StateNormal.Background.Gradient1.Point1YPercent := 0;
		  StateNormal.Background.Gradient1.Point2XPercent := 0;
		  StateNormal.Background.Gradient1.Point2YPercent := 100;
		  StateNormal.Background.Gradient1.Sinus := False;
		  StateNormal.Background.Gradient2.StartColor := 13137169;
		  StateNormal.Background.Gradient2.StartColorOpacity := 255;
		  StateNormal.Background.Gradient2.DrawMode := dmSet;
		  StateNormal.Background.Gradient2.EndColor := 15722194;
		  StateNormal.Background.Gradient2.EndColorOpacity := 255;
		  StateNormal.Background.Gradient2.ColorCorrection := True;
		  StateNormal.Background.Gradient2.GradientType := gtLinear;
		  StateNormal.Background.Gradient2.Point1XPercent := 0;
		  StateNormal.Background.Gradient2.Point1YPercent := 0;
		  StateNormal.Background.Gradient2.Point2XPercent := 0;
		  StateNormal.Background.Gradient2.Point2YPercent := 100;
		  StateNormal.Background.Gradient2.Sinus := False;
		  StateNormal.Background.Gradient1EndPercent := 100;
		  StateNormal.Background.Style := bbsClear;
		  StateNormal.Border.Color := 13816015;
		  StateNormal.Border.ColorOpacity := 255;
		  StateNormal.Border.LightColor := clWhite;
		  StateNormal.Border.LightOpacity := 255;
		  StateNormal.Border.LightWidth := 1;
		  StateNormal.Border.Style := bboNone;
		  StateNormal.Border.Width := 1;
		  StateNormal.FontEx.Color := clBlack;
		  StateNormal.FontEx.EndEllipsis := False;
		  StateNormal.FontEx.FontQuality := fqSystemClearType;
		  StateNormal.FontEx.Height := 11;
		  StateNormal.FontEx.Name := 'Verdana';
		  StateNormal.FontEx.SingleLine := True;
		  StateNormal.FontEx.Shadow := False;
		  StateNormal.FontEx.ShadowColor := clBlack;
		  StateNormal.FontEx.ShadowColorOpacity := 255;
		  StateNormal.FontEx.ShadowRadius := 5;
		  StateNormal.FontEx.ShadowOffsetX := 5;
		  StateNormal.FontEx.ShadowOffsetY := 5;
		  StateNormal.FontEx.Style := [];
		  StateNormal.FontEx.TextAlignment := bcaCenter;
		  StateNormal.FontEx.WordBreak := False;
		  BorderSpacing.Around := 2;
		  Color := clNone;
		  DropDownWidth := 16;
		  DropDownArrowSize := 8;
		  GlobalOpacity := 255;
		  GlyphMargin := 4;
		  ParentColor := False;
		  Rounding.RoundX := 2;
		  Rounding.RoundY := 2;
		  Rounding.RoundOptions := [];
		  RoundingDropDown.RoundX := 1;
		  RoundingDropDown.RoundY := 1;
		  RoundingDropDown.RoundOptions := [];
		  TextApplyGlobalOpacity := False;
  end;

end;

function TEditCompany.CreateBevel(Panel: TBCPanel): TBevel;
begin
  Result := TBevel.Create(Panel);
  Result.Parent := Panel;
  Result.Align:=alLeft;
  Result.Width := 5;
  Result.BorderSpacing.Left := 80;
  Result.BorderSpacing.Top := 2;
  Result.BorderSpacing.Bottom := 2;
  Result.Shape := bsLeftLine;
end;

procedure TEditCompany.DestroyToolBar;
  procedure DeleteButton(Button: TObject);
  begin
    if not Assigned(Button) then exit;
    Button.Destroy;
    Button := nil;
  end;
begin
  DeleteButton(SeparatorBevel);
  DeleteButton(bSave);
  DeleteButton(bClose);
end;

procedure TEditCompany.Save(Sender: TObject);
var
  zq : TZQuery;
  zc: TZConnection;
  INIFile: TIniFile;
begin
  dsEmpresas.DataSet.Post;


  zc := TZConnection.Create(self);
  INIFile := TIniFile.Create(ConfigFile);
  try
    zc.Protocol := INIFile.ReadString('DataBase', 'Protocol', 'sqlite-3');
    zc.HostName := INIFile.ReadString('DataBase', 'HostName', 'localhost');
    zc.Port := INIFile.ReadInteger('DataBase', 'Port', 0);
    zc.Database := INIFile.ReadString('DataBase', 'Database', '');
    zc.User := INIFile.ReadString('DataBase', 'User', '');
    zc.Password := INIFile.ReadString('DataBase', 'Password', '');
  finally
    INIFile.Free;
  end;
  zc.Connect;

  zq := TZQuery.Create(self);
  zq.Connection := zc;

  sqlEXEC(zq,'SELECT * FROM ENTERPRISES WHERE ID=' + dsEmpresas.DataSet.FieldByName('ID').Text);

  zq.Edit;
  zq.FieldByName('NAME').Text := dsEmpresas.DataSet.FieldByName('NAME').Text;
  zq.FieldByName('ID_NUMBER').Text := dsEmpresas.DataSet.FieldByName('ID_NUMBER').Text;
  zq.FieldByName('LOGO').AsVariant := dsEmpresas.DataSet.FieldByName('LOGO1').AsVariant;
  zq.Post;
  zq.Close;
  zq.Destroy;
end;

procedure TEditCompany.CloseWindow(Sender: TObject);
begin
  DestroyToolBar;
  MainWindow.bMenu.Enabled:=true;
  MainWindow.nbPages.PageIndex:=0;
  Parent.Destroy;
end;

end.
