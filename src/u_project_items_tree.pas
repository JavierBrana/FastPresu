unit u_project_items_tree;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, NiceGrid, gsGantt, u_defines;

const
  TypeOfRow: array[0..2] of string = ('DOC', 'TAS', 'CON');

type

  TTypeOfRow = (torDocument, torTask, torData);


  { TProjectItem }

  TProjectItem = class
  private
    FItems: TList;
    FGrid: TNiceGrid;
    FRow: TNiceRow;
    FParent: TObject;

    FINDEXCODE: string;
    FCODE: String30;
    FTYPE: String3;
    FTYPEOFELEMENT: String2;
    FTITLE: String80;
    FTOTAL_AMOUNT: double;
    FINSTALLED_AMOUNT: double;
    FREST_AMOUNT: double;
    FUNIT: string3;
    FFINAL_PRICE: double;
    FDATE: TDate;

    FNodeIndex: integer;
    FVisible: boolean;
    FChildrenVisibility: boolean;

    FNeedSave: boolean;

    FGantt: TgsGantt;
    FInterval: TInterval;

    procedure SetIndexCode(AVal: string);
    procedure SetCode(AVal: String30);
    procedure SetType(AVal: String3);
    procedure SetTypeOfElement(AVal: String2);
    procedure SetTitle(AVal: String80);
    procedure SetTotalAmount(AVal: double);
    procedure SetInstalled(AVal: double);
    procedure SetRest(AVal: double);
    procedure SetUnit(AVal: String3);
    procedure SetTotalPrice(AVal: double);
    procedure SetRow(AVal: TNiceRow);
    procedure SetVisible(AVal: boolean);
    procedure SetDate(AVal: TDate);

    function GetIndexCode: string;
    function GetCode: String30;
    function GetType: String3;
    function GetTitle: String80;
    function GetTotalAmount: double;
    function GetInstalled: double;
    function GetRest: double;
    function GetUnit: String3;
    function GetTotalPrice: double;
    function GetVisible: boolean;


    function GetParent: TObject;

    function GetNodeIndex: integer;
    function GetIndex: integer;

    function GetInterval: TInterval;

  public
    constructor Create(AParent: TObject); reintroduce;
    destructor Destroy; override;

    procedure AddItem(AItem: TProjectItem);
    procedure InsertItem(Index: integer; AItem: TProjectItem);
    procedure DeleteItem(Index: integer);

    function HasChildren: boolean;

    procedure Calculate;
    procedure Clear;

    procedure ToggleVisibility;
    procedure ToggleChildrenVisibility;
    procedure HideChildren;
    procedure ShowChildren;

    property IndexCode: string read GetIndexCode write SetIndexCode;
    property Code: String30 read GetCode write SetCode;
    property TypeOfItem: String3 read GetType write SetType;
    property TypeOfElement: String2 read FTYPEOFELEMENT write SetTypeOfElement;
    property Title: String80 read GetTitle write SetTitle;
    property TotalAmount: double read GetTotalAmount write SetTotalAmount;
    property InstalledAmount: double read GetInstalled write SetInstalled;
    property RestAmount: double read GetRest;// write SetRest;
    property UnitOfElement: String3 read GetUnit write SetUnit;
    property TotalPrice: double read FFINAL_PRICE;
    property DateOfInstallation: TDate read FDate write SetDate;

    property NodeIndex: integer read GetNodeIndex;
    property Index: integer read GetIndex;

    property Parent: TObject read GetParent;
    property Items: TList read FItems;
    property Row: TNiceRow read FRow write SetRow;

    property Visible: boolean read GetVisible write SetVisible;

    property Inteval: TInterval read GetInterval;
  end;

  { TProjectItems }

  TProjectItems = class
  private
    FGrid: TNiceGrid;

    oList: TList;

    FTotalPrice: Double;
    FTotalSalePrice: Double;

    function GetItem(aRow: integer): TProjectItem;
  public
    constructor Create(aGrid: TObject); reintroduce;
    destructor Destroy; override;

    function CreateItem(aRow: TNiceRow): TProjectItem;
    function IndexOf(aItem: TObject): integer;

    property ItemList: TList read oList;
    property TotalPrice: double read FTotalPrice;
    property TotalSalePrice: double read FTotalSalePrice;
  end;


implementation

uses
  Utiles;

{ TProjectItem }

