unit u_items_tree;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Grids, NiceGrid, gsGantt, u_defines;

type

  // Todas las columnas:
  {
  'ID INTEGER NOT NULL, '                        +  // 0.  Número de la línea
  'SALEDOCUMENT_CODE VARCHAR(10) NOT NULL, '     +  // 1.  ID Documento de compra
  'NODEINDEX VARCHAR(10), '                      +  // 2.  Indice

  'ELEMENT_CODE VARCHAR(20), '                   +  // 3.  ID del elemento
  'ELEMENT_TYPE VARCHAR(2), '                    +  // 4.  Tipo de elemento
  'ELEMENT_INDEX INTEGER, '                      +  // 5.  Indice del elemento
  'ELEMENT_TITLE VARCHAR(80), '                  +  // 6.  Título del elemento
  'ELEMENT_DESCRIPTION BLOB, '                   +  // 7.  Descripción del elemento
  'ELEMENT_UNIT_AMOUNT FLOAT, '                  +  // 8.  Cantidad unitaria del elemento
  'ELEMENT_TOTAL_AMOUNT FLOAT, '                 +  // 9.  Cantidad total
  'ELEMENT_UNIT  VARCHAR(2), '                    +  // 10.  ID de la unidad
  'ELEMENT_PRICE FLOAT, '                        +  // 11. Precio del elemento

  'BENEFIT FLOAT    , '                          +  // 12. Beneficio
  'DISCOUNT  FLOAT    , '                          +  // 13. Descuento

  'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, '    +  // 14. Fecha de creación
  'CREATEDBY VARCHAR(100), ' +
  }

  TItemBase = class
  private
    FRow: TObject;
    FParent: TObject;
  public
    constructor Create(AParent: TObject; Indice: integer = -1); virtual;
  end;

  TItem = class(TItemBase)
  private
    FItems: TList;

    FINDEXCODE: string;
    FCODE: String30;
    FTYPE: String2;
    FTITLE: String80;
    FDESCRIPTION: string;
    FUNIT_AMOUNT: double;
    FTOTAL_AMOUNT: double;
    FUNIT: string3;
    FPRICE: double;
    FTOTAL_PRICE: double;
    FBENEFIT: double;
    FDISCOUNT: double;
    FFINAL_PRICE: double;

    FNodeIndex: integer;

    FVisible: boolean;
    FChildrenVisibility: boolean;

    FNeedSave: boolean;


    FGantt: TgsGantt;
    FUseGantt: boolean;
    FInterval: TInterval;

    procedure SetIndexCode(AVal: string);
    procedure SetCode(AVal: String30);
    procedure SetType(AVal: String2);
    procedure SetTitle(AVal: String80);
    procedure SetDescription(AVal: string);
    procedure SetUnitAmount(AVal: double);
    procedure SetTotalAmount(AVal: double);
    procedure SetUnit(AVal: String3);
    procedure SetPrice(AVal: double);
    procedure SetBenefit(AVal: double);
    procedure SetDiscount(AVal: double);
    procedure SetRow(AVal: TObject);
    procedure SetVisible(AVal: boolean);

    function GetIndexCode: string;
    function GetCode: String30;
    function GetType: String2;
    function GetTitle: String80;
    function GetDescription: string;
    function GetUnitAmount: double;
    function GetTotalAmount: double;
    function GetUnit: String3;
    function GetPrice: double;
    function GetBenefit: double;
    function GetDiscount: double;

    function GetVisible: boolean;

    function GetParent: TObject;

    function GetNodeIndex: integer;
    function GetIndex: integer;

    function GetInterval: TInterval;

    procedure WriteDataInWrid(ColName, Data: string);

    // Gantt:
    procedure CreateInterval;
    procedure DeleteInterval;
  public
    constructor Create(AParent: TObject; Indice: integer = -1); override;
    constructor Create(AParent: TObject; UseGantt: Boolean; aGantt: TgsGantt;
      Indice: integer = -1); reintroduce;
    destructor Destroy; override;

    procedure AddItem(AItem: TItem);
    procedure InsertItem(Index: integer; AItem: TItem);
    //procedure DeleteItem(Index: integer);

    procedure CalculatePrice;
    procedure Clear;

    procedure ToggleVisibility;
    procedure ToggleChildrenVisibility;
    procedure HideChildren;
    procedure ShowChildren;

    function HasChildren: boolean;
    function IsTask: boolean;


    //procedure SaveToDB();

    property IndexCode: string read GetIndexCode write SetIndexCode;
    property Code: String30 read GetCode write SetCode;
    property TypeOfElement: String2 read GetType write SetType;
    property Title: String80 read GetTitle write SetTitle;
    property Description: string read GetDescription write SetDescription;
    property UnitAmount: double read GetUnitAmount write SetUnitAmount;
    property TotalAmount: double read GetTotalAmount;
    property UnitOfElement: String3 read GetUnit write SetUnit;
    property Price: double read getPrice write SetPrice;
    property TotalPrice: double read FTOTAL_PRICE;
    property Benefit: double read GetBenefit write SetBenefit;
    property Discount: double read GetDiscount write SetDiscount;
    property TotalSalePrice: double read FFINAL_PRICE;

    property NodeIndex: integer read GetNodeIndex;
    property Index: integer read GetIndex;

    property Parent: TObject read GetParent;
    property Items: TList read FItems;
    property Row: TObject read FRow write SetRow;

    property Visible: boolean read GetVisible write SetVisible;

    property Inteval: TInterval read GetInterval;
  end;

  { TItems }

  TSubTotalItem = class(TItemBase)
  private
    FSaleTotal: double;
    FTotal: double;
    FGain: double;

    procedure Calculate;
  public
    constructor Create(AParent: TObject; Indice: integer = -1); reintroduce;
    destructor Destroy; override;

    property SaleTotalPrice: double read FSaleTotal;
    property TotalPrice: double read FTotal;
    property Gain: double read FGain;
  end;

  { TItems }

  TItems = class
  private
    FGrid: TNiceGrid;

    oList: TList;
    //MaterialList: TList;
    //ToolsList: TList;
    //ManpowerList: TList;

    FTotalPrice: Double;
    FTotalSalePrice: Double;


    function GetItem(aRow: integer): TItem;
  public
    constructor Create(aGrid: TObject); reintroduce;
    destructor Destroy; override;

    function CreateItem(aParent: TObject; aRow: TNiceRow; aGantt: TgsGantt = nil): TItem;

    procedure CalculateTotalPrice;
    procedure CreateListOfElements;
    function IndexOf(aItem: TObject): integer;

    property ItemList: TList read oList;
    property TotalPrice: double read FTotalPrice;
    property TotalSalePrice: double read FTotalSalePrice;
  end;


