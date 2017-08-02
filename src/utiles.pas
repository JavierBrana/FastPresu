unit Utiles;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, DB, DBGrids, Controls,
  StrUtils, LCLProc, StdCtrls, FileUtil, DBCtrls, Graphics,
  gsGantt, NiceGrid;

type
  TDocumentOperations = (doNew, doCopy, doEdit);

  TDeleteDBItem = class(TThread)
  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  private
    FGrid: TDBGrid;
  public
    constructor Create(Grid: TDBGrid);
    //destructor Destroy;
  end;

  TOpenDB = class(TThread)
  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  private
    FZQ: TZTable;
  public
    constructor Create(ZQuery: TZTable);
  end;

  { TMyDragObject }

  TMyDragObject = class(TDragControlObject)
  private
    FDragImages: TDragImageList;
  protected
    function GetDragImages: TDragImageList; override;
  public
    constructor Create(AControl: TControl); override;
    destructor Destroy; override;
  end;


// Funciones generales:
function LoadGantt(aGantt: TgsGantt; aDocCode: string; aParent: TInterval = nil): integer;
procedure SaveGantt(aGantt: TgsGantt; aDocCode, aTitle: string; aChangeMilestones: boolean);

procedure StorePicture(Picture: TPicture; ZQ: TZQuery; field: string);

procedure sqlEXEC(ZQ: TZQuery; Dato: ansistring; NeedConnection:  boolean = true);
function CheckIBAN(iban: string): boolean;

function cifrar(cadena, Key: string): string;
function descifrar(cadena, Key: string): string;

function IncStr(Str: string; Amount: integer; Index: integer = -1): string;
function IncStr2(Str: string; Amount: integer; Index: integer = -1): string;
procedure SetImageToRow(aType: string; aRow:TNiceRow);


{$IFDEF DEBUG}
procedure dgSetLine(aDato: string);
{$ENDIF}


implementation

uses
  {$IFDEF DEBUG}
  FormDebug,
  {$ENDIF}
  formMainWindow;

constructor TDeleteDBItem.Create(Grid: TDBGrid);
begin
  inherited Create(False); // False: empieza automáticamente
  FGrid := Grid;
end;

procedure TDeleteDBItem.DoTerminate;
begin
  inherited doTerminate;
end;

procedure TDeleteDBItem.Execute;
var
  ZQ: TZQuery;
  code: string;
  i: integer;
begin
  ZQ := TZQuery.Create(nil);
  ZQ.Connection := MainWindow.zcMainConnection;

  for i := 0 to FGrid.SelectedRows.Count - 1 do
  begin
    FGrid.DataSource.DataSet.GotoBookmark(FGrid.SelectedRows.Items[i]);
    code := FGrid.DataSource.DataSet.FieldByName('elCode').Text;
    if code = '' then
      break;

    code := FGrid.DataSource.DataSet.FieldByName('elCode').Text;
    if FGrid.DataSource.DataSet.FieldByName('elType').Text = 'UO' then
      sqlEXEC(ZQ, 'DELETE FROM ElementComp WHERE ecuoID = ' + QuotedStr(code));

    FGrid.DataSource.DataSet.Delete;
  end;
  FGrid.SelectedRows.Clear;
end;

constructor TOpenDB.Create(ZQuery: TZTable);
begin
  inherited Create(False); // False: empieza automáticamente
  FZQ := ZQuery;
end;

procedure TOpenDB.DoTerminate;
begin
  inherited doTerminate;
end;

procedure TOpenDB.Execute;
begin
  FZQ.Active := True;

end;

{ TMyDragObject }

function TMyDragObject.GetDragImages: TDragImageList;
begin
  Result := FDragImages;
end;

constructor TMyDragObject.Create(AControl: TControl);
var
  Bitmap: TBitmap;
  i: integer;
  rc: TRect;
