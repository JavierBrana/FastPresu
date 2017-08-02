unit FormMainWindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCPanel, BCButton, BCLabel, BGRAVirtualScreen,
  BGRAImageList, IDEWindowIntf, NiceDividerBevel,
  NicePageControl, ZConnection, ZDataset,
  ZConnectionGroup, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, ComCtrls, DBCtrls, Menus, ExtDlgs,
  framePrint, DB, IniFiles, LMessages;

type

  { TMainWindow }
  TMainWindow = class(TForm)
    bCompanyCloseMenu: TBitBtn;
    bCompanyCloseMenu1: TBitBtn;
    bDocVenta: TBCButton;
    bDocVenta1: TBCButton;
    bDocVenta2: TBCButton;
    bMenu: TBCButton;
    bPeople: TBCButton;
    btnClose: TBCButton;
    btnMaximize: TBCButton;
    btnMinimize: TBCButton;
    btnTool1: TBCButton;
    btnTool2: TBCButton;
    btnTool3: TBCButton;
    bOpenDBConfigForm: TBitBtn;
    bOpenCpiesConfigForm: TBitBtn;
    bCompanyCreateMenu: TBitBtn;
    bCompanyCreateMenu1: TBitBtn;
    bCompanyEditMenu: TBitBtn;
    bCompanyEditMenu1: TBitBtn;
    bCompanyOpenMenu: TBitBtn;
    bCompanyOpenMenu1: TBitBtn;
    bImportElementsDB: TBitBtn;
    bMenuDBOperations: TBCButton;
    bUserMenu: TBCButton;
    DBImage1: TDBImage;
    dbtDateCreation: TDBText;
    dbtDirAdr1: TDBText;
    dbtDirAdr2: TDBText;
    dbtDirCP: TDBText;
    dbtDirFax: TDBText;
    dbtDirMail: TDBText;
    dbtDirMov: TDBText;
    dbtDirPais: TDBText;
    dbtDirProv: TDBText;
    dbtDirTel: TDBText;
    dbtDirVill: TDBText;
    dbtDirWeb: TDBText;
    dbtName: TDBText;
    dbtNIF: TDBText;
    dsCompany: TDataSource;
    General_16: TImageList;
    Elements_16: TImageList;
    ImageList16: TBGRAImageList;
    ImageList16White: TBGRAImageList;
    ImageList32: TBGRAImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblTitle: TBCButton;
    lPointer: TBCLabel;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    miElements: TMenuItem;
    miFamilies: TMenuItem;
    miListUsers: TMenuItem;
    miNewUser: TMenuItem;
    miCloseUser: TMenuItem;
    miBudget: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    NiceDividerBevel1: TNiceDividerBevel;
    NiceDividerBevel10: TNiceDividerBevel;
    NiceDividerBevel2: TNiceDividerBevel;
    NiceDividerBevel3: TNiceDividerBevel;
    NiceDividerBevel4: TNiceDividerBevel;
    NiceDividerBevel5: TNiceDividerBevel;
    NiceDividerBevel6: TNiceDividerBevel;
    NiceDividerBevel7: TNiceDividerBevel;
    NiceDividerBevel8: TNiceDividerBevel;
    NiceDividerBevel9: TNiceDividerBevel;
    OpenDialog: TOpenDialog;
    OpenPictureDialog: TOpenPictureDialog;
    Page1: TPage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    pButtonsMenu: TPanel;
    pmDocCompra: TPopupMenu;
    pmPersonas: TPopupMenu;
    pmDocVenta: TPopupMenu;
    pmOthers: TPopupMenu;
    pmUsers: TPopupMenu;
    TabDockCenter: TNicePageControl;
    bMenuNew: TBCButton;
    bMenuPrint: TBCButton;
    bMenuCompany3: TBCButton;
    bMenuCompany4: TBCButton;
    MenuButtonsPanel: TBCPanel;
    bMenuCompany: TBCButton;
    nbPages: TNotebook;
    nbMenuPages: TNotebook;
    MenuCompanyPage: TPage;
    MenuNewPage: TPage;
    MenuPrintPage: TPage;
    PrintPage: TPage;
    TopPanel: TPanel;
    vsTitle: TBGRAVirtualScreen;
    WorkPage: TPage;
    MenuPage: TPage;
    zcMainConnection: TZConnection;
    ZConnectionGroup1: TZConnectionGroup;
    ztCompany: TZTable;
    ztCompanyADDRESS1: TStringField;
    ztCompanyADDRESS2: TStringField;
    ztCompanyBANK_NAME: TStringField;
    ztCompanyBIC_SWIFT: TStringField;
    ztCompanyCITY: TStringField;
    ztCompanyCNAE: TStringField;
    ztCompanyCOMMUNITY_CIF: TStringField;
    ztCompanyCOUNTRY: TStringField;
    ztCompanyCREATEDAT: TDateField;
    ztCompanyCREATEDBY: TStringField;
    ztCompanyDCNAE: TStringField;
    ztCompanyEMAIL: TStringField;
    ztCompanyFAX: TStringField;
    ztCompanyIAE: TStringField;
    ztCompanyIBAN: TStringField;
    ztCompanyID: TLargeintField;
    ztCompanyID_NUMBER: TStringField;
    ztCompanyLOGO1: TBlobField;
    ztCompanyLOGO2: TBlobField;
    ztCompanyLOGO3: TBlobField;
    ztCompanyMOBILE: TStringField;
    ztCompanyNAME: TStringField;
    ztCompanyPHONE: TStringField;
    ztCompanyPOSTCODE: TStringField;
    ztCompanyPROVINCE: TStringField;
    ztCompanyWEB: TStringField;
    procedure bCompanyOpenMenuClick(Sender: TObject);
    procedure bCompanyCreateMenuClick(Sender: TObject);
    procedure bCompanyCloseMenuClick(Sender: TObject);
    procedure bCompanyEditMenuClick(Sender: TObject);
    procedure bOpenDBConfigFormClick(Sender: TObject);
    procedure bImportElementsDBClick(Sender: TObject);
    procedure bMenuClick(Sender: TObject);
    procedure bMenuCompany4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuButtonsClick(Sender: TObject);
    procedure MenuButtonsCompraClick(Sender: TObject);
    procedure MenuButtonsVentaClick(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
		procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure miCloseUserClick(Sender: TObject);
    procedure miFamiliesClick(Sender: TObject);
    procedure miNewUserClick(Sender: TObject);
    procedure pmUsersPopup(Sender: TObject);
    procedure PrintPageBeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: integer);
		procedure TabDockCenterAddTabSheet(Sender: TObject);
    procedure TabDockCenterDockOver(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure TabDockCenterDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TabDockCenterEnter(Sender: TObject);
    procedure TabDockCenterMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure WorkPageBeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: Integer);
    procedure zcMainConnectionAfterConnect(Sender: TObject);

  protected
    //procedure CMShowingChanged(var Message: TLMessage); message CM_SHOWINGCHANGED;

  private
    { private declarations }
    FCompany: ansistring;
    INIFile: TIniFile;

    procedure OpenCompanyShow;
    procedure CloseCompany;
    procedure CreateCompany;
    procedure DisableControls;
    procedure EnableControls;

    function  OnReloadControl(const CtrlName: string; ASite: TWinControl): TControl;
    function  OnSaveControl(ACtrl: TControl): string;
  public
    { public declarations }
    frame: TPrintFrame;

    constructor Create(TheOwner: TComponent); override;
    destructor destroy; Override;

    function ConnectDB: boolean;
    function SetDataBase(DB, Company: ansistring): boolean;
    procedure SetUser(aUser: ansistring);

    procedure OpenUserConfiguration;



    // Propiedades:
    property Company: ansistring read FCompany;

  end;