function CreateItem(aParent: TObject; aRow: TNiceRow): TItem;

implementation

uses
  StrUtils, Utiles, u_units;

{functions and procedure}

function CreateItem(aParent: TObject; aRow: TNiceRow): TItem;
begin
  Result := TItem.Create(aParent);
  Result.Row := aRow;
end;

constructor TItemBase.Create(AParent: TObject; Indice: integer = -1);
begin
  inherited create;
  FParent := AParent;
  FRow := nil;
end;

{TItem}

constructor TItem.Create(AParent: TObject; Indice: integer = -1);
begin
  inherited Create(AParent, Indice);
  if FParent is TItem then
    if Indice = -1 then TItem(FParent).AddItem(self)
    else TItem(FParent).InsertItem(Indice, self);

  FItems := TList.Create;

  FCODE := '';
  FTYPE := '';
  FTITLE := '';
  FDESCRIPTION := '';
  FUNIT_AMOUNT := 0;
  FTOTAL_AMOUNT := 0;
  FUNIT := '';
  FPRICE := 0;
  FTOTAL_PRICE := 0;
  FBENEFIT := 0;
  FDISCOUNT := 0;
  FFINAL_PRICE := 0;

  FVisible := True;
  FChildrenVisibility := True;
  FNeedSave := True;

  FGantt := nil;
  FUseGantt := false;

  if FParent is TItem then
  begin
    FNodeIndex := TItem(FParent).NodeIndex + 1;
    Benefit := TItem(FParent).Benefit;
    Discount := TItem(FParent).Discount;
  end
  else
    FNodeIndex := 0;
