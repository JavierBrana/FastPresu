unit formForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCPanel, BCButton, DBZVDateTimePicker,
  NiceLookUpComboBox, ZDataset, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, formWorkForm, Utiles, db;

type

  { TForm2 }

  { TAllForms }

  TAllForms = class(TWorkForm)
    BCPanel2: TBCPanel;
    bNew: TBCButton;
    DataSource1: TDataSource;
    edDocCode: TDBEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    edTitle: TDBEdit;
    Label1: TLabel;
    Label3: TLabel;
    ZQuery1: TZQuery;
    procedure bNewClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure DataSource1StateChange(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }
    constructor Create(TheOwner: TComponent; Code: ansistring = '';
      DocumentType: integer = 0; Operation: TDocumentOperations = doNew); reintroduce;

  end;

var
  AllForms: TAllForms;

implementation

{$R *.lfm}

{ TForm2 }

constructor TAllForms.Create(TheOwner: TComponent; Code: ansistring = '';
  DocumentType: integer = 0; Operation: TDocumentOperations = doNew);
begin
  inherited;

end;

procedure TAllForms.bSaveClick(Sender: TObject);
begin
  ZQuery1.Post;
end;

procedure TAllForms.DataSource1StateChange(Sender: TObject);
begin
  case DataSource1.State of
    dsEdit, dsInsert: ButtonSaveEnabled := True;
    else
      ButtonSaveEnabled := False;
  end;
end;

procedure TAllForms.Edit2Change(Sender: TObject);
begin
  Edit3.Text := cifrar(Edit2.Text, Edit1.Text);
  Edit4.Text := '';//descifrar(Edit3.Text, Edit1.Text);
end;

procedure TAllForms.bNewClick(Sender: TObject);
begin
  ZQuery1.Append;
end;

procedure TAllForms.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //inherited;
  CloseAction := caFree;
  if not Floating then
  begin
    Visible := False;
    ManualFloat(Rect(0, 0, Width, Height));
  end;
end;

procedure TAllForms.FormCreate(Sender: TObject);
var
  dat: string;
begin
  inherited;
  case DocType of
    0:
    begin
      dat := 'FORM';
      Caption := 'Formas';
    end;
    1:
    begin
      dat := 'SUPPLIERFAMILIES';
      Caption := 'Familia de Proveedores';
    end;
    2:
    begin
      dat := 'CUSTOMERFAMILIES';
      Caption := 'Familia de Clientes';
    end;
    3:
    begin
      dat := 'ELEMENTFAMILIES';
      Caption := 'Familia de Elementos';
    end;
  end;

  if (DocOperation = doEdit) then
  begin
    sqlEXEC(ZQuery1, 'SELECT * FROM ' + dat + ' WHERE ID = ' + QuotedStr(DocCode));
  end
  else
  begin
    sqlEXEC(ZQuery1, 'SELECT * FROM ' + dat + ' WHERE ID = "-1"'  );
    ZQuery1.Append;
  end;

end;

end.