var
  MainWindow: TMainWindow;

implementation

uses
  // Frames:
  frameDataBaseConfig,
  framecompanyedit,

  // Forms:
  formWorkForm,
  formOpenCompany,
  formCreateCompanyWizard,
  formConfigWindow,

  formForm,
  formUser,
  formContact,
  formContactList,
  formElement,
  formElementsList,
  formBuyDocuments,
  formBuyDocumentsList,
  formSupplier,
  formSupplierstList,
  formBudgets,
  formSaleDocuments,
  formSaleDocumentsList,
  formClient,
  formClientList,
  formProjects,
  formProjectsList,
  formImportDBWizard,
  FormSaveOpenedDocuments,
  {$IFDEF DEBUG}
  FormDebug,
  {$ENDIF}

  // Units:
  Utiles,
  DatabaseDefine,
  u_variables,

  // Others:
  windows, StrUtils,

  EasyDockSite,
  uMakeSite;

{$R *.lfm}

{ TMainWindow }

constructor TMainWindow.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TMainWindow.destroy;
begin
  inherited;
end;

procedure TMainWindow.bMenuClick(Sender: TObject);
begin
  bMenu.Down := not bMenu.Down;
  if bMenu.Down then
  begin
    nbPages.PageIndex := 1;
    MenuButtonsClick(bMenuCompany);
  end
  else
    nbPages.PageIndex := 0;