end;

constructor TItem.Create(AParent: TObject; UseGantt: Boolean; aGantt: TgsGantt;
  Indice: integer = -1);
begin
  Create(AParent, Indice);
  FGantt := aGantt;
  FUseGantt := UseGantt;
  CreateInterval;
end;

destructor TItem.Destroy;
begin
  SetPrice(0); //Para que el padre actualize el precio.

  Clear;
  if assigned(FRow) then
    TNiceRow(FRow).Grid.DeleteRow(TNiceRow(FRow).Index);
  FItems.Free;

  inherited Destroy;
end;

procedure TItem.SetIndexCode(AVal: string);
begin
  FINDEXCODE := AVal;
end;

procedure TItem.SetCode(AVal: String30);
begin
  FCODE := AVal;
end;

procedure TItem.SetType(AVal: String2);
begin

  if FTYPE <> AVal then
  begin
    FTYPE := AVal;
    case FTYPE of
      {'UO':
      begin
        TNiceRow(FRow).Grid.InsertRow(TNiceRow(FRow).Index + 1);
        CreateItem(self, TNiceRow(FRow).Grid.Rows[TNiceRow(FRow).Index + 1]).TypeOfElement := '';
      end;
      }

      'MA', 'HE':
        begin
          if HasChildren then Clear;
        end;

      'MO', 'DI':
        begin
          if HasChildren then Clear;
        end;
    end;

    if Assigned(FRow) then
    begin
      SetImageToRow(FTYPE, TNiceRow(FRow));
    end;
  end;
end;

procedure TItem.SetTitle(AVal: String80);
begin
  FTITLE := AVal;
  if FUseGantt then FInterval.Task := FTITLE;
end;

procedure TItem.SetDescription(AVal: string);
begin
  FDESCRIPTION := AVal;
end;

procedure TItem.SetUnitAmount(AVal: double);

  procedure UpdateChildren(aItem: TItem; aVal: double);
  var
    i: integer;
  begin
    for i := 0 to aItem.FItems.Count - 1 do
    begin
      if AnsiPos('%', TItem(aItem.FItems[i]).UnitOfElement) <> 0 then
        TItem(aItem.FItems[i]).SetTotalAmount(TItem(aItem.FItems[i]).UnitAmount)
      else
        TItem(aItem.FItems[i]).SetTotalAmount(TItem(aItem.FItems[i]).UnitAmount * aVal);

      if TItem(aItem.FItems[i]).HasChildren then
        UpdateChildren(TItem(aItem.FItems[i]), TItem(aItem.FItems[i]).TotalAmount);
    end;
  end;

begin

  if (FUNIT_AMOUNT <> AVal) then
  begin
    FUNIT_AMOUNT := AVal;

    if (FParent is TItem) then
    begin
      if AnsiPos('%', FUNIT) <> 0 then
        SetTotalAmount(FUNIT_AMOUNT)
      else
        SetTotalAmount(FUNIT_AMOUNT * TItem(FParent).TotalAmount);
    end
    else
      SetTotalAmount(FUNIT_AMOUNT);

    if HasChildren then
      UpdateChildren(self, FTOTAL_AMOUNT);
  end;

  {$IFDEF DEBUG}
  //for i := 0 to FItems.Count - 1 do
  //  dgSetLine('Antes: ' + FloatToStr(TItem(FItems[i]).FTOTAL_AMOUNT));
  {$ENDIF}
end;

procedure TItem.SetTotalAmount(AVal: double);
begin
  FTOTAL_AMOUNT := AVal;
  WriteDataInWrid('cTotalAmount', FloatToStr(AVal));
  CalculatePrice;

  if FUseGantt  and ((FTYPE = 'MO') or (FTYPE = 'HE')) then
    FInterval.Duration := ConverUnits(FTOTAL_AMOUNT, FUNIT, 'dia');
end;

procedure TItem.SetUnit(AVal: String3);
begin
  FUNIT := AVal;
end;

procedure TItem.SetPrice(AVal: double);
begin
  if not HasChildren then
    FPRICE := AVal;
  CalculatePrice;
