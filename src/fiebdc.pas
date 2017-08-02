unit FIEBDC;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, LCLProc, FileUtil, DBCtrls,
  formMainWindow, formImportDBWizard;

type
  TParseFIEBDC = class(TThread)
  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  private
    //FFile : TextFile;
    FFile: TStringList;
    FDir: string;
    FMat, FUo, FMO, FHE, FDi: integer;
    FForm: TfImportDBWizard;
    FS: TFormatSettings;
    FLines: integer;

    function parseDate(Date: string): TDate;
    function parseNumber(num: string): double;
    procedure parseRecord(Rec: string);
    procedure parseC(field: TStringList);
    procedure parseDY(field: TStringList);
    procedure parseT(field: TStringList);
    procedure parseG(field: TStringList);
  public
    constructor Create(Filename: string; Form: TfImportDBWizard);
    destructor Destroy;
  end;

implementation

uses
  Graphics,
  Utiles;

constructor TParseFIEBDC.Create(Filename: string; Form: TfImportDBWizard);

begin
  FForm := form;
  FDir := ExtractFilePath(Filename);

  FMO := 0;
  FHE := 0;
  FDi := 0;
  FMat := 0;
  FUO := 0;

  FS.DecimalSeparator := '.';
  FS.CurrencyDecimals := 2;

  FFile := TStringList.Create;
  FFile.LoadFromFile(UTF8ToSys(Filename));
  FLines := FFile.Count;

  //AssignFile(FFile, UTF8ToSys(Filename));
  //Reset(FFile);

  FreeOnTerminate := True;
  inherited Create(False); // False: empieza automáticamente
end;

procedure TParseFIEBDC.DoTerminate;
begin
  //CloseFile(FFile);
  FForm.bPause.Enabled := False;
  FForm.bStop.Enabled := False;
  FForm.ButtonPanel1.CloseButton.Enabled := True;
  inherited doTerminate;
end;

destructor TParseFIEBDC.Destroy;
begin
  DoTerminate;
end;

procedure TParseFIEBDC.Execute;
var
  //s: AnsiString;
  Line: ansistring;
  //rline: WideString;
  i: integer;

begin

  // Con TStringList
  i := 0;
  while i < FFile.Count do
  begin
    Line := UTF8ToSys(FFile[i]);
    Inc(i);
    while i < FFile.Count do
    begin
      if AnsiStartsText('~', FFile[i]) then
      begin
        Dec(i);
        break;
      end;
      Line := Line + #13 + #10 + UTF8ToSys(FFile[i]);
      Inc(i);
    end;

    parseRecord(Line);
    FForm.ProgressBar1.Position := Round(i * 100 / FLines);
    Inc(i);
  end;

  {ReadLn(FFile, s);
  i:=0;
  while not Eof(FFile) and not Terminated do
  begin
    while not Eof(FFile) do
    begin
      ReadLn(FFile, rline);
      Line := AnsiString(rline);
      if AnsiStartsText('~', Line) then break
      else s := s + #13 + #10 + line;
        end;
    parseRecord(s);
    s := Line;
    inc(i);
    FForm.ProgressBar1.Position := Round(i * 100 / FLines);
  end;}

  FForm.Memo1.Lines.Add('');
  FForm.Memo1.Lines.Add('*************************************************************');
  FForm.Memo1.Lines.Add('Cantidades totales: ');
  FForm.Memo1.Lines.Add('Materiales: ' + IntToStr(FMat - FUo));
  FForm.Memo1.Lines.Add('Unidades de obra: ' + IntToStr(FUo));

end;

{
 function TParseFIEBDC.parseDate(Date: AnsiString):TDate
 date: in the format:
     uneven len: add a Leading 0
     len = 8  DDMMYYYY
     len <= 6 DDMMYY “80/20”. >80 -> >1980 <80 -> <2080
     len < 5  MMYY
     len < 3  YY
 Test date string and return a tuple (YYYY, MM, DD)
 or None if the date format is invalid
}
function TParseFIEBDC.parseDate(Date: string): TDate;
var
  d, m, y: integer;
  len: integer;