end;

procedure TMainWindow.bMenuCompany4Click(Sender: TObject);
begin
  // Abrir dialogo de configuración
  TConfigWindow.Create(Application).Show;
  bMenuClick(bMenu);
end;

procedure TMainWindow.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FUser.IsUserOpen then
    miCloseUserClick(self);
end;

procedure TMainWindow.FormCreate(Sender: TObject);
var
 val: Integer;
begin
  frame := nil;

  // Docking  ----------- Prueba
  TDockMaster.Create(self);
  DockMaster.OnSave := @OnSaveControl;
  DockMaster.OnRestore := @OnReloadControl;
  DockMaster.AddElasticSites(TCustomForm(WorkPage), [alLeft, alRight, alBottom]);
  DockMaster.ForIDE := true;
  //--------------------------------------

  {$IFDEF DEBUG}
  Application.CreateForm(TDebugForm, DebugForm);
  //DebugForm.ManualDock(TWinControl(Dockmaster.Components[0]), nil, alTop);
  //DebugForm.Show;
  {$ENDIF}
end;

procedure TMainWindow.bCompanyOpenMenuClick(Sender: TObject);
begin
  bMenuClick(bMenu);
  CloseCompany;
  OpenCompanyShow;
end;

procedure TMainWindow.bCompanyCreateMenuClick(Sender: TObject);
begin
  bMenuClick(bMenu);
  CloseCompany;
  CreateCompany;
end;

procedure TMainWindow.bCompanyCloseMenuClick(Sender: TObject);
begin
  CloseCompany;
end;

procedure TMainWindow.bCompanyEditMenuClick(Sender: TObject);
var
  EditCompany: TEditCompany;
begin
  bMenuClick(bMenu);
  nbPages.Pages.Add('CompanyEditPage');
  nbPages.Page[nbPages.PageCount - 1].Name := 'CompanyEditPage';
  EditCompany := TEditCompany.Create(nbPages.Page[nbPages.PageCount - 1]);
  EditCompany.Parent := nbPages.Page[nbPages.PageCount - 1];
  EditCompany.Align := alClient;
  nbPages.PageIndex := 2;
  bMenu.Enabled := False;
end;

procedure TMainWindow.bOpenDBConfigFormClick(Sender: TObject);
var
  EditDBPage: TfrDataBaseConfig;
begin
  nbPages.Pages.Add('EditDBPage');
  nbPages.Page[nbPages.PageCount - 1].Name := 'EditDBPage';
  EditDBPage := TfrDataBaseConfig.Create(nbPages.Page[nbPages.PageCount - 1]);
  EditDBPage.Parent := nbPages.Page[nbPages.PageCount - 1];
  EditDBPage.Align := alClient;
  nbPages.PageIndex := 2;
  bMenu.Enabled := False;
end;

procedure TMainWindow.bImportElementsDBClick(Sender: TObject);
begin
  TfImportDBWizard.Create(Application).Show;
end;

procedure TMainWindow.MenuButtonsClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MenuButtonsPanel.ControlCount - 1 do
  begin
    if not MenuButtonsPanel.Controls[i].ClassNameIs('TBCButton') then continue;
    if TBCButton(Sender).Tag <> TBCButton(MenuButtonsPanel.Controls[i]).Tag then
      TBCButton(MenuButtonsPanel.Controls[i]).Down := False
    else
    begin
      TBCButton(Sender).Down := True;
      lPointer.Top := TBCButton(Sender).Top;
      lPointer.Background.Color := nbMenuPages.Page[TBCButton(Sender).Tag].Color;
    end;
  end;

  if Assigned(frame) and (TBCButton(Sender).Tag <> 3) then
  begin
    frame.Destroy;
    frame := nil;
  end;
  nbMenuPages.PageIndex := TBCButton(Sender).Tag;
end;

procedure TMainWindow.MenuButtonsCompraClick(Sender: TObject);
begin
  if TMenuItem(Sender).Tag = 0 then
    TBudgets.Create(Application, '', TMenuItem(Sender).Tag).Show
  else TSaleDocuments.Create(Application, '', TMenuItem(Sender).Tag).Show;
