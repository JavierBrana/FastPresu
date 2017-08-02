unit formOpenCompany;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCPanel, CustomNiceListBox, ZDataset, Forms,
  Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons, types;

type

  { TOpenCompanyWindow }

  TOpenCompanyWindow = class(TForm)
    bAcept: TBitBtn;
    edName: TLabeledEdit;
    edPassWord: TLabeledEdit;
    Panel2: TPanel;
    pError: TBCPanel;
    BitBtn2: TBitBtn;
    lbEnterpriseName1: TLabel;
    lbListCompanies: TListBox;
    Notebook: TNotebook;
    Page1: TPage;
    Page2: TPage;
    pButtonPanel: TPanel;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    ztEmpresas: TZTable;
    procedure bAceptClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbListCompaniesDblClick(Sender: TObject);
    procedure lbListCompaniesDrawItem(Control: TWinControl; Index: integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure lbListCompaniesKeyPress(Sender: TObject; var Key: char);
    procedure lbListCompaniesSelectionChange(Sender: TObject; User: boolean);
    procedure Page2BeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { private declarations }
    FName: string;
    FCIF: string;
    FDate: String;
    FDB: String;
    FIdx: Integer;

    function OpenCompany: boolean;
  public
    { public declarations }
  end;

var
  OpenCompanyWindow: TOpenCompanyWindow;

implementation
uses
  //Blowunit,
  formMainWindow, Utiles, DB, LCLType, u_variables;

{$R *.lfm}

{ TOpenCompanyWindow }

procedure TOpenCompanyWindow.FormShow(Sender: TObject);
var
  s: TStream;
  GraphExt: string;
  gc: TGraphicClass;
  AGraphic: TGraphic;
begin
  Enabled := true;
  Notebook.PageIndex := 0;
  edName.Text:='';
  edPassword.Text:='';

  ztEmpresas.Connection := MainWindow.zcMainConnection;
  ztEmpresas.TableName := 'ENTERPRISES';
  ztEmpresas.Active := True;
  ztEmpresas.First;

  while not ztEmpresas.EOF do
  begin
    try
      s := ztEmpresas.CreateBlobStream(ztEmpresas.FieldByName('LOGO'), bmRead);
      AGraphic := nil;
      if s.Size <> 0 then
      begin
        GraphExt := s.ReadAnsiString;  //Read file extension Graphic type from stream
        gc := GetGraphicClassForFileExtension(GraphExt);
        if assigned(gc) then
        begin
          AGraphic := gc.Create;
          AGraphic.LoadFromStream(s);
        end;
      end;
      lbListCompanies.Items.AddObject(ztEmpresas.FieldByName('NAME').Text +
        '|' + ztEmpresas.FieldByName('ID_NUMBER').Text + '|' +
        ztEmpresas.FieldByName('CREATEDAT').Text + '|' +
        ztEmpresas.FieldByName('DBNAME').Text,
        AGraphic);
    finally
    end;
    ztEmpresas.Next;
  end;
  lbListCompanies.ItemIndex := 0;
end;

procedure TOpenCompanyWindow.lbListCompaniesDblClick(Sender: TObject);
var
  localPoint: TPoint;
  yy: integer;
begin
  localPoint := lbListCompanies.ScreenToClient(Mouse.CursorPos);
  yy := lbListCompanies.ItemAtPos(localPoint, True);
  if yy > -1 then
    OpenCompany;
end;

procedure TOpenCompanyWindow.lbListCompaniesDrawItem(Control: TWinControl;
  Index: integer; ARect: TRect; State: TOwnerDrawState);
var
  Offset, yy: integer;
  AGraphic: TGraphic;
  rec: TRect;
  fromColor, toColor: TColor;
  sList: TStringList;
begin
  Offset := 0;

  sList := TStringList.Create;
  sList.Clear;
  sList.StrictDelimiter := True;
  sList.Delimiter := '|';
  sList.DelimitedText := lbListCompanies.Items[Index];

  with lbListCompanies.Canvas do
  begin
    // Rellenar
    Brush.Style := bsSolid;
    Brush.Color := clWhite;
    Pen.Style := psSolid;
    FillRect(ARect);
    // Dibujar
    if odSelected in State then
    begin
      fromColor := TColor($FEF7F1);
      toColor := TColor($FEE9D8);//($CCE0FA)
    end
    else
    begin
      fromColor := TColor($FFFFFF);
      toColor := TColor($FAF3EE);
    end;

    //InflateRect(ARect, -2, -6);
    GradientFill(ARect, fromColor, toColor, gdVertical);
    //Brush.Style:=bsClear;
    //Rectangle(ARect);

    try
      AGraphic := TGraphic(lbListCompanies.Items.Objects[Index]);
      rec := ARect;
      rec.Right := rec.Left + lbListCompanies.ItemHeight;
      InflateRect(rec, -3, -3);

      {fRe := AGraphic.Width / AGraphic.Height;
      if AGraphic.Width > AGraphic.Height then
      begin
        offset1 := Round((rec.Top - rec.Bottom)/(2*fRe));
        rec.Top := rec.Top - offset1;
        rec.Bottom:= rec.Bottom + offset1;
            end;}

      StretchDraw(rec, AGraphic);
      Offset := rec.Right + 8;
    finally
    end;

    { display the text }
    Brush.Style := bsClear;
    // Name
    Font.Color := clBlack;
    Font.Size := 12;
    Font.Style := [fsBold];
    TextOut(ARect.Left + Offset, ARect.Top + 2, sList[0]);
    // NIF
    YY := TextHeight(sList[0]);
    Font.Size := 8;
    Font.Style := [];
    Font.Color := clGray;
    TextOut(ARect.Left + Offset, ARect.Top + YY + 4, sList[1]);
    // Fecha
    YY := YY + lbListCompanies.Canvas.TextHeight(sList[1]);
    TextOut(ARect.Left + Offset, ARect.Bottom - 2 - TextHeight(sList[2]), sList[2]);
  end;
  sList.Free;
end;

procedure TOpenCompanyWindow.lbListCompaniesKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then OpenCompany;
end;

procedure TOpenCompanyWindow.lbListCompaniesSelectionChange(Sender: TObject;
  User: boolean);
var
 sList: TStringList;
begin
  sList := TStringList.Create;
  try
    sList.Clear;
    sList.StrictDelimiter := True;
    sList.Delimiter := '|';
    sList.DelimitedText := lbListCompanies.Items[lbListCompanies.ItemIndex];
    FName := sList[0];
    FCIF := sList[1];
    FDate := sList[2];
    FDB := sList[3];
    FIdx := lbListCompanies.ItemIndex;
  finally
    sList.Free;
  end;
end;

procedure TOpenCompanyWindow.Page2BeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: Integer);
begin
  //lbEnterpriseName.Caption := FName;
  //lbEnterpriseCIF.Caption := FCIF;
