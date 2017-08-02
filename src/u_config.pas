unit u_Config;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, NiceGrid;

type

  PMyRec=^TColumnRec;
  TColumnRec=record
    GridName: string;
    Name: string;
    Width: integer;
    Visible: boolean;
  end;

  TConfigBudgetForm = class
  private
    FTitle: TFont;
    FItemFather: TFont;
    FItemChild: TFont;
    FCompositionSecundary: TFont;
    FSummation: TFont;
    FMergeCells: TFont;

    FDefaultFontSize: integer;
    FSaveColumnConfig: boolean;

    FColumnConfigList: TList;

    procedure SetSaveColumnConfig(aVal: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    procedure SaveColumns(aGrid: TNiceGrid);

    property FontTitle: TFont read FTitle write FTitle;
    property FontItemMain: TFont read FItemFather write FItemFather;
    property FontItemSecundary: TFont read FItemChild write FItemChild;
    property FontCompositionSecundary: TFont read FCompositionSecundary write FCompositionSecundary;
    property FontSummation: TFont read FSummation write FSummation;
    property FontMergeCells: TFont read FMergeCells write FMergeCells;

    property DefaultFontSize: integer read FDefaultFontSize write FDefaultFontSize;

    property SaveColumnConfig: boolean read FSaveColumnConfig write SetSaveColumnConfig default true;
  end;





  TConfig = class
  private
    FConfigBudgetForm : TConfigBudgetForm;
  public
    constructor Create;
    destructor Destroy; override;

    property ConfigBudgetForm: TConfigBudgetForm read FConfigBudgetForm write FConfigBudgetForm;
  end;

implementation


  {TConfigBudgetForm}
constructor TConfigBudgetForm.Create;
begin
  inherited Create;

  FTitle := TFont.Create;
  FItemFather := TFont.Create;
  FItemChild := TFont.Create;
  FSummation := TFont.Create;
  FCompositionSecundary := TFont.Create;
  FMergeCells := TFont.Create;

  // Default values:
  FDefaultFontSize := 8;

  FTitle.Name := 'Arial';
  FTitle.Size := FDefaultFontSize;
  FTitle.Style := [fsBold, fsUnderline];
  FTitle.Color := clBlack;

  FItemFather.Name := 'Arial';
  FItemFather.Size := FDefaultFontSize;
  FItemFather.Style := [fsBold];
  FItemFather.Color := clBlack;

  FCompositionSecundary.Name := 'Arial';
  FCompositionSecundary.Size := FDefaultFontSize;
  FCompositionSecundary.Style := [fsBold];
  FCompositionSecundary.Color := clGray;

  FItemChild.Name := 'Arial';
  FItemChild.Size := FDefaultFontSize;
  FItemChild.Style := [];
  FItemChild.Color := clGray;

  FSummation.Name := 'Times New Roman';
  FSummation.Size := FDefaultFontSize;
  FSummation.Style := [fsBold];
  FSummation.Color := clBlue;

  FMergeCells.Name := 'Arial';
  FMergeCells.Size := FDefaultFontSize;
  FMergeCells.Style := [fsBold, fsUnderline];
  FMergeCells.Color := clWhite;

  FSaveColumnConfig := false;
  SetSaveColumnConfig(true);
end;

destructor TConfigBudgetForm.Destroy;
begin
  FTitle.Free;
  FItemFather.Free;
  FItemChild.Free;
  FSummation.Free;
  FCompositionSecundary.Free;
  FMergeCells.Free;

  inherited Destroy;
end;

procedure TConfigBudgetForm.SetSaveColumnConfig(aVal: Boolean);
begin
  if FSaveColumnConfig = aVal then Exit;
  FSaveColumnConfig := aVal;

  if FSaveColumnConfig then
    FColumnConfigList := TList.Create
  else
  begin
    FColumnConfigList.free;
    FColumnConfigList := nil;
  end;
end;


procedure TConfigBudgetForm.SaveColumns(aGrid: TNiceGrid);
var
  i: integer;
begin

  for i:=0 to aGrid.ColCount - 1 do
  begin
    if aGrid.Columns[i].AllowShowHide = false then continue;
    //aGrid.Name;

  end;
end;

  {TConfig}
constructor TConfig.Create;
begin
  inherited Create;

  FConfigBudgetForm := TConfigBudgetForm.Create;
end;

destructor TConfig.Destroy;
begin
  // Liberar todo:
  FConfigBudgetForm.Free;

  inherited destroy;
end;

end.