end;

procedure TMainWindow.MenuButtonsVentaClick(Sender: TObject);
begin
  TBuyDocuments.Create(Application, '', TMenuItem(Sender).Tag).Show;
end;

procedure TMainWindow.MenuItem15Click(Sender: TObject);
begin
  if not assigned(BuyDocumentsList) then
    BuyDocumentsList := TBuyDocumentsList.Create(Application);
  BuyDocumentsList.Show;
  BuyDocumentsList.SetFocus;
end;

procedure TMainWindow.MenuItem1Click(Sender: TObject);
begin
  if not Assigned(ClientList) then
    ClientList := TClientList.Create(Application);
  ClientList.Show;
  ClientList.SetFocus;
end;

procedure TMainWindow.MenuItem2Click(Sender: TObject);
begin
  TClient.Create(Application, '').Show;
end;

procedure TMainWindow.MenuItem4Click(Sender: TObject);
begin
  if not assigned(SupplierstList) then
    SupplierstList := TSupplierstList.Create(Application);
  SupplierstList.Show;
  SupplierstList.SetFocus;
end;

procedure TMainWindow.MenuItem5Click(Sender: TObject);
begin
  TSupplier.Create(Application, '').Show;
end;

procedure TMainWindow.MenuItem7Click(Sender: TObject);
begin
  if not assigned(ContactList) then
    ContactList := TContactList.Create(Application);
  ContactList.Show;
  ContactList.SetFocus;
end;

procedure TMainWindow.MenuItem8Click(Sender: TObject);
begin
  //TContact.Create(Application, '').Show;
end;

procedure TMainWindow.MenuItem9Click(Sender: TObject);
begin
  if not assigned(SaleDocumentsList) then
    SaleDocumentsList := TSaleDocumentsList.Create(Application);
  SaleDocumentsList.Show;
  SaleDocumentsList.SetFocus;
end;

procedure TMainWindow.miCloseUserClick(Sender: TObject);
  procedure SaveFormConfig(aForm: TForm);
  begin
    INIFile := TIniFile.Create(ConfigFile);
    try
      INIFile.WriteInteger(aForm.Name, 'WindowState', Integer(aForm.WindowState));
      INIFile.WriteInteger(aForm.Name, 'Left', aForm.Left);
      INIFile.WriteInteger(aForm.Name, 'Top', aForm.Top);
      INIFile.WriteInteger(aForm.Name, 'Width', aForm.Width);
      INIFile.WriteInteger(aForm.Name, 'Height', aForm.Height);
    finally
      INIFile.Free;
    end;
  end;

  procedure SaveDockSite(aControl: TWinControl);
  var
    i: integer;
  begin
    for i := 0 to aControl.ControlCount - 1 do
    begin
      if aControl.Controls[i].ClassName = 'TEasyDockBook' then
        SaveDockSite(TWinControl(aControl.Controls[i]));
      {$IFDEF DEBUG}
      dgSetLine(aControl.Controls[i].ClassName);
      {$ENDIF}
    end;
  end;

var
  i: integer;
  strm: TFileStream;

  db: ansistring;
begin

  SaveOpenedDocuments.clbDocumentList.Clear;

  for i := 0 to screen.FormCount - 1 do
  begin
    if screen.Forms[i].ClassParent.ClassNameIs('TWorkForm') then
      if TWorkForm(screen.Forms[i]).bSave.Enabled then
      begin
        SaveOpenedDocuments.clbDocumentList.AddItem(TWorkForm(screen.Forms[i]).Caption, screen.Forms[i]);
        SaveOpenedDocuments.clbDocumentList.Checked[SaveOpenedDocuments.clbDocumentList.Count - 1] := true;
      end;
  end;

  if SaveOpenedDocuments.clbDocumentList.Count > 0 then
    case SaveOpenedDocuments.ShowModal of
      mrCancel: Abort;
    end;

  // Salvar la configuración de los formularios:
  for i := 0 to screen.FormCount - 1 do
  begin
    if Screen.Forms[i].ClassParent.ClassNameIs('TListForm') then
    begin
      {$IFDEF DEBUG}
      dgSetLine(IntToStr(i) + '. Cerrando: ' + screen.Forms[i].Name + ' - ' + Screen.Forms[i].ClassParent.ClassName);
      {$ENDIF}
      Screen.Forms[i].Visible := false;
      if not Screen.Forms[i].Floating then
        Screen.Forms[i].ManualFloat(Screen.Forms[i].ClientRect) ;
      Screen.Forms[i].Close;
    end
    else
    begin
      {$IFDEF DEBUG}
      dgSetLine(IntToStr(i) + '. Ignorado: ' + screen.Forms[i].Name + ' - ' + Screen.Forms[i].ClassParent.ClassName);
      {$ENDIF}
    end;
  end;

  DisableControls;
  FUser.ClearUser;
