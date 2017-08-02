unit formConfigWindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ColorBox, Spin, NiceDividerBevel, BCButton, u_Config, Types;

type

  { TConfigWindow }

  TConfigWindow = class(TForm)
    bAccept: TButton;
    bCancel: TButton;
    bMenuCompany4: TBCButton;
    cbBold: TCheckBox;
    cbItalic: TCheckBox;
    cbUnderline: TCheckBox;
    CheckBox1: TCheckBox;
    ColorButton1: TColorButton;
    Label1: TLabel;
    ListBox1: TListBox;
    FontList: TListBox;
    NiceDividerBevel2: TNiceDividerBevel;
    NiceDividerBevel3: TNiceDividerBevel;
    Notebook2: TNotebook;
    Page1: TPage;
    Page2: TPage;
    Page3: TPage;
    Page4: TPage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpinEdit1: TSpinEdit;
    procedure bAcceptClick(Sender: TObject);
    procedure bMenuCompany4Click(Sender: TObject);
    procedure cbBoldClick(Sender: TObject);
    procedure cbItalicClick(Sender: TObject);
    procedure cbUnderlineClick(Sender: TObject);
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure FontListSelectionChange(Sender: TObject; User: boolean);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure Page4BeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: Integer);
    procedure SpinEdit1Change(Sender: TObject);
  private
    { private declarations }
    FTempConfig: TConfig;
    FFont: TFont;
  public
    { public declarations }
    //constructor Create(TheOwner: TComponent); override;
    //destructor Destroy; override;
  end;

var
  ConfigWindow: TConfigWindow;

implementation

{$R *.lfm}

uses
  FormMainWindow, LCLType, u_variables;

{ TConfigWindow }

{constructor TConfigWindow.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  FTempConfig := TConfig.Create;
end;

destructor TConfigWindow.Destroy;
begin
  FTempConfig.Free;
end;}

procedure TConfigWindow.FormCreate(Sender: TObject);
begin
  Notebook2.PageIndex := 0;

  FontList.Items.Assign(Screen.Fonts);
end;

procedure TConfigWindow.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var
  aFont: TFont;
begin

  with ListBox1.Canvas do
  begin
    // Rellenar
    Brush.Style := bsSolid;
    Brush.Color := clWhite;
    Pen.Style := psSolid;
    FillRect(ARect);

    if Index = ListBox1.ItemIndex then
    begin
      Brush.Color := clSkyblue;
      RoundRect(ARect, 2, 2);
    end;

    // Dibujar
    case Index of
      0:
        aFont := FConfig.ConfigBudgetForm.FontTitle;
      1:
        aFont := FConfig.ConfigBudgetForm.FontItemMain;
      2:
        aFont := FConfig.ConfigBudgetForm.FontItemSecundary;
      3:
        aFont := FConfig.ConfigBudgetForm.FontCompositionSecundary;
      4:
        aFont := FConfig.ConfigBudgetForm.FontSummation;
      5:
        aFont := FConfig.ConfigBudgetForm.FontMergeCells;
    end;

    Font.Name := aFont.Name;
    Font.Color := aFont.Color;
    Font.Size := aFont.Size;
    Font.Style := aFont.Style;
    Brush.Style := bsClear;
    TextOut(ARect.Left, ARect.Top, ListBox1.Items[Index]);
  end;
end;

procedure TConfigWindow.bAcceptClick(Sender: TObject);
begin

end;

procedure TConfigWindow.bMenuCompany4Click(Sender: TObject);
begin
  bMenuCompany4.Down := true;
  Notebook2.PageIndex := 4;
end;

procedure TConfigWindow.cbBoldClick(Sender: TObject);
begin
  if cbBold.Checked then
    FFont.Style := FFont.Style + [fsBold]
  else
    FFont.Style := FFont.Style - [fsBold];
  ListBox1.Invalidate;
end;

procedure TConfigWindow.cbItalicClick(Sender: TObject);
begin
  if cbItalic.Checked then
    FFont.Style := FFont.Style + [fsItalic]
  else
    FFont.Style := FFont.Style - [fsItalic];
  ListBox1.Invalidate;
end;

procedure TConfigWindow.cbUnderlineClick(Sender: TObject);
begin
  if cbUnderline.Checked then
    FFont.Style := FFont.Style + [fsUnderline]
  else
    FFont.Style := FFont.Style - [fsUnderline];
  ListBox1.Invalidate;
end;

procedure TConfigWindow.ColorButton1ColorChanged(Sender: TObject);
begin
  FFont.Color := ColorButton1.ButtonColor;
  ListBox1.Invalidate;
end;

procedure TConfigWindow.FontListSelectionChange(Sender: TObject; User: boolean);
begin
  Caption :=FontList.Items[FontList.ItemIndex];
  FFont.Name := FontList.Items[FontList.ItemIndex];
  ListBox1.Invalidate;
end;

procedure TConfigWindow.ListBox1SelectionChange(Sender: TObject; User: boolean);
begin
  case ListBox1.ItemIndex of
    0:
      FFont := FConfig.ConfigBudgetForm.FontTitle;
    1:
      FFont := FConfig.ConfigBudgetForm.FontItemMain;
    2:
      FFont := FConfig.ConfigBudgetForm.FontItemSecundary;
    3:
      FFont := FConfig.ConfigBudgetForm.FontCompositionSecundary;
    4:
      FFont := FConfig.ConfigBudgetForm.FontSummation;
    5:
      FFont := FConfig.ConfigBudgetForm.FontMergeCells;
  end;

  FontList.ItemIndex := FontList.Items.IndexOf(FFont.Name);
  cbBold.Checked := fsBold in FFont.Style;
  cbItalic.Checked := fsItalic in FFont.Style;
  cbUnderline.Checked := fsUnderline in FFont.Style;
  ColorButton1.ButtonColor := FFont.Color;
end;

procedure TConfigWindow.Page4BeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: Integer);
begin
  ListBox1.ItemIndex :=0;
end;

procedure TConfigWindow.SpinEdit1Change(Sender: TObject);
begin
  Notebook2.PageIndex := SpinEdit1.Value;
end;

end.