begin
  Result := 0;
  len := Length(Date);
  if len > 8 then
    Exit;

  if len = 8 then
  begin
    d := StrToInt(Copy(Date, 1, 2));
    m := StrToInt(Copy(Date, 3, 2));
    y := StrToInt(Copy(Date, 5, 4));
  end
  else
  begin
    Y := StrToInt(Copy(Date, len - 1, 2));
    if y < 80 then
      y := 2000 + y
    else
      y := 1900 + y;
    if len = 6 then
    begin
      d := StrToInt(Copy(Date, 1, 2));
      m := StrToInt(Copy(Date, 3, 2));
    end
    else if len = 5 then
    begin
      d := StrToInt(Copy(Date, 1, 1));
      m := StrToInt(Copy(Date, 2, 2));
    end
    else if len = 4 then
    begin
      d := 0;
      m := StrToInt(Copy(Date, 1, 2));
    end
    else if len = 3 then
    begin
      d := 0;
      m := StrToInt(Copy(Date, 1, 1));
    end
    else if len = 2 then
    begin
      d := 0;
      m := 0;
    end;
  end;
  if not d in [1..31] then
    d := 0;
  if not m in [1..12] then
    m := 0;
  if m = 0 then
    d := 0;
  Result := EncodeDate(y, m, d);
end;

function TParseFIEBDC.parseNumber(num: string): double;
begin
  Result := 0;
  if num = '' then
    Exit;

  //if AnsiContainsText(num, '.') then
  //  num := AnsiReplaceText(num,'.', ',');

  Result := StrToFloatDef(num, 0, FS);
end;

procedure TParseFIEBDC.parseRecord(Rec: string);
var
  field: TStringList;
  f1: string;
begin
  Rec := Copy(Rec, 2, Length(Rec) + 1);

  field := TStringList.Create;
  field.Clear;
  field.StrictDelimiter := True;
  field.Delimiter := '|';
  field.DelimitedText := Rec;

  if AnsiContainsText(field[1], '#') then
    Exit;

  case field[0] of
    //'V': parseV(field);
    'C': parseC(field);
    'D',
    'Y': parseDY(field);
    //'M': parseM(field);
    //'N': parseN(field);
    'T': parseT(field);
    //'K': parseK(field);
    //'W': parseW(field);
    //'L': parseL(field);
    //'Q': parseQ(field);
    //'J': parseJ(field);
    'G': parseG(field);
    //'E': parseE(field);
    //'O': parseO(field);
    //'P': parseP(field);
    //'X': parseX(field);
    //'B': parseB(field);
    //'F': parseF(field);
    //'A': parseA(field);
  end;
end;

{
~C|CODIGO{\CODIGO}|[UNIDAD]|[RESUMEN]|{PRECIO\}|{FECHA\}|[TIPO]|
0- C: Record
1- Code{\Code}
2- [Unit]
3- [Summary]
4- {Price\}
5- {Date\}
6- [Type]
}
procedure TParseFIEBDC.parseC(field: TStringList);
var
  Des, PVP: double;
