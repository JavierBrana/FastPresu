{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit NiceGridLazarus;

interface

uses
  NiceEditors, NiceGrid, NiceGridReg, NiceLookUpComboBox, NiceDividerBevel, 
  CustomNiceListBox, NicePageControl, NiceCustomPanel, NiceDBEdit, gsGantt, 
  NiceCalendar, NiceTabControl, NiceCustomPanelList, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('NiceGridReg', @NiceGridReg.Register);
  RegisterUnit('NiceDividerBevel', @NiceDividerBevel.Register);
  RegisterUnit('CustomNiceListBox', @CustomNiceListBox.Register);
  RegisterUnit('NicePageControl', @NicePageControl.Register);
  RegisterUnit('NiceCustomPanel', @NiceCustomPanel.Register);
  RegisterUnit('NiceDBEdit', @NiceDBEdit.Register);
  RegisterUnit('gsGantt', @gsGantt.Register);
  RegisterUnit('NiceCalendar', @NiceCalendar.Register);
  RegisterUnit('NiceTabControl', @NiceTabControl.Register);
  RegisterUnit('NiceCustomPanelList', @NiceCustomPanelList.Register);
end;

initialization
  RegisterPackage('NiceGridLazarus', @Register);
end.
