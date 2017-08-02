unit formContact;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, BCButton, BCPanel, NiceLookUpComboBox,
  ZDataset, Forms, formWorkForm, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, Buttons, ExtDlgs;

type

  { TContact }

  TContact = class(TWorkForm)
    BitBtn1: TBitBtn;
    bZoomMinus1: TBCButton;
    DBLookupComboBox2: TNiceLookUpComboBox;
    edForm: TNiceLookUpComboBox;
    dsContact: TDataSource;
    DBImage: TDBImage;
    dsForms: TDataSource;
    dsCompanies: TDataSource;
    edCode: TDBEdit;
    edFax: TDBEdit;
    edFax1: TDBEdit;
    edMovil: TDBEdit;
    edNIF: TDBEdit;
    edNIF1: TDBEdit;
    edNIF2: TDBEdit;
    edNombre: TDBEdit;
    edTel: TDBEdit;
    Image1: TImage;
    Image3: TImage;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel4: TPanel;
    zqContact: TZQuery;
    ztCompanies: TZQuery;
    ztForms: TZQuery;
		procedure bSaveClick(Sender: TObject);
		procedure dsContactDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Contact: TContact;

implementation
uses
  formMainWindow;

{$R *.lfm}

{ TContact }

procedure TContact.bSaveClick(Sender: TObject);
begin
  zqContact.Post;
end;

procedure TContact.dsContactDataChange(Sender: TObject; Field: TField);
begin
  case zqContact.State of
    dsEdit, dsInsert: bSave.Enabled := True;
    else bSave.Enabled := False;
  end;
end;

procedure TContact.FormCreate(Sender: TObject);
begin
  inherited;
  ManualDock(MainWindow.TabDockCenter);
end;

end.