end;

procedure TItem.SetBenefit(AVal: double);
var
  i: integer;
begin
  if FBENEFIT <> AVal then
  begin
    FBENEFIT := AVal;
    if HasChildren then
      for i := 0 to FItems.Count - 1 do
        TItem(FItems[i]).Benefit := AVal;
    CalculatePrice;

    if FParent is TItem then
      WriteDataInWrid('cBenefit', FloatToStr(FBENEFIT));
  end;
end;

procedure TItem.SetDiscount(AVal: double);
var
  i: integer;
begin
  if FDISCOUNT <> AVal then
  begin
    FDISCOUNT := AVal;
    if HasChildren then
      for i := 0 to FItems.Count - 1 do
        TItem(FItems[i]).Discount := AVal;
    CalculatePrice;

    if FParent is TItem then
      WriteDataInWrid('cDiscount', FloatToStr(FDISCOUNT));
  end;
end;

procedure TItem.SetRow(AVal: TObject);
begin
  if AVal = nil then
    Exit;
  if FRow <> AVal then
  begin
    FRow := AVal;
    TNiceRow(FRow).ExternalObject := self;
    TNiceRow(FRow).NodeIndex := FNodeIndex;
  end;
end;

procedure TItem.SetVisible(AVal: boolean);
begin
  if FNodeIndex = 0 then
    Exit;

  if FVisible <> aVal then
  begin
    FVisible := aVal;
    TNiceRow(self.Row).Visible := FVisible;
    // draw grid
  end;
end;

function TItem.GetIndexCode: string;
begin
  Result := FINDEXCODE;
end;

function TItem.GetCode: String30;
begin
  Result := FCODE;
end;

function TItem.GetType: String2;
begin
  Result := FTYPE;
end;

function TItem.GetTitle: String80;
begin
  Result := FTITLE;
end;

function TItem.GetDescription: string;
begin
  Result := FDESCRIPTION;
end;

function TItem.GetUnitAmount: double;
begin
  Result := FUNIT_AMOUNT;
end;

function TItem.GetTotalAmount: double;
begin
  Result := FTOTAL_AMOUNT;
end;

function TItem.GetUnit: String3;
begin
  Result := FUNIT;
end;

function TItem.GetPrice: double;
begin
  Result := FPRICE;
end;

function TItem.GetBenefit: double;
begin
  Result := FBENEFIT;
end;

function TItem.GetDiscount: double;
begin
  Result := FDISCOUNT;
end;

function TItem.GetNodeIndex: integer;
begin
  Result := FNodeIndex;
end;

function TItem.GetIndex: integer;
begin
  if FParent is TItem then
    Result := TItem(FParent).Items.IndexOf(self)
  else
    Result := 0;
end;

function TItem.GetVisible: boolean;
begin
  Result := FVisible;
end;

function TItem.GetParent: TObject;
begin
  Result := FParent;
end;

function TItem.GetInterval: TInterval;
begin
  if Assigned(FInterval) then Result := FInterval
  else Result := nil;
end;

procedure TItem.WriteDataInWrid(ColName, Data: string);
begin
  if Assigned(FRow) then
    TNiceRow(FRow).Grid.CellsT[ColName, TNiceRow(FRow).Index] := Data;
end;

procedure TItem.CreateInterval;
begin
  if Assigned(FInterval) then Exit;
  if FTYPE = 'MA' then Exit;
  //if not IsTask then Exit;

  FInterval := TInterval.Create(FGantt);
  FInterval.StartDate := date;
  FInterval.FinishDate := date;
  FInterval.Visible := True;
  FInterval.Task := FTITLE;

  if FParent is TItem then TItem(FParent).Inteval.AddInterval(FInterval)
  else FGantt.AddInterval(FInterval);
end;

procedure TItem.DeleteInterval;
begin
  if not Assigned(FInterval) then Exit;
  FInterval.Free;
  FInterval := nil;
end;

procedure TItem.AddItem(AItem: TItem);
begin
  FItems.Add(AItem);
  AItem.FNodeIndex := FNodeIndex + 1;
end;