begin
  if not AControl.ClassNameIs('TDBGrid') then Exit;

  inherited Create(AControl);
  FDragImages := TDragImageList.Create(AControl);
  AlwaysShowDragImages := True;

  Bitmap := TBitmap.Create;

  if TDBGrid(AControl).SelectedRows.Count > 1 then
  begin
    Bitmap.Width := TDBGrid(AControl).CellRect(1, 0).Right - TDBGrid(AControl).CellRect(1, 0).Left;
    for i := 0 to TDBGrid(AControl).SelectedRows.Count - 1 do
    begin
      rc := TDBGrid(AControl).CellRect(1, TDBGrid(AControl).SelectedRows.IndexOf(TDBGrid(AControl).SelectedRows.Items[i]));
      bitmap.Height := bitmap.Height + rc.Bottom - rc.Top;
      (AControl as TWinControl).PaintTo(Bitmap.Canvas, rc.Top, rc.Left);
    end;
  end
  else
  begin
    rc := TDBGrid(AControl).CellRect(1, 1);
    bitmap.Width := rc.Right;// - rc.Left;
    bitmap.Height := rc.Bottom;// - rc.Top;
    (AControl as TWinControl).PaintTo(Bitmap.Canvas, -10, -10);
  end;

  //Bitmap.Width := AControl.Width;
  //Bitmap.Height := AControl.Height;
  //if AControl is TWinControl then
  //  (AControl as TWinControl).PaintTo(Bitmap.Canvas, 0, 0);
  FDragImages.Width := Bitmap.Width;
  FDragImages.Height := Bitmap.Height;
  FDragImages.Add(Bitmap, nil);
  FDragImages.DragHotspot := Point(-10 , -10);
  Bitmap.Free;
end;

destructor TMyDragObject.Destroy;
begin
  FDragImages.Free;
  inherited Destroy;
end;


{FUNCTIONS}

procedure sqlEXEC(ZQ: TZQuery; Dato: ansistring; NeedConnection:  boolean);
begin
  ZQ.SQL.Clear;
  ZQ.SQL.Text := Dato;
  {try
    ZQ.Open;
  except on E:Exception do
    Exit;
  end;}

  {if ZQ.State = dsInactive then
    ZQ.Open
  else
    ZQ.ExecSQL;}

  if NeedConnection then ZQ.Open
  else ZQ.ExecSQL;

end;

