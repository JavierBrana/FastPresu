unit formCalendarEditor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, NiceCalendar, Forms, Controls, Graphics, Dialogs,
  DbCtrls, ExtCtrls, StdCtrls, Buttons;

type

  { TCalendarEditor }

  TCalendarEditor = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbSaturdays: TCheckBox;
    cbSundays: TCheckBox;
    DBListBox1: TDBListBox;
    NiceCalendar: TNiceCalendar;
    Panel1: TPanel;
    SelectTypeDay: TRadioGroup;
    procedure cbSaturdaysChange(Sender: TObject);
    procedure cbSundaysChange(Sender: TObject);
    procedure NiceCalendarDateChange(Sender: TObject; Date: TDateTime);
    procedure NiceCalendarMonthChange(Sender: TObject; Date: TDateTime);
    procedure SelectTypeDaySelectionChanged(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  CalendarEditor: TCalendarEditor;

implementation

{$R *.lfm}

{ TCalendarEditor }

procedure TCalendarEditor.SelectTypeDaySelectionChanged(Sender: TObject);
begin
  if SelectTypeDay.ItemIndex > 0 then NiceCalendar.TodayMark := true
  else NiceCalendar.TodayMark := false;
end;

procedure TCalendarEditor.NiceCalendarDateChange(Sender: TObject;
  Date: TDateTime);
begin
  if NiceCalendar.TodayMark then SelectTypeDay.ItemIndex := 1
  else SelectTypeDay.ItemIndex := 0;
end;

procedure TCalendarEditor.NiceCalendarMonthChange(Sender: TObject; Date: TDateTime);
begin
  NiceCalendar.MarkDays(dtSunday, cbSundays.Checked);
  NiceCalendar.MarkDays(dtSaturday, cbSaturdays.Checked);
end;

procedure TCalendarEditor.cbSundaysChange(Sender: TObject);
begin
  NiceCalendar.MarkDays(dtSunday, cbSundays.Checked);
end;

procedure TCalendarEditor.cbSaturdaysChange(Sender: TObject);
begin
  NiceCalendar.MarkDays(dtSaturday, cbSaturdays.Checked);
end;

end.