end;

procedure TMainWindow.miFamiliesClick(Sender: TObject);
var
  form: TForm;
begin
  form := TAllForms.Create(Application, '', TMenuItem(Sender).MenuIndex);
  form.ManualDock(TabDockCenter);
  form.Show;
end;

procedure TMainWindow.miNewUserClick(Sender: TObject);
var
  form: TForm;
begin
  form := TUserForm.Create(Application, '');
  form.ManualDock(TabDockCenter);
  form.Show;
end;

procedure TMainWindow.pmUsersPopup(Sender: TObject);
var
  i: integer;
begin
  if FUser.UserType = 0 then
  begin
    for i:=1 to pmUsers.Items.Count - 1 do
      pmUsers.Items[i].Visible := true;
  end
  else
  begin
    for i:=1 to pmUsers.Items.Count - 1 do
      pmUsers.Items[i].Visible := false;
  end;
end;

procedure TMainWindow.PrintPageBeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: integer);
begin
  frame := TPrintFrame.Create(PrintPage);
  frame.Parent := PrintPage;
  frame.Align := alClient;
end;

procedure TMainWindow.TabDockCenterAddTabSheet(Sender: TObject);
begin
  TabDockCenter.ActivePageIndex := TabDockCenter.PageCount-1;
end;

procedure TMainWindow.TabDockCenterDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean
  );
begin
  if Sender is TNicePageControl then
    Accept := True;
end;

procedure TMainWindow.TabDockCenterDragDrop(Sender, Source: TObject; X,
  Y: Integer);
const
  TCM_GETITEMRECT = $130A;
var
  i: Integer;
  r: TRect;
  pt : TPoint;
begin
  if not (Sender is TNicePageControl) then Exit;
  with TabDockCenter do
  begin
    for i := 0 to PageCount - 1 do
    begin
      Perform(TCM_GETITEMRECT, i, lParam(@r));
      pt.x := X;
      pt.y := Y;
      if PtInRect(r, pt) then
      begin
        if i <> ActivePage.PageIndex then
          ActivePage.PageIndex := i;
        Exit;
      end;
    end;
  end;
end;

procedure TMainWindow.TabDockCenterEnter(Sender: TObject);
begin
  Caption := TForm(TabDockCenter.Page[TabDockCenter.PageIndex].Controls[0]).Caption;
end;

procedure TMainWindow.TabDockCenterMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TabDockCenter.BeginDrag(False);
end;

procedure TMainWindow.WorkPageBeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: Integer);
begin

end;

procedure TMainWindow.zcMainConnectionAfterConnect(Sender: TObject);
begin

end;

procedure TMainWindow.OpenCompanyShow;
begin
  if not Assigned(OpenCompanyWindow) then
    OpenCompanyWindow := TOpenCompanyWindow.Create(Application);

  OpenCompanyWindow.ShowModal;
end;

procedure TMainWindow.CloseCompany;
var
  db: ansistring;
  i: integer;

  //Dir: TStringList;
begin

  if Fuser.IsUserOpen then miCloseUserClick(self);

  zcMainConnection.Connected := False;
  if zcMainConnection.Protocol = 'sqlite-3' then
    db := DefaultDir + 'ENTERPRISES.db'
  else
    db := 'ENTERPRISES';

  zcMainConnection.Database := db;
  zcMainConnection.Connected := True;
end;

procedure TMainWindow.CreateCompany;
begin
  if CreateCompanyWizard = nil then
    CreateCompanyWizard := TCreateCompanyWizard.Create(Application);
  CreateCompanyWizard.ShowModal;
end;

procedure TMainWindow.DisableControls;
begin
  bMenuNew.Enabled := False;
  bMenuPrint.Enabled := False;
  bMenuDBOperations.Enabled := False;

  bCompanyEditMenu.Enabled := False;
  bCompanyCloseMenu.Enabled := False;

  bOpenDBConfigForm.Enabled := False;

  TabDockCenter.Visible := False;
  bUserMenu.Visible := False;

  pButtonsMenu.Enabled := false;
  pButtonsMenu.Visible := false;