function LoadGantt(aGantt: TgsGantt; aDocCode: string; aParent: TInterval): integer;
var
  conList: TStringList;
  zqGantt: TZQuery;

  procedure LoadTask;
  var
    i: integer;
    command: string;
    aTask: TInterval;
    aList: TList;
    ZQ: TZQuery;
    Res: TResource;
  begin
    aTask := TInterval.Create(aGantt);

    aTask.Id := zqGantt.FieldByName('TASK_ID').Text;
    aTask.Task := zqGantt.FieldByName('SUMMARY').Text;

    aTask.Project := zqGantt.FieldByName('PROJECTID').Text;

    aTask.StartDate := zqGantt.FieldByName('STARTDATE').AsDateTime;
    aTask.FinishDate := zqGantt.FieldByName('FINISHDATE').AsDateTime;
    aTask.Earliest := zqGantt.FieldByName('EARLIEST').AsDateTime;
    aTask.Duration := zqGantt.FieldByName('DURATION').AsDateTime;
    aTask.NetDuration := zqGantt.FieldByName('NETDURATION').AsDateTime;
    aTask.NetTime := zqGantt.FieldByName('NETTIME').AsDateTime;
    aTask.WaitTime := zqGantt.FieldByName('WAITTIME').AsDateTime;
    aTask.IntervalDone := zqGantt.FieldByName('PERCENT').AsDateTime;

    aTask.Started := zqGantt.FieldByName('STARTED').AsBoolean;
    aTask.DepDone := zqGantt.FieldByName('DEPDONE').AsBoolean;
    aTask.Visible := zqGantt.FieldByName('VISIBLE').AsBoolean;
    aTask.Opened := zqGantt.FieldByName('OPENED').AsBoolean;
    aTask.DontChange := zqGantt.FieldByName('DONTCHANGE').AsBoolean;
    aTask.Resource := zqGantt.FieldByName('RESOURCE').Text;
    aTask.ResourceTimePerDay := zqGantt.FieldByName('RESOURCEPERDAY').AsFloat;
    aTask.Color := zqGantt.FieldByName('COLOR').AsInteger;
    aTask.Fixed := zqGantt.FieldByName('FIXED').AsBoolean;

    // Load connections
    ZQ := TZQuery.Create(nil);
    ZQ.Connection := MainWindow.zcMainConnection;

    sqlEXEC(ZQ, 'SELECT * FROM TASKCONNECTIONS WHERE TASK_ID = ' + QuotedStr(aTask.Id));
    ZQ.First;
    while not ZQ.EOF do
    begin
      conList.Add(string(aTask.Id) + '|' + ZQ.FieldByName('TASK_ID_CONNECTION').Text);
      ZQ.Next;
    end;

    // Load Resources:
    sqlEXEC(ZQ, 'SELECT * FROM TASKRESOURCES WHERE TASK_ID = ' + QuotedStr(aTask.Id));
    ZQ.First;
    while not ZQ.EOF do
    begin
      Res := TResource.Create(aTask);
      Res.ResourceName := ZQ.FieldByName('NAME').Text;
      //Res.ResourceType := TResourceType(ZQ.FieldByName('TYPE').AsInteger);
      Res.ResourceDuration := ZQ.FieldByName('DURATION').AsDateTime;
      Res.ResourceQuantity := ZQ.FieldByName('QUANTITY').AsFloat;
      Res.ResourceCost := ZQ.FieldByName('COST').AsFloat;
      aTask.AddResource(Res);
      ZQ.Next;
    end;
    ZQ.Free;

    // Añadir al padre adecuado:
    if zqGantt.FieldByName('PARENT').Text <> '' then
    begin
      aList := TList.Create;
      aGantt.MakeIntervalList(aList);
      for i := 0 to aList.Count - 1 do
        if TInterval(aList[i]).Id = zqGantt.FieldByName('PARENT').Text then
        begin
          TInterval(aList[i]).AddInterval(aTask);
          break;
        end;
      aList.Free;
    end
    else if not assigned(aParent) then
      aGantt.AddInterval(aTask)
    else
      aParent.AddInterval(aTask);

    aTask.Changed := False;
  end;


  procedure loadConnections(aTask, aConnection: string);
  var
    i, j: integer;
    aList: TList;
  begin
    aList := TList.Create;
    aGantt.MakeIntervalList(aList);
    for i := 0 to aList.Count - 1 do
    begin
      if TInterval(aList[i]).Id = aTask then
      begin
        for j := 0 to aList.Count - 1 do
        begin
          if TInterval(aList[j]).Id = aConnection then
          begin
            TInterval(aList[i]).AddConnection(TInterval(aList[j]), False);
            aList.Free;
            Exit;
          end;
        end;
      end;
    end;
    aList.Free;
  end;

var
  i: integer;
  sList: TStringList;
begin
  zqGantt := TZQuery.Create(nil);
  zqGantt.Connection := MainWindow.zcMainConnection;

  conList := TStringList.Create;
  sqlEXEC(zqGantt, 'SELECT * FROM TASK WHERE PROJECTID = ' + QuotedStr(aDocCode));
  zqGantt.First;
  while not zqGantt.EOF do
  begin
    LoadTask;
    zqGantt.Next;
  end;

  for i := 0 to conList.Count - 1 do
  begin
    sList := TStringList.Create;
    sList.Clear;
    sList.StrictDelimiter := True;
    sList.Delimiter := '|';
    sList.DelimitedText := conList[i];
    loadConnections(sList[0], sList[1]);
    sList.Free;
  end;

  conList.Free;
  Result := zqGantt.RecordCount;
  zqGantt.Free;
end;

procedure SaveGantt(aGantt: TgsGantt; aDocCode, aTitle: string;
  aChangeMilestones: boolean);