{
aRow := ngDataInput.RowCount;
ngDataInput.RowCount := aRow + 1;
ngDataInput.Rows[aRow].NodeIndex := ZQ.FieldByName('ELEMENT_INDEX').AsInteger + 1;
ngDataInput.CellsT['cCode', aRow] := ZQ.FieldByName('ELEMENT_CODE').Text;
ngDataInput.CellsT['cBriefDescription', aRow] := ZQ.FieldByName('ELEMENT_TITLE').Text;
ngDataInput.CellsT['cTotalAmount', aRow] := ZQ.FieldByName('ELEMENT_TOTAL_AMOUNT').Text;
ngDataInput.CellsT['cRest', aRow] := ZQ.FieldByName('ELEMENT_TOTAL_AMOUNT').Text;
ngDataInput.CellsT['cUnit', aRow] := ZQ.FieldByName('ELEMENT_UNIT').Text;
ngDataInput.CellsT['cType', aRow] := 'TAS';
}

constructor TProjectItem.Create(AParent: TObject);
begin
  inherited Create;

  FParent := aParent;
  if FParent is TProjectItem then
    TProjectItem(FParent).AddItem(self);

  FItems := TList.Create;

  FCODE := '';
  FTYPE := '';
  FTITLE := '';
  FTOTAL_AMOUNT := 0;
  FINSTALLED_AMOUNT := 0;
  FREST_AMOUNT := 0;
  FUNIT := '';
  FFINAL_PRICE := 0;

  FVisible := True;
  FChildrenVisibility := True;
  FNeedSave := True;

  FGantt := nil;

  if FParent is TProjectItem then
    FNodeIndex := TProjectItem(FParent).NodeIndex + 1
  else
    FNodeIndex := 0;

end;

destructor TProjectItem.Destroy;
begin
  SetInstalled(0); //Para que el padre actualize el precio.
  Clear;  // Borra los hijos
  if assigned(FRow) then
    TNiceRow(FRow).Grid.DeleteRow(TNiceRow(FRow).Index);

  FItems.Free;

  inherited Destroy;
end;

procedure TProjectItem.SetIndexCode(AVal: string);
begin
  FINDEXCODE := AVal;
  //FGrid.CellsT['cCode', FRow.Index] := AVal;
end;

procedure TProjectItem.SetCode(AVal: String30);
begin
  FCODE := AVal;
  FGrid.CellsT['cCode', FRow.Index] := AVal;
end;

procedure TProjectItem.SetType(AVal: String3);
begin
  FTYPE := AVal;
  FGrid.CellsT['cType', FRow.Index] := AVal;
end;

procedure TProjectItem.SetTypeOfElement(AVal: String2);
begin
  if FTYPEOFELEMENT <> AVal then
  begin
    FTYPEOFELEMENT := AVal;
    FGrid.CellsT['cTypeOfElem', FRow.Index];
    SetImageToRow(AVal, FRow);
  end;
end;

procedure TProjectItem.SetTitle(AVal: String80);
begin
  FTITLE := AVal;
  FGrid.CellsT['cBriefDescription', FRow.Index] := AVal;
end;

procedure TProjectItem.SetTotalAmount(AVal: double);
begin
  FTOTAL_AMOUNT := AVal;
  FGrid.CellsT['cTotalAmount', FRow.Index] := FloatToStr(AVal);
  Calculate;
end;

procedure TProjectItem.SetInstalled(AVal: double);
begin
  FINSTALLED_AMOUNT := AVal;
  //FGrid.CellsT['cTotalAmount', FRow.Index] := FloatToStr(AVal);
  Calculate;
end;

procedure TProjectItem.SetRest(AVal: double);
begin
  FREST_AMOUNT := AVal;
  FGrid.CellsT['cRest', FRow.Index] := FloatToStr(AVal);
end;

procedure TProjectItem.SetUnit(AVal: String3);
begin
  FUNIT := AVal;
  FGrid.CellsT['cUnit', FRow.Index] := AVal;
end;

procedure TProjectItem.SetTotalPrice(AVal: double);
begin
  FFINAL_PRICE := AVal;
  //FGrid.CellsT['cBriefDescription', FRow.Index] := AVal;
end;

procedure TProjectItem.SetRow(AVal: TNiceRow);
begin
  FRow := AVal;
  FRow.ExternalObject := self;
  FRow.NodeIndex := FNodeIndex;
  FGrid := TNiceRow(FRow).Grid;
end;

procedure TProjectItem.SetDate(AVal: TDate);
begin
  if FDate <> AVal then FDATE := aVal;
  if FGrid.CellsT['cDate', FRow.Index] <> DateToStr(FDATE) then
    FGrid.CellsT['cDate', FRow.Index] := DateToStr(FDATE);
end;

procedure TProjectItem.SetVisible(AVal: boolean);
begin
  FVisible := AVal;
  FRow.Visible := AVal;
end;

function TProjectItem.GetIndexCode: string;
begin
  Result := FINDEXCODE;
end;

function TProjectItem.GetCode: String30;
begin
  Result := FCODE;
end;

function TProjectItem.GetType: String3;
begin
  Result := FTYPE;
end;

function TProjectItem.GetTitle: String80;
begin
  Result := FTITLE;
end;