end;

procedure TMainWindow.EnableControls;
begin
  bMenuNew.Enabled := True;
  bMenuPrint.Enabled := True;
  bMenuDBOperations.Enabled := True;

  bCompanyEditMenu.Enabled := True;
  bCompanyCloseMenu.Enabled := True;

  bOpenDBConfigForm.Enabled := True;

  TabDockCenter.Visible := True;
  bUserMenu.Visible := True;

  pButtonsMenu.Enabled := True;
  pButtonsMenu.Visible := True;
end;

function TMainWindow.SetDataBase(DB, Company: ansistring): boolean;
begin
  if DB = '' then Exit;

  zcMainConnection.Connected := False;
  zcMainConnection.Database := DB;
  zcMainConnection.Connected := True;

  Result := zcMainConnection.Connected;

  if not zcMainConnection.Connected then
  begin
    Exit;
  end;

  FCompany := Company;
  Caption := FCompany;
  ztCompany.Active := True;
end;

procedure TMainWindow.SetUser(aUser: ansistring);
var
  ZQ: TZQUery;
begin

  ZQ := TZQuery.Create(self);
  try
    ZQ.Connection := zcMainConnection;
    sqlEXEC(ZQ, 'SELECT * FROM USERS WHERE USERNAME = ' + QuotedStr(aUser));
    FUser.UserType := ZQ.FieldByName('USERTYPE').AsInteger;
    FUser.UserName := aUser;
    FUser.SetPermits(ZQ.FieldByName('PERMITS').AsString);
  finally
    ZQ.Free;
  end;

  bUserMenu.Caption := aUser;
  OpenUserConfiguration;
end;

procedure TMainWindow.OpenUserConfiguration;
var
  i: integer;
begin
  // Abrir la configuración por defecto o la guardada
  EnableControls;

  // Ejemplo:
  ElementsList := TElementsList.Create(Application);
  ElementsList.ManualDock(TWinControl(Dockmaster.Components[1]), nil, alClient);
  ElementsList.Show;

  BuyDocumentsList := TBuyDocumentsList.Create(Application);
  BuyDocumentsList.ManualDock(TWinControl(Dockmaster.Components[1]), nil, alBottom);
  BuyDocumentsList.Show;

  SaleDocumentsList := TSaleDocumentsList.Create(Application);
  SaleDocumentsList.ManualDock(BuyDocumentsList.Parent, BuyDocumentsList, alCustom);
  SaleDocumentsList.Show;

  ProjectsList := TProjectsList.Create(Application);
  ProjectsList.ManualDock(TWinControl(Dockmaster.Components[2]), nil, alTop);
  ProjectsList.Show;

  //TWinControl(DockMaster.DockSites[0]).Width := 450;
  //TWinControl(DockMaster.DockSites[1]).Width := 400;
end;

function TMainWindow.ConnectDB: boolean;
begin
  //zcMainConnection.LibraryLocation := ExtractFilePath(Application.ExeName) + 'sqlite3.dll';
  //zcMainConnection.LibLocation := ExtractFilePath(Application.ExeName) + 'sqlite3.dll';

  // TODO:
  // select the correct dll depending on the zcMainConnection.Protocol
  {
  case zcMainConnection.Protocol of
  end;
  }

  zcMainConnection.Connected := false;
  try
    zcMainConnection.Connected := true;
  except
  end;
  Result := zcMainConnection.Connected;
end;




function  TMainWindow.OnReloadControl(const CtrlName: string; ASite: TWinControl): TControl;
begin

end;

function  TMainWindow.OnSaveControl(ACtrl: TControl): string;
var
  i: integer;
  //ep: TEditPage;
  ss: TStringStream;
begin
(* handle special cases:
  ViewWindow
  EditBook
*)
  if ACtrl.ClassParent.ClassNameIs('TWorkForm') then
  begin
    Result := '@' + ACtrl.Caption
  end
  {else if ACtrl is TEditBook then
  begin
    ss := TStringStream.Create('');
    try
      TEditBook(ACtrl).SaveToStream(ss);
      Result := ss.DataString;
    finally
      ss.Free;
    end;
    //Result := ',' + TWinControl(ACtrl).GetDockCaption(ACtrl);
  end}
  else
    Result := ''; //unhandled
    //Result := ACtrl.HostDockSite.GetDockCaption(ACtrl);
end;

end.