var
  aStart: TDateTime;
  aEnd: extended;
  zqGantt: TZQuery;

  procedure ChangeTask(aTask: TInterval);
  var
    i: integer;
    aList: TStringList;
    command: string;
  begin
    sqlEXEC(zqGantt, 'SELECT * FROM TASK WHERE TASK_ID = ' + QuotedStr(aTask.Id));
    if zqGantt.RecordCount > 0 then
      zqGantt.Edit
    else
      zqGantt.Append;

    zqGantt.FieldByName('TASK_ID').Text := aTask.Id;
    if assigned(aTask.Parent) then
      zqGantt.FieldByName('PARENT').Text := aTask.Parent.Id;
    zqGantt.FieldByName('SUMMARY').Text := aTask.Task;

    zqGantt.FieldByName('PROJECTID').Text := aTask.Project;
    zqGantt.FieldByName('PROJECT').Text := aTitle;

    zqGantt.FieldByName('HASCHILDS').AsBoolean := aTask.HasChilds;
    //PercentMaked := (aTask.FinishDate - aTask.IntervalDone) * 100 / (aTask.FinishDate - aTask.StartDate);

    zqGantt.FieldByName('STARTDATE').AsDateTime := aTask.StartDate;
    zqGantt.FieldByName('FINISHDATE').AsDateTime := aTask.FinishDate;
    zqGantt.FieldByName('EARLIEST').AsDateTime := aTask.Earliest;
    zqGantt.FieldByName('DURATION').AsDateTime := aTask.Duration;
    zqGantt.FieldByName('NETDURATION').AsDateTime := aTask.NetDuration;
    zqGantt.FieldByName('NETTIME').AsDateTime := aTask.NetTime;
    zqGantt.FieldByName('WAITTIME').AsDateTime := aTask.WaitTime;
    zqGantt.FieldByName('PERCENT').AsDateTime := aTask.IntervalDone;

    zqGantt.FieldByName('STARTED').AsBoolean := aTask.Started;
    zqGantt.FieldByName('DEPDONE').AsBoolean := aTask.DepDone;
    zqGantt.FieldByName('VISIBLE').AsBoolean := aTask.Visible;
    zqGantt.FieldByName('OPENED').AsBoolean := aTask.Opened;
    zqGantt.FieldByName('DONTCHANGE').AsBoolean := aTask.DontChange;
    zqGantt.FieldByName('RESOURCE').Text := aTask.Resource;
    zqGantt.FieldByName('RESOURCEPERDAY').AsFloat := aTask.ResourceTimePerDay;
    zqGantt.FieldByName('COLOR').AsInteger := aTask.Color;
    zqGantt.FieldByName('FIXED').AsBoolean := aTask.Fixed;
    zqGantt.FieldByName('COMPLETE').AsBoolean := False;
    zqGantt.FieldByName('CREATEDAT').AsDateTime := Date;

    zqGantt.Post;

    // Cambiar conexiones
    aList := TStringList.Create;
    for i := 0 to aTask.ConnectionCount - 1 do
    begin
      aList.Add(aTask.Connection[i].Id);
      sqlEXEC(zqGantt, 'SELECT * FROM TASKCONNECTIONS WHERE TASK_ID = ' +
        QuotedStr(aTask.Id) + ' AND TASK_ID_CONNECTION = ' +
        QuotedStr(aTask.Connection[i].Id));

      if zqGantt.RecordCount > 0 then
        continue; // Si existe no hace falta modificarlo
      zqGantt.Append;
      zqGantt.FieldByName('PROJECTID').Text := aTask.Project;
      zqGantt.FieldByName('TASK_ID').Text := aTask.Id;
      zqGantt.FieldByName('TASK_ID_CONNECTION').Text := aTask.Connection[i].Id;
      zqGantt.Post;
    end;

    command := 'DELETE FROM TASKCONNECTIONS WHERE TASK_ID = ' + QuotedStr(aTask.Id);
    for i := 0 to aList.Count - 1 do
    begin
      command := command + ' AND NOT TASK_ID_CONNECTION = ' + QuotedStr(aList[i]);
    end;
    sqlEXEC(zqGantt, command, false);

    // Salvar resources
    {
    aList.Clear;
    for i := 0 to aTask.ConnectionCount - 1 do
    begin
      aList.Add(aTask.re);
      sqlEXEC(zqGantt, 'SELECT * FROM TASKRESOURCES WHERE TASK_ID = ' + QuotedStr(aTask.Id) +
                       ' AND NAME = ' + QuotedStr(aTask.Connection[i].Id));

      if zqGantt.RecordCount > 0 then zqGantt.Edit
      else zqGantt.Append;
      zqGantt.FieldByName('PROJECTID').Text := aTask.Project;
      zqGantt.FieldByName('TASK_ID').Text := aTask.Id;
      zqGantt.FieldByName('TASK_ID_CONNECTION').Text := aTask.Connection[i].Id;
      zqGantt.Post;
    end;
    command := 'DELETE FROM TASKCONNECTIONS WHERE TASK_ID = '  + QuotedStr(aTask.Id);
    for i := 0 to aList.Count - 1 do
    begin
      command := command + ' AND NOT TASK_ID_CONNECTION = ' + QuotedStr(aList[i]);
    end;
    sqlEXEC(zqGantt, command);
    }
    aList.Free;
  end;

  procedure RecoursiveChange(aParent: TInterval);
  var
    i: integer;
  begin
    if aParent.Changed then
      ChangeTask(aParent);
    for i := 0 to aParent.IntervalCount - 1 do
    begin
      if aParent.Interval[i].Changed then
      begin
        ChangeTask(aParent.Interval[i]);
      end;
      if aParent.Interval[i].StartDate < aStart then
        aStart := aParent.Interval[i].StartDate;
      if aParent.Interval[i].FinishDate > aEnd then
        aEnd := aParent.Interval[i].FinishDate;
      RecoursiveChange(aParent.Interval[i]);
    end;
  end;

  procedure PrepareTask(aParent: TInterval; idx: string);
  var
    i: integer;
    aID: string;
  begin
    aID := aDocCode + '-' + idx;
    if string(aParent.Id) <> aID then
      aParent.Id := aID;
    if aParent.Project <> aDocCode then
      aParent.Project := aDocCode;

    for i := 0 to aParent.IntervalCount - 1 do
    begin
      PrepareTask(aParent.Interval[i], idx + '.' + IntToStr(i + 1));
    end;
  end;