end;

procedure TOpenCompanyWindow.Timer1Timer(Sender: TObject);
begin
  Timer3.Enabled := true;
  pError.Caption := '';
  Timer1.Enabled := false;
end;

procedure TOpenCompanyWindow.Timer2Timer(Sender: TObject);
begin
  Height := Height - 10;
  Top := Top + 5;

  if Height <= 260 then
    Timer2.Enabled := false;
end;

procedure TOpenCompanyWindow.Timer3Timer(Sender: TObject);
begin
  if pError.tag = 1 then
    if pError.Height < 65 then pError.Height := pError.Height + 5
    else
    begin
      pError.tag := 0;
      Timer3.Enabled := false;
    end
  else
    if pError.Height > 0 then pError.Height := pError.Height - 5
    else
    begin
      pError.tag := 1;
      Timer3.Enabled := false;
    end
end;

procedure TOpenCompanyWindow.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  ztEmpresas.Active := False;
  CloseAction := caFree;
  OpenCompanyWindow := nil;
  MainWindow.SetFocus;
end;

procedure TOpenCompanyWindow.FormCreate(Sender: TObject);
begin
  Width := 400;
  Height := 400;
  Timer1.Enabled := false;
end;

procedure TOpenCompanyWindow.bAceptClick(Sender: TObject);
begin
  Hide;
  OpenCompany;
end;

procedure TOpenCompanyWindow.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

function TOpenCompanyWindow.OpenCompany: boolean;
var
  database: ansistring;
  sList: TStringList;
  ZQ: TZQuery;
  RecordCount: Integer;
begin

  case Notebook.PageIndex of
    0:
    begin
      if MainWindow.zcMainConnection.Protocol = 'sqlite-3' then
        Database := DefaultDir + FDB + '.db';

      if MainWindow.SetDataBase(FDB, FName) then
      begin
        ZQ := TZQuery.Create(self);
        try
          ZQ.Connection := MainWindow.zcMainConnection;
          sqlEXEC(ZQ, 'SELECT USERNAME, PASSWORD FROM USERS');
          if (ZQ.RecordCount < 2) and (ZQ.FieldByName('PASSWORD').Text = '') then
          begin
            MainWindow.SetUser('ADMIN');
            ModalResult := mrOk;
            Result := True;
            Close;
          end
          else
          begin
            Notebook.PageIndex := 1;
            Timer2.Enabled := true;
            edName.SetFocus;
            Result := false;
          end;
        finally
          ZQ.Free;
        end;
      end;
    end;
    1:
    begin
      ZQ := TZQuery.Create(self);
      try
        ZQ.Connection := MainWindow.zcMainConnection;
        sqlEXEC(ZQ, 'SELECT USERNAME, PASSWORD FROM USERS WHERE USERNAME = ' +
                    QuotedStr(edName.Text));
        if (ZQ.RecordCount = 0) then
        begin
          Result := false;
          pError.Caption := 'Usuario no encontrado';
          pError.Visible := true;
          Timer1.Enabled := true;
          Timer3.Enabled := true;
          edName.SetFocus;
        end
        else if ZQ.FieldByName('PASSWORD').AsString <> edPassword.Text then
        begin
          Result := false;
          pError.Caption := 'Password Incorrecto';
          pError.Visible := true;
          Timer1.Enabled := true;
          edPassWord.SetFocus;
        end
        else
        begin
          MainWindow.SetUser(ZQ.FieldByName('USERNAME').AsString);
          ModalResult := mrOk;
          Result := True;
          Close;
        end;
      finally
        ZQ.Free;
      end;
    end;
  end;
end;

end.