function TProjectItem.GetTotalAmount: double;
begin
  Result := FTOTAL_AMOUNT;
end;

function TProjectItem.GetInstalled: double;
begin
  Result := FINSTALLED_AMOUNT;
end;

function TProjectItem.GetRest: double;
begin
  Result := FREST_AMOUNT;
end;

function TProjectItem.GetUnit: String3;
begin
  Result := FUNIT;
end;

function TProjectItem.GetTotalPrice: double;
begin
  Result := FFINAL_PRICE;
end;

function TProjectItem.GetVisible: boolean;
begin
  Result := FVISIBLE;
end;

function TProjectItem.GetParent: TObject;
begin
  Result := FParent;
end;

function TProjectItem.GetNodeIndex: integer;
begin
  Result := FNodeIndex;
end;

function TProjectItem.GetIndex: integer;
begin
  //Result := FIndex;
end;

function TProjectItem.GetInterval: TInterval;
begin
  Result := FInterval;
end;

procedure TProjectItem.AddItem(AItem: TProjectItem);
begin
  FItems.Add(AItem);
end;

procedure TProjectItem.InsertItem(Index: integer; AItem: TProjectItem);
begin

end;

procedure TProjectItem.DeleteItem(Index: integer);
begin

end;

function TProjectItem.HasChildren: boolean;
begin
  Result := FItems.Count > 0;
end;

procedure TProjectItem.Calculate;
var
  i: integer;
begin
  case FTYPE of
    'CON': TProjectItem(FParent).Calculate ;
    'DOC':
      begin
        FINSTALLED_AMOUNT := 0;
        if HasChildren then
        begin
          for i := 0 to FItems.Count - 1 do
            FINSTALLED_AMOUNT := FINSTALLED_AMOUNT +
                                 TProjectItem(FItems[i]).InstalledAmount / TProjectItem(FItems[i]).TotalAmount;
          FINSTALLED_AMOUNT := FINSTALLED_AMOUNT / FItems.Count  * 100;
          FGrid.CellsT['cDone', FRow.Index] := FormatFloat('0.##', FINSTALLED_AMOUNT) + '%';
          FREST_AMOUNT := 100 - FINSTALLED_AMOUNT;
          FGrid.CellsT['cRest', FRow.Index] := FormatFloat('0.##', FREST_AMOUNT) + '%';
        end;
      end
    else
      begin
        FINSTALLED_AMOUNT := 0;
        for i := 0 to FItems.Count - 1 do
          FINSTALLED_AMOUNT := FINSTALLED_AMOUNT + TProjectItem(FItems[i]).InstalledAmount;
        FGrid.CellsT['cDone', FRow.Index] := FloatToStr(FINSTALLED_AMOUNT);
        SetRest(FTOTAL_AMOUNT - FINSTALLED_AMOUNT);
        TProjectItem(FParent).Calculate ;
      end;
  end;
end;

procedure TProjectItem.Clear;
var
  i: integer;
begin
  if HasChildren then
  begin
    for i := 0 to FItems.Count - 1 do
      TProjectItem(FItems[i]).Free;
    FItems.Clear;
  end;
end;

procedure TProjectItem.ToggleVisibility;
begin
  Visible := not Visible;
end;

procedure TProjectItem.ToggleChildrenVisibility;
begin
  if FChildrenVisibility then HideChildren
  else ShowChildren;
end;

procedure TProjectItem.HideChildren;
var
  i: integer;
begin

  if HasChildren then
  begin
    for i := 0 to FItems.Count - 1 do
    begin
      TProjectItem(FItems[i]).HideChildren;
      TProjectItem(FItems[i]).Visible := False;
    end;
    FChildrenVisibility := False;
  end;
end;

procedure TProjectItem.ShowChildren;
var
  i: integer;
begin

  if HasChildren then
  begin
    for i := 0 to FItems.Count - 1 do
    begin
      TProjectItem(FItems[i]).Visible := True;
      TProjectItem(FItems[i]).ShowChildren;
    end;
    FChildrenVisibility := True;
  end;
end;


{ TProjectItems }

constructor TProjectItems.Create(aGrid: TObject);
begin
  inherited Create;
  FGrid := TNiceGrid(aGrid);
  oList := TList.Create;
end;

destructor TProjectItems.Destroy;
begin
  oList.Free;
  inherited Destroy;
end;

function TProjectItems.GetItem(aRow: integer): TProjectItem;
begin
  Result := TProjectItem(oList[aRow]);
end;

function TProjectItems.CreateItem(aRow: TNiceRow): TProjectItem;
begin

  Result := TProjectItem.Create(self);
  Result.Row := aRow;

  oList.Add(Result);
end;

function TProjectItems.IndexOf(aItem: TObject): integer;
begin
  for Result:=0 to oList.Count - 1 do
    if TObject(OList[Result]) = aItem then break;
end;

end.