var
  i: integer;
begin
  zqGantt := TZQuery.Create(nil);
  zqGantt.Connection := MainWindow.zcMainConnection;

  for i := 0 to aGantt.IntervalCount - 1 do
    PrepareTask(aGantt.Interval[i], IntToStr(i + 1));

  aStart := trunc(Now()) + 10000;
  aEnd := trunc(Now()) - 10000;
  for i := 0 to aGantt.IntervalCount - 1 do
    RecoursiveChange(aGantt.Interval[i]);

end;

function ChangeAlpha(input: string): string;
  // A -> 10, B -> 11, C -> 12 ...
var
  a: char;
begin
  Result := input;
  for a := 'A' to 'Z' do
  begin
    Result := StringReplace(Result, a, IntToStr(Ord(a) - 55), [rfReplaceAll]);
  end;
end;

function CalculateDigits(iban: string): integer;
var
  v, l: integer;
  alpha: string;
  number: longint;
  rest: integer;
begin
  iban := UpperCase(iban);
  if Pos('IBAN', iban) > 0 then
    Delete(iban, Pos('IBAN', iban), 4);
  iban := iban + Copy(iban, 1, 4);
  Delete(iban, 1, 4);
  iban := ChangeAlpha(iban);
  v := 1;
  l := 9;
  rest := 0;
  alpha := '';
  try
    while v <= Length(iban) do
    begin
      if l > Length(iban) then
        l := Length(iban);
      alpha := alpha + Copy(iban, v, l);
      number := StrToInt(alpha);
      rest := number mod 97;
      v := v + l;
      alpha := IntToStr(rest);
      l := 9 - Length(alpha);
    end;
  except
    rest := 0;
  end;
  Result := rest;
end;

function CheckIBAN(iban: string): boolean;
begin
  iban := StringReplace(iban, ' ', '', [rfReplaceAll]);
  if CalculateDigits(iban) = 1 then
    Result := True
  else
    Result := False;
end;

procedure StorePicture(Picture: TPicture; ZQ: TZQuery{TDataSource}; field: string);
var
  s: TStream;
  fe: string;
  i: integer;
begin
  if assigned(Picture.Graphic) then
  begin
    if (Picture.Graphic.Empty) then
      Exit;

    fe := Picture.Graphic.GetFileExtensions;
    s := ZQ.CreateBlobStream(ZQ.FieldByName(field), bmWrite);
    try
      i := pos(';', fe);
      if i > 0 then
        fe := copy(fe, 1, i - 1);
      s.WriteAnsiString(fe);  //otherwise write file extension to stream
      Picture.Graphic.SaveToStream(s);
    finally
      s.Free;
    end;
  end;
