unit formImportDBWizard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, BCPanel,
  //JLabeledFloatEdit, JDBLabeledFloatEdit,
  ZDataset, Forms, Controls, Graphics, Dialogs,
  ButtonPanel, ExtCtrls, StdCtrls, EditBtn, Spin, ComCtrls, Buttons;

type

  { TfImportDBWizard }

  TfImportDBWizard = class(TForm)
    bPause: TBitBtn;
    bStop: TBitBtn;
    ButtonPanel1: TButtonPanel;
    cbIgMA: TCheckBox;
    cbIgMO: TCheckBox;
    cbIgHE: TCheckBox;
    cbIgDI: TCheckBox;
    DataSource1: TDataSource;
    eFabricante: TEdit;
    edFileName: TFileNameEdit;
    edDesHe: TFloatSpinEdit;
    edDesMO: TFloatSpinEdit;
    edDesMA: TFloatSpinEdit;
    edDesDi: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lDescription: TLabel;
    lTitle: TLabel;
    Memo1: TMemo;
    Notebook: TNotebook;
    Page1: TPage;
    Page2: TPage;
    Page3: TPage;
    Panel1: TPanel;
    pHeader: TPanel;
    ProgressBar1: TProgressBar;
    ZQuery1: TZQuery;
    procedure bPauseClick(Sender: TObject);
    procedure bStopClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure Page1BeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: integer);
    procedure Page2BeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: integer);
    procedure Page3BeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: integer);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fImportDBWizard: TfImportDBWizard;

implementation

uses
  FIEBDC;

var
  FParseFIEBDC: TParseFIEBDC;

{$R *.lfm}

{ TfImportDBWizard }

procedure TfImportDBWizard.Page1BeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: integer);
begin
  ButtonPanel1.ShowButtons := [pbOk, pbClose];
  ButtonPanel1.OKButton.Caption := 'Siguiente >';
end;

procedure TfImportDBWizard.FormShow(Sender: TObject);
begin
  Notebook.PageIndex := 0;
  {$IFDEF DEBUG}
  edFileName.Text :=
    'C:\Users\Javi\Documents\Lazarus\fiebdc_lamp\LAMP.bc3';
  {$ENDIF}
end;

procedure TfImportDBWizard.CancelButtonClick(Sender: TObject);
begin
  Notebook.PageIndex := Notebook.PageIndex - 1;
end;

procedure TfImportDBWizard.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TfImportDBWizard.bPauseClick(Sender: TObject);
begin
  if FParseFIEBDC.Suspended then
  begin
    FParseFIEBDC.Resume;
  end
  else
  begin
    FParseFIEBDC.Suspend;
  end;
end;

procedure TfImportDBWizard.bStopClick(Sender: TObject);
begin
  FParseFIEBDC.Terminate;
  bPause.Enabled := False;
  ButtonPanel1.CloseButton.Enabled := True;
end;

procedure TfImportDBWizard.OKButtonClick(Sender: TObject);
begin
  case Notebook.PageIndex of
    0: if not FileExists(edFileName.Text) then
        Exit;
  end;
  Notebook.PageIndex := Notebook.PageIndex + 1;
end;

procedure TfImportDBWizard.Page2BeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: integer);
begin
  ButtonPanel1.ShowButtons := [pbOk, pbClose, pbCancel];
  ButtonPanel1.OKButton.Caption := '&Siguiente >';
  ButtonPanel1.CancelButton.Caption := '< &Anterior';
end;

procedure TfImportDBWizard.Page3BeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: integer);
begin
  ButtonPanel1.CloseButton.Enabled := False;
  ButtonPanel1.ShowButtons := [pbClose];

  FParseFIEBDC := TParseFIEBDC.Create(edFileName.Text, self);
  if Assigned(FParseFIEBDC.FatalException) then
    raise FParseFIEBDC.FatalException;

end;

end.
