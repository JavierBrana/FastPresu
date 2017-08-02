unit formProjectsList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, SpkRollPanel, ZVDateTimePicker, ZDataset,
  gsGantt, NiceCustomPanel, Forms, formListForm, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, DBGrids, Buttons;

type

  { TProjectsList }

  TProjectsList = class(TListForm)
    bDelete: TSpeedButton;
    bEdit: TSpeedButton;
    bNew: TSpeedButton;
    bPrint: TSpeedButton;
    cbDate: TCheckBox;
    dsProyectsList: TDataSource;
    dtBegin: TZVDateTimePicker;
    dtEnd: TZVDateTimePicker;
    edFilter: TEdit;
    edFilterDate: TComboBox;
    edFilterSelector: TComboBox;
    Grid: TDBGrid;
    gsGantt: TgsGantt;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    pFooter: TPanel;
    pMoreOptions: TSpkRollPanel;
    tsList: TTabSheet;
    tsGantt: TTabSheet;
    ztProyectsList: TZTable;
    ztProyectsListADDRESS1: TStringField;
    ztProyectsListADDRESS2: TStringField;
    ztProyectsListCITY: TStringField;
    ztProyectsListCODE: TStringField;
    ztProyectsListCONTACT: TStringField;
    ztProyectsListCREATEDAT: TDateTimeField;
    ztProyectsListCREATEDBY: TStringField;
    ztProyectsListCUSTOMER_CODE: TStringField;
    ztProyectsListCUSTOMER_NAME: TStringField;
    ztProyectsListDURATION: TDateTimeField;
    ztProyectsListEMAIL: TStringField;
    ztProyectsListID: TLongintField;
    ztProyectsListMOBILE: TStringField;
    ztProyectsListPHONE: TStringField;
    ztProyectsListPOSTCODE: TStringField;
    ztProyectsListpyGantt: TBlobField;
    ztProyectsListSTART_DATE: TDateTimeField;
    ztProyectsListSTATE: TStringField;
    ztProyectsListTITLE: TStringField;
    procedure bDeleteClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ProjectsList: TProjectsList;

implementation

uses
  formMainWindow,
  formProjects;

{$R *.lfm}

{ TProjectsList }

procedure TProjectsList.bNewClick(Sender: TObject);
begin
  TProjects.Create(Application, '').Show;
end;

procedure TProjectsList.bEditClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztProyectsList.GotoBookmark(Grid.SelectedRows.Items[i]);
    TProjects.Create(Application, ztProyectsList.FieldByName('CODE').Text).Show;
  end;
end;

procedure TProjectsList.bDeleteClick(Sender: TObject);
var
  i: integer;
  ZQ: TZQuery;
begin
  ZQ := TZQuery.Create(self);
  ZQ.Connection := MainWindow.zcMainConnection;

  for i := 0 to Grid.SelectedRows.Count - 1 do
  begin
    ztProyectsList.GotoBookmark(Grid.SelectedRows.Items[i]);
    //sqlEXEC(ZQ, 'DELETE FROM Proyect WHERE ID = ' +
    //  QuotedStr(ztSaleDocs.FieldByName('dvdoID').Text));
    ztProyectsList.Delete;
  end;
  ztProyectsList.Refresh;
end;

procedure TProjectsList.FormCreate(Sender: TObject);
var
  Task: TInterval;
begin
  //gsGantt.Tree.Columns.Items[0].Visible := false;
  gsGantt.Tree.Columns.Items[4].Visible := false;
  gsGantt.Tree.Columns.Items[5].Visible := false;
  gsGantt.Tree.Columns.Items[6].Visible := false;
  gsGantt.MinorScale :=  tsDay;


  ztProyectsList.Active := true;
  PageControl1.TabIndex := 0;


  ztProyectsList.First;
  while not ztProyectsList.EOF do
  begin
    Task := TInterval.Create(gsGantt);
    Task.Project := ztProyectsList.FieldByName('CODE').Text;
    Task.Task := ztProyectsList.FieldByName('TITLE').Text;
    Task.StartDate := ztProyectsList.FieldByName('START_DATE').AsDateTime;
    Task.Duration := ztProyectsList.FieldByName('DURATION').AsDateTime;
    Task.Visible := true;

    gsGantt.AddInterval(Task);

    ztProyectsList.Next;
  end;
end;

procedure TProjectsList.FormPaint(Sender: TObject);
begin
  inherited;
end;

procedure TProjectsList.FormResize(Sender: TObject);
var
  w, i: integer;
begin
  w := pFooter.Width div pFooter.ControlCount;
  for i := 0 to pFooter.ControlCount - 1 do
  begin
    pFooter.Controls[i].Width := W;
    if pFooter.Width < 450 then
    begin
      TSpeedButton(pFooter.Controls[i]).ShowCaption := false;
    end
    else
      TSpeedButton(pFooter.Controls[i]).ShowCaption := true;
  end;
end;

procedure TProjectsList.GridDblClick(Sender: TObject);
var
  localPoint: TPoint;
begin
  //localPoint := Grid.ScreenToClient(Mouse.CursorPos);
  //localPoint := Grid.MouseToCell(localPoint);
  localPoint := Grid.MouseToCell(Mouse.CursorPos);
  if (localPoint.x>=0) and (localPoint.y>=0) then begin
    bEditClick(Sender);
  end;
end;

end.