end;

function cifrar(cadena, Key: string): string;
var
  i, j: integer;
  temp: integer;
  algo: integer;
begin
  Result := '';
  for i := 1 to Length(cadena) do
  begin
    for j := 1 to length(key) do
    begin
      temp := temp + Ord(key[i]) + j mod i;
    end;
    Randseed := temp * i + length(cadena);
    if i mod 2 = 0 then
      Result := Result + Chr(Ord(cadena[i]) xor (temp * i + random(512) + length(cadena)) + i)
    else
    begin
      algo := RandSeed;
      algo := (algo * i * random(1024) - length(cadena)) - algo;
      algo := ord(cadena[i]) xor algo;
      Result := Chr(algo);

      Result := Result + Chr(Ord(cadena[i]) xor  algo);
        //(Randseed * i * random(1024) - length(cadena)) - Randseed);
    end;
  end;
end;

function descifrar(cadena, Key: string): string;
var
  i, j: integer;
  temp: integer;
begin
  Result := '';
  for i := 1 to Length(cadena) do
  begin
    for j := 1 to length(key) do
    begin
      temp := temp + Ord(key[i]) + j mod i;
    end;
    Randseed := temp * i + length(cadena);
    if i mod 2 = 0 then
      Result := Result + Chr((Ord(cadena[i]) - i) xor (temp * i + random(512) + length(cadena)))
    else
      Result := Result + Chr((Ord(cadena[i]) + randseed) xor
        (randseed * i * random(1024) - length(cadena)));
  end;
end;

function IncStr(Str: string; Amount: integer; Index: integer = -1): string;
const
  MIN_VAL = 48; //65 'A'  48 = '0'
  MAX_VAL = 90; //90 'Z'
  //numbers = ['0'..'9']
  //LLetters = ['a'..'b']
  //ULetters = ['A'..'B']
var
  Digit, ToAdd, ToCarry: integer;
begin

  if (Index = 0) and (Amount > 0) then
  begin
    Result := char(MIN_VAL + Amount - 1) + Str;
    Exit;
  end;

  if Index = -1 then Index := Length(Str);

  ToCarry := 0;
  Digit := Integer(Str[Index]);

  while not (Digit in [MIN_VAL..MAX_VAL]) do
  begin
    Dec(Index);
    Digit := Ord(Str[Index]);
  end;

  ToAdd := Digit + Amount;

  while (ToAdd > MAX_VAL) do
  begin
    Dec(ToAdd, 26);
    Inc(ToCarry);
  end;

  Result := Str;
  Result[Index] := char(ToAdd);

  if (ToCarry > 0) then
    Result := IncStr(Result, ToCarry, Index - 1);
end;

function IncStr2(Str: string; Amount: integer; Index: integer = -1): string;
const
  MIN_VAL = 48; //65 'A'  48 = '0'
  allowedSimbols = ['0'..'9', 'a'..'b', 'A'..'B'];
var
  i: Integer;
  tmp: string;
begin
  if (Index = 0) and (Amount > 0) then
  begin
    Result := char(MIN_VAL + Amount - 1) + Str;
    Exit;
  end;
  if Index = -1 then Index := Length(Str);

  for i := Length(str) - 1 downto 0 do
    if not (str[i] in allowedSimbols) then
    begin
      tmp := copy(str, i + 1, Length(str));
      break;
    end;

  IncStr(tmp, Amount, Index);
end;

procedure SetImageToRow(aType: string; aRow:TNiceRow);
begin

  case aType of
    'UO': TNiceRow(aRow).ImageIndex := 0;
    'MA': TNiceRow(aRow).ImageIndex := 1;
    'MO': TNiceRow(aRow).ImageIndex := 2;
    'HE': TNiceRow(aRow).ImageIndex := 3;
    'DI': TNiceRow(aRow).ImageIndex := 4;
    else TNiceRow(aRow).ImageIndex := -1;
  end;
end;


{$IFDEF DEBUG}
procedure dgSetLine(aDato: string);
begin
  DebugForm.Memo1.Lines.Add(aDato);
end;

{$ENDIF}

end.