begin
  with FForm do
  begin
    ZQuery1.Close;
    //ZQuery1.SQL.Text:='SELECT * FROM ELEMENT ORDER BY ID DESC LIMIT 1';
    ZQuery1.SQL.Text := 'SELECT * FROM ELEMENT WHERE CODE=' + QuotedStr(field[1]);
    ZQUery1.Active := True;
    if ZQuery1.RecordCount > 0 then
      ZQuery1.Edit
    else
      ZQuery1.Append;

    ZQuery1.FieldByName('CODE').Text := field[1];
    ZQuery1.FieldByName('UNIT_ID').Text := field[2];
    ZQuery1.FieldByName('TITLE').AsString := Copy(field[3], 1, 100);
    ZQuery1.FieldByName('DESCRIPTION').Text := field[3];

    PVP := parseNumber(field[4]);

    ZQuery1.FieldByName('REAL_PRICE').AsFloat := PVP;
    ZQuery1.FieldByName('DATE_UPDATE').Text := DateToStr(parseDate(field[5]));

    case StrToInt(field[6]) of
      {0,   // Sin clasificar
      4,   // Componentes adicionales de residuo
      5:   // Clasificación de residuos
      begin
       if cbIgDI.Checked then Exit;
       des := StrToFloat(edDesDi.Text);
            ZQuery1.FieldByName('elType').Text := 'DI';
            ZQuery1.FieldByName('elDesC').Text := edDesDI.Text;
       inc(FDi);
      Memo1.Lines.Add('  - Diverso ' + field[1]);
         end;
      }
      1:   // Mano de obra
      begin
        if cbIgMO.Checked then
          Exit;
        des := StrToFloat(edDesMO.Text);
        ZQuery1.FieldByName('TYPE').Text := 'MO';
        ZQuery1.FieldByName('DISCOUNT').Text := edDesMO.Text;
        Inc(FMO);
        Memo1.Lines.Add('  - Mano de obra ' + field[1]);
      end;
      2:   // Maquinaria y medios auxiliares
      begin
        if cbIgHE.Checked then
          Exit;
        des := StrToFloat(edDesHE.Text);
        ZQuery1.FieldByName('TYPE').Text := 'HE';
        ZQuery1.FieldByName('DISCOUNT').Text := edDesHE.Text;
        Inc(FHe);
        Memo1.Lines.Add('  - Maquinaria ' + field[1]);
      end;
      3:   // Materiales
      begin
        if cbIgMA.Checked then
          Exit;
        des := StrToFloat(edDesMA.Text);
        ZQuery1.FieldByName('TYPE').Text := 'MA';
        ZQuery1.FieldByName('DISCOUNT').Text := edDesMA.Text;
        Inc(FMat);
        Memo1.Lines.Add('  - Material ' + field[1]);
      end;
      else
      begin
        if cbIgDI.Checked then
          Exit;
        des := StrToFloat(edDesDi.Text);
        ZQuery1.FieldByName('TYPE').Text := 'DI';
        ZQuery1.FieldByName('DISCOUNT').Text := edDesDI.Text;
        Inc(FDi);
        Memo1.Lines.Add('  - Diverso ' + field[1]);
      end;
    end;
    ZQuery1.FieldByName('PURCHASE_PRICE').AsFloat := (PVP * (1 - des / 100));
    ZQuery1.FieldByName('TAX').Text := '0';
    ZQuery1.FieldByName('MANUFACTURER').Text := eFabricante.Text;
    ZQuery1.FieldByName('STATE').AsBoolean := False;
    ZQuery1.Post;

    // Guardar la unidad:
    {INSERT INTO TABLE_1 (COL_1,COL_2)
    SELECT 'COL1 VALUE', 'COL2 VALUE'
    WHERE NOT EXISTS (SELECT * FROM TABLE_1 WHERE COL1='COL1 VALUE');

    INSERT INTO table_listnames (name, address, tele)
    SELECT * FROM (SELECT 'Rupert', 'Somewhere', '022') AS tmp
    WHERE NOT EXISTS (
        SELECT name FROM table_listnames WHERE name = 'Rupert'
    ) LIMIT 1;
    }
    {sqlEXEC(ZQuery1, 'INSERT INTO UNIT(ID, DESCRIPTION) ' +
                     'SELECT ' + QuotedStr(field[2]) + ', ' + QuotedStr(field[2]) + ' ' +
                     'WHERE NOT EXISTS (' +
                     'SELECT * FROM UNIT WHERE UNIT.ID = ' + QuotedStr(field[2]) +')');}


    ZQuery1.SQL.Clear;
    ZQuery1.SQL.Add('INSERT IGNORE INTO UNIT (ID, DESCRIPTION) VALUES (' +
      QuotedStr(field[2]) + ', ' + QuotedStr(field[2]) + ')');
    ZQuery1.ExecSQL;
  end;
end;

