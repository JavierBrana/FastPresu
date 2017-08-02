unit formUser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, BCPanel, BCButton, NiceLookUpComboBox,
  ZDataset, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, DbCtrls,
  Buttons, ComCtrls, formWorkForm, Users;


const
  DocVenta: array[0..4] of string = ('PR', 'FB', 'BI', 'PA', 'DN');
  DocCompra: array[0..5] of string = ('BP', 'OR', 'WB', 'RO', 'PY', 'BB');
  OtherDocs: array[0..3] of string = ('PJ', 'CL', 'SU', 'EL');

type

  { TUserForm }

  TUserForm = class(TWorkForm)
    BCPanel2: TBCPanel;
    cbRead: TCheckBox;
    cbWrite: TCheckBox;
    cbPrint: TCheckBox;
    chbLoked: TDBCheckBox;
    dsUser: TDataSource;
    edUserType: TComboBox;
    edSurname: TDBEdit;
    edUserName: TDBEdit;
    edPassword: TDBEdit;
    edName: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Panel1: TPanel;
    Splitter1: TSplitter;
    TreeView1: TTreeView;
    zqUser: TZQuery;
    procedure bPrintClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure CheckBoxesClick(Sender: TObject);
    procedure dsUserStateChange(Sender: TObject);
    procedure edUserNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    { private declarations }
    FDocType: string;
    FNewUser: TUserClass;
  public
    { public declarations }
  end;

var
  UserForm: TUserForm;

implementation
uses
  formMainWindow,
  Utiles,
  u_variables;

{$R *.lfm}

{ TUserForm }

procedure TUserForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
  procedure GetPermitsOfDocument(aDoc: string);
  begin
    FDocType := aDoc;
    cbWrite.Checked := FNewUser.Permits.GetDocPermit(aDoc).Write;
    cbRead.Checked := FNewUser.Permits.GetDocPermit(aDoc).Read;
    cbPrint.Checked := FNewUser.Permits.GetDocPermit(aDoc).Print;
  end;
begin
  {$IFDEF DEBUG}
  dgSetLine(InttoStr(Node.Level));
  {$ENDIF}

  if Node.HasChildren then
  begin
    FDocType := '';
    cbWrite.Enabled:=false;
    cbRead.Enabled:=false;
    cbPrint.Enabled:=false;
    Exit;
  end;

  cbWrite.Enabled := true;
  cbRead.Enabled := true;
  cbPrint.Enabled := true;


  if Node.Level > 0 then
  begin
    if Node.HasAsParent(TreeView1.Items.Item[0]) then
      GetPermitsOfDocument(DocVenta[Node.Index])
    else
      GetPermitsOfDocument(DocCompra[Node.Index])
  end
  else
    GetPermitsOfDocument(OtherDocs[Node.Index - 2]);

end;

procedure TUserForm.bSaveClick(Sender: TObject);
begin
  if edUserName.Text = '' then
  begin
    edUserName.Color := $007777FF;
    edUserName.SetFocus;
    Exit;
  end
  else edUserName.Color := clDefault;

  zqUser.FieldByName('PERMITS').AsString := FNewUser.GetPermits;
  zqUser.FieldByName('USERTYPE').AsInteger := edUserType.ItemIndex;
  if not (DocOperation = doEdit) then
    zqUser.FieldByName('CREATEDBY').AsString := FUser.UserName;

  {$IFDEF DEBUG}
  dgSetLine('Clave encriptada: ' + cifrar(zqUser.FieldByName('PASSWORD').AsString, 'Javi'));
  {$ENDIF}
  zqUser.Post;
end;

procedure TUserForm.CheckBoxesClick(Sender: TObject);
begin
  case TCheckBox(Sender).Tag of
    0: FNewUser.Permits.GetDocPermit(FDocType).Write := TCheckBox(Sender).Checked;
    1: FNewUser.Permits.GetDocPermit(FDocType).Read := TCheckBox(Sender).Checked;
    2: FNewUser.Permits.GetDocPermit(FDocType).Print := TCheckBox(Sender).Checked;
  end;
end;

procedure TUserForm.dsUserStateChange(Sender: TObject);
begin
  case zqUser.State of
    dsEdit, dsInsert: bSave.Enabled := True;
    else
      bSave.Enabled := False;
  end;
end;

procedure TUserForm.edUserNameChange(Sender: TObject);
begin
  if (edUserName.Color = $007777FF) and (edUserName.Text <> '') then edUserName.Color := clWhite;
end;

procedure TUserForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  FNewUser.Free;
end;

procedure TUserForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  FDocType := '';
  FNewUser := TUserClass.create;
  TreeView1.Items[0].Selected:=true;

  if DocOperation = doEdit then  // Abrir presupuesto existente
  begin
    sqlEXEC(zqUser, 'SELECT * FROM USERS WHERE USERNAME = ' + QuotedStr(DocCode));
    edUserType.ItemIndex := zqUser.FieldByName('USERTYPE').AsInteger;
    bSave.Enabled:=false;
  end
  else
  begin
    for i:=0 to Length(DocCompra) - 1 do
      FNewUser.Permits.GetDocPermit(DocCompra[i]);
    for i:=0 to Length(DocVenta) - 1 do
      FNewUser.Permits.GetDocPermit(DocVenta[i]);
    for i:=0 to Length(OtherDocs) - 1 do
      FNewUser.Permits.GetDocPermit(OtherDocs[i]);
    edUserType.ItemIndex := 0;

    sqlEXEC(zqUser, 'SELECT * FROM USERS WHERE ID = -1');
    zqUser.Insert;
    bSave.Enabled := true;
  end;
end;

procedure TUserForm.bPrintClick(Sender: TObject);
begin

end;

end.

