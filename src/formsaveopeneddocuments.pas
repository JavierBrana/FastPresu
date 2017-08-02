unit FormSaveOpenedDocuments;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, CheckLst,
  ExtCtrls, Buttons, ComCtrls, StdCtrls;

type

  { TSaveOpenedDocuments }

  TSaveOpenedDocuments = class(TForm)
    bSave: TBitBtn;
    bCancel: TBitBtn;
    clbDocumentList: TCheckListBox;
    pButtonPanel: TPanel;
    procedure bSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SaveOpenedDocuments: TSaveOpenedDocuments;

implementation
uses
  formWorkForm;

{$R *.lfm}

{ TSaveOpenedDocuments }

procedure TSaveOpenedDocuments.bSaveClick(Sender: TObject);
var
  i:Integer;
begin

  for i:=0 to clbDocumentList.Count-1 do
  begin
    if clbDocumentList.Checked[i] then
    begin
      TpageControl(TTabSheet(TWorkForm(clbDocumentList.Items.Objects[i]).Parent).Parent).PageIndex :=
        TTabSheet(TWorkForm(clbDocumentList.Items.Objects[i]).Parent).TabIndex;
      TWorkForm(clbDocumentList.Items.Objects[i]).bSaveClick(self);
    end;
    TWorkForm(clbDocumentList.Items.Objects[i]).Close;
  end;
end;

procedure TSaveOpenedDocuments.FormShow(Sender: TObject);
var
  i: integer;
begin

  Exit;


  clbDocumentList.Clear;

  for i := 0 to screen.FormCount - 1 do
  begin
    if screen.Forms[i].ClassParent.ClassNameIs('TWorkForm') then
      if TWorkForm(screen.Forms[i]).bSave.Enabled then
      begin
        clbDocumentList.AddItem(TWorkForm(screen.Forms[i]).Caption, screen.Forms[i]);
        clbDocumentList.Checked[SaveOpenedDocuments.clbDocumentList.Count - 1] := true;
      end;
  end;

end;

end.