procedure TItem.InsertItem(Index: integer; AItem: TItem);
begin
  FItems.Insert(Index, AItem);
  AItem.FNodeIndex := FNodeIndex + 1;
end;

{procedure TItem.DeleteItem(Index: integer);
begin
  TItem(FItems[Index]).Clear;
  FItems.Delete(Index);
end;}

function TItem.HasChildren: boolean;
begin
  Result := FItems.Count > 0;
end;

function TItem.IsTask: boolean;
begin
  if ((FTYPE = 'MO') or (FTYPE = 'HE')) then Result := true
  else Result := false;
end;

procedure TItem.CalculatePrice;

  procedure CalculatePerCent;
  var
    i: integer;
    Price, TPrice: double;
    SearchFor: string;
  begin
    Price := 0;
    TPrice := 0;

    if AnsiContainsText(FUNIT, 'MA') then SearchFor := 'MA'
    else if AnsiContainsText(FUNIT, 'MO') then SearchFor := 'MO'
    else if AnsiContainsText(FUNIT, 'HE') then SearchFor := 'HE'
    else SearchFor := '';

    for i := Index - 1 downto 0 do
    begin
      //if AnsiPos('%', TItem(TItem(FParent).Items[i]).UnitOfElement) <> 0 then
      if AnsiContainsText(TItem(TItem(FParent).Items[i]).UnitOfElement, '%') then
        break;
      // Para nuevas versiones: (implementar diversos %)
      //if (SearchFor <> '') and not AnsiContainsText(TItem(TItem(FParent).Items[i]).UnitOfElement, SearchFor) then
      //  continue;
      Price := Price + TItem(TItem(FParent).Items[i]).Price;
      TPrice := TPrice + TItem(TItem(FParent).Items[i]).TotalPrice;
    end;
    FPRICE := Price * FUNIT_AMOUNT / 100;
    FTOTAL_PRICE := TPrice * FUNIT_AMOUNT / 100;
    WriteDataInWrid('cUnitPrice', FloatToStr(FPRICE));
  end;

var
  i: integer;
begin

  if HasChildren then
  begin
    FPRICE := 0;
    FTOTAL_PRICE := 0;
    FFINAL_PRICE := 0;
    for i := 0 to FItems.Count - 1 do
    begin
      FPRICE := FPRICE + TItem(FItems[i]).Price;
      FTOTAL_PRICE := FTOTAL_PRICE + TItem(FItems[i]).TotalPrice;
      FFINAL_PRICE := FFINAL_PRICE + TItem(FItems[i]).TotalSalePrice;
    end;
    WriteDataInWrid('cUnitPrice', FloatToStr(FPRICE));
  end
  else
  begin
    //if AnsiPos('%', FUNIT) <> 0 then
    if AnsiContainsText(FUNIT, '%') then
      CalculatePerCent
    else
      FTOTAL_PRICE := FPRICE * FTOTAL_AMOUNT;
    FFINAL_PRICE := FTOTAL_PRICE * (1 + FBENEFIT / 100) * (1 - FDISCOUNT / 100);
  end;

  WriteDataInWrid('cTotalPrice', FloatToStr(FTOTAL_PRICE));
  WriteDataInWrid('cTotalPVP', FloatToStr(FFINAL_PRICE));

  if FParent is TItem then TItem(FParent).CalculatePrice
  else if FParent is TItems then TItems(FParent).CalculateTotalPrice;
end;

procedure TItem.Clear;
var
  i: integer;
begin
  if HasChildren then
  begin
    for i := 0 to FItems.Count - 1 do
      TItem(FItems[i]).Free;
    FItems.Clear;
  end;

  {$IFDEF DEBUG}
  if FItems.Count > 0 then
  begin
    dgSetLine('---- Lista de elementos: (Número) ---------------------------------------');
    dgSetLine(IntToStr(FItems.Count));
  end;
  {$ENDIF}
end;

procedure TItem.ToggleVisibility;
begin
  Visible := not Visible;
end;

procedure TItem.ToggleChildrenVisibility;
begin
  if FChildrenVisibility then
    HideChildren
  else
    ShowChildren;
end;

procedure TItem.HideChildren;
var
  i: integer;