{
~D|CODIGO_PADRE|<CODIGO_HIJO\[FACTOR]\[RENDIMIENTO]\>|<CODIGO_HIJO\[FACTOR]\[RENDIMIENTO]\{CODIGO_PORCENTAJE;}\>|
~Y|CODIGO_PADRE|<CODIGO_HIJO\[FACTOR]\[RENDIMIENTO]\>|<CODIGO_HIJO\[FACTOR]\[RENDIMIENTO]\{CODIGO_PORCENTAJE;}\>|
0- D or Y: DECOMPOSITION or ADD DECOMPOSITION
1- Parent Code
2- <Child Code\ [Factor]\ [Yield]>
}
procedure TParseFIEBDC.parseDY(field: TStringList);
var
  i, con: integer;
  Child: TStringList;
begin
  Child := TStringList.Create;
  Child.Clear;
  Child.StrictDelimiter := True;
  Child.Delimiter := '\';
  Child.DelimitedText := field[2];

  con := Child.Count div 3;
  with FForm do
  begin
    sqlEXEC(ZQuery1, 'SELECT * FROM ELEMENT WHERE CODE = ' + QuotedStr(field[1]));
    ZQuery1.Edit;

    ZQuery1.FieldByName('TYPE').Text := 'UO';
    ZQuery1.Post;

    //sqlEXEC(ZQuery1, 'SELECT * FROM ELEMENTCOMPOSITION ORDER BY CREATEDAT DESC LIMIT 1');
    for i := 0 to con - 1 do
    begin
      //ZQuery1.Append;
      // +++++++++++++++++++++++++++++++++
      sqlEXEC(ZQuery1, 'SELECT * FROM ELEMENTCOMPOSITION WHERE CODE=' +
        QuotedStr(field[1]) + ' AND NORDER = ' + IntToStr(i));
      if ZQuery1.RecordCount > 0 then
        ZQuery1.Edit
      else
        ZQuery1.Append;
      // +++++++++++++++++++++++++++++++++

      ZQuery1.FieldByName('NORDER').AsInteger := i;
      ZQuery1.FieldByName('CODE').Text := field[1];
      ZQuery1.FieldByName('ELEMENT_CODE').Text := Child[i * 3];
      ZQuery1.FieldByName('ELEMENT_AMOUNT').AsFloat := parseNumber(Child[2 + i * 3]);
      ZQuery1.Post;
    end;
  end;

  Inc(FUo);
  FForm.Memo1.Lines.Add('    |---- Unidad de obra: ' + field[1]);
end;

{
~T|CODIGO_CONCEPTO|TEXTO_DESCRIPTIVO|
0- T: Text
1- Record code
2- Description text
}
procedure TParseFIEBDC.parseT(field: TStringList);
begin
  with FForm do
  begin
    ZQuery1.Close;
    ZQuery1.SQL.Text := 'SELECT * FROM ELEMENT WHERE CODE = "' + field[1] + '"';
    ZQUery1.Active := True;
    ZQuery1.Edit;

    ZQuery1.FieldByName('DESCRIPTION').Text := field[2];
    ZQuery1.Post;
  end;
end;

{
~G|CODIGO_CONCEPTO|<ARCHIVO_GRAFICO.EXT\>|[URL_EXT]|
0- G: Grafic info
1- record code
2- <grafic_file.ext\>
}
procedure TParseFIEBDC.parseG(field: TStringList);
var
  Images: TStringList;
  Picture: TPicture;
begin
  Images := TStringList.Create;
  Images.Clear;
  Images.StrictDelimiter := True;
  Images.Delimiter := '\';
  Images.DelimitedText := field[2];

  if not FileExists(FDir + Images[0]) then
    exit;

  with FForm do
  begin
    sqlEXEC(ZQuery1, 'SELECT * FROM ELEMENT WHERE CODE = ' + QuotedStr(field[1]));
    if ZQuery1.RecordCount > 0 then
      Exit; // actualizar??
    ZQuery1.Edit;

    Picture := TPicture.Create;
    try
      Picture.LoadFromFile(FDir + Images[0]);
      StorePicture(Picture, zQuery1, 'IMAGE');
      ZQuery1.Post;
    finally
      Picture.Free;
    end;
  end;
end;

end.
