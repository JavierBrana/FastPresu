unit formWorkForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil,
  BGRABitmapTypes, BCTypes, BCPanel, BCButton,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, contnrs,
  Utiles;

type

  { TWorkForm }

  TWorkForm = class(TForm)
    bSave: TBCButton;
    SeparatorBevel: TBevel;
    bPrint: TBCButton;
    bClose: TBCButton;
    ToolBar: TBCPanel;

    procedure bCloseClick(Sender: TObject);
    procedure bPrintClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);Virtual; Abstract;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { private declarations }
    FCode: String;
    FOperation: TDocumentOperations;
    FDocType: integer;

    procedure SetbSaveEnabled(val: Boolean);
    function GetSaveEnabled: Boolean;
    procedure SetCode(val: String);
    function GetCode: String;
    procedure SetOperation(val: TDocumentOperations);
    function GetOperation: TDocumentOperations;
    procedure SetDocType(val: integer);
    function GetDocType: integer;
  public
    { public declarations }
    constructor Create(TheOwner: TComponent; Code: ansistring = '';
      DocumentType: integer = 0; Operation: TDocumentOperations = doNew); reintroduce;

    procedure ShowBar(Panel: TBCPanel);
    procedure HideBar;

    property ButtonSaveEnabled : boolean read GetSaveEnabled write SetbSaveEnabled;
    property DocCode: String read GetCode write SetCode;
    property DocOperation: TDocumentOperations read GetOperation write SetOperation;
    property DocType: integer read GetDocType write SetDocType;
  end;


implementation
uses
  FormSaveOpenedDocuments,
  formMainWindow;

{$R *.lfm}

{ TListForm }

constructor TWorkForm.Create(TheOwner: TComponent; Code: ansistring = '';
  DocumentType: integer = 0; Operation: TDocumentOperations = doNew);
var
  i: Integer;
begin
  if Code <> '' then
    for i := 0 to MainWindow.TabDockCenter.PageCount-1 do
    begin
      if TWorkForm(MainWindow.TabDockCenter.Page[i].Controls[0]).DocCode = Code then
        Abort;
	  end;

	inherited Create(TheOwner);

  FCode := Code;
  FDocType := DocumentType;
  FOperation := Operation;
end;

procedure TWorkForm.bCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TWorkForm.bPrintClick(Sender: TObject);
begin
  if DocCode = '' then
    MessageDlg('Antes de imprimir se debe guardar el documento.',
        mtInformation, [mbYes, mbNo], 0);

  MainWindow.bMenuClick(MainWindow.bMenu);
  MainWindow.MenuButtonsClick(MainWindow.bMenuPrint);
  MainWindow.frame.SetDocsToPrint(DocCode);
end;

procedure TWorkForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if assigned (SaveOpenedDocuments) then
  begin
    if not SaveOpenedDocuments.Visible then
    begin
      if sender = self then
      begin
        if ButtonSaveEnabled then
          case MessageDlg('El documento ha sido modificado.'+ #10 + #13 +
                          '¿Quieres guardar los cambios?',
              mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
            mrCancel: Abort;
            mrYes: bSaveClick(Sender);
          end;
      end;
    end;
  end;

  CloseAction := caFree;
  if not Floating then
  begin
    Visible := False;
    ManualFloat(Rect(0, 0, Width, Height));
  end;
end;

procedure TWorkForm.FormCreate(Sender: TObject);
begin
  ToolBar.Top:=0;
end;

procedure TWorkForm.FormShow(Sender: TObject);
begin
  if HasParent then
    Parent.Caption := Caption;
end;

procedure TWorkForm.SetbSaveEnabled(val: Boolean);
begin
  bSave.Enabled := val;
end;

function TWorkForm.GetSaveEnabled: Boolean;
begin
  Result := false;
  Result := bSave.Enabled;
end;

procedure TWorkForm.SetCode(val: String);
begin
  if FCode <> val then FCode := val;
end;

function TWorkForm.GetCode: String;
begin
  Result := FCode;
end;

procedure TWorkForm.SetOperation(val: TDocumentOperations);
begin
  if FOperation <> val then FOperation := val;
end;

function TWorkForm.GetOperation: TDocumentOperations;
begin
  Result := FOperation;
end;

procedure TWorkForm.SetDocType(val: integer);
begin
  if FDocType <> val then FDocType := val;
end;

function TWorkForm.GetDocType: integer;
begin
  Result := FDocType;
end;

procedure TWorkForm.ShowBar(Panel: TBCPanel);
begin
  if Assigned (Panel) then
  begin
    ToolBar.Parent := Panel;
  end;
  ToolBar.Show;
end;

procedure TWorkForm.HideBar;
begin
  ToolBar.Parent := self;
  ToolBar.Hide;
end;

end.