begin

  if HasChildren then
  begin
    for i := 0 to FItems.Count - 1 do
    begin
      TItem(FItems[i]).HideChildren;
      TItem(FItems[i]).Visible := False;
    end;
    FChildrenVisibility := False;
  end;
end;

procedure TItem.ShowChildren;
var
  i: integer;
begin

  if HasChildren then
  begin
    for i := 0 to FItems.Count - 1 do
    begin
      TItem(FItems[i]).Visible := True;
      TItem(FItems[i]).ShowChildren;
    end;
    FChildrenVisibility := True;
  end;
end;



{ TSubTotalItem }

constructor TSubTotalItem.Create(AParent: TObject; Indice: integer = -1);
begin
  inherited Create(AParent, Indice);

end;

destructor TSubTotalItem.Destroy;
begin
  inherited Destroy;
end;

procedure TSubTotalItem.Calculate;
var
  i: integer;
begin

  FSaleTotal := 0;
  FTotal := 0;
  FGain := 0;
  if FParent is TItems then
    for i:=0 to TItems(FParent).ItemList.Count - 1 do
      if TObject(TItems(FParent).ItemList[i]) is TSubTotalItem then break
      else if TObject(TItems(FParent).ItemList[i]) is TItem then
      begin
        FTotal :=  FTotal + TItem(TItems(FParent).ItemList[i]).TotalPrice;
        FSaleTotal :=  FSaleTotal + TItem(TItems(FParent).ItemList[i]).TotalSalePrice;
      end;

  if FTotal <> 0 then
    FGain := (FSaleTotal / FTotal);
end;

{TItems}

constructor TItems.Create(aGrid: TObject);
var
  i: integer;
begin
  inherited Create;
  FGrid := TNiceGrid(aGrid);
  oList := TList.Create;
  //MaterialList := TList.Create;
  //ToolsList := TList.Create;
  //ManpowerList := TList.Create;
end;

destructor TItems.Destroy;
begin
  oList.Free;
  //MaterialList.Free;
  //ToolsList.Free;
  //ManpowerList.Free;
  inherited Destroy;
end;

function TItems.GetItem(aRow: integer): TItem;
begin
  Result := TItem(oList[aRow]);
end;

function TItems.CreateItem(aParent: TObject; aRow: TNiceRow; aGantt: TgsGantt = nil): TItem;
var
  i: integer;
begin
  for i := 0 to oList.Count do
    if i < olist.Count then
      if TNiceRow(TItem(oList[i]).Row).Index > aRow.Index then break;

  if not Assigned(aGantt) then
    Result := TItem.Create(aParent)
  else
    Result := TItem.Create(aParent, true, aGantt);
  Result.Row := aRow;

  if aParent = self then
    oList.Insert(i, Result);
end;

procedure TItems.CalculateTotalPrice;
var
  i: integer;
begin

  FTotalPrice := 0;
  FTotalSalePrice := 0;

  {$IFDEF DEBUG}
  dgSetLine('Número de Items: ' + FloatToStr(oList.Count));
  {$ENDIF}
  for i:=0 to oList.Count - 1 do
  begin
    if TObject(OList[i]) is TItem then
    begin
      FTotalPrice := FTotalPrice + TItem(oList[i]).TotalPrice ;
      FTotalSalePrice := FTotalSalePrice + TItem(oList[i]).TotalSalePrice;
    end
    else if TObject(OList[i]) is TSubTotalItem then
      TSubTotalItem(OList[i]).Calculate;
  end;
end;

procedure TItems.CreateListOfElements;
  procedure Count(aItem: TItem);
  var
    i:integer;
  begin
    if aItem.HasChildren then
      for i := 0 to aItem.Items.Count - 1 do
        Count(TItem(aItem.Items[i]))
    else
    begin

    end;
  end;
var
  i: integer;
begin

  for i:=0 to oList.Count - 1 do
    if TObject(OList[i]) is TItem then
      Count(TITem(OList[i]));
end;

function TItems.IndexOf(aItem: TObject): integer;
begin
  for Result:=0 to oList.Count - 1 do
    if TObject(OList[Result]) = aItem then break;
end;

end.
