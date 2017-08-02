unit FormDebug;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ComCtrls;

type

  { TDebugForm }

  TDebugForm = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Memo1: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DebugForm: TDebugForm;

implementation
uses
  DatabaseDefine, Utiles, FormMainWindow;

{$R *.lfm}

{ TDebugForm }

procedure TDebugForm.FormCreate(Sender: TObject);
begin

end;

procedure TDebugForm.ListBox1Click(Sender: TObject);
begin

end;

procedure TDebugForm.Button1Click(Sender: TObject);
begin
  //sqlEXEC(ZQuery1,list[ListBox1.ItemIndex + 1]);
  //Writeln('Connecting to MySQL');
end;

end.

