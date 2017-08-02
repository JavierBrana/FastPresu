unit u_variables;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, Users, u_Config, StrUtils;
var
  //DefaultDir := 'C:\ProgramData\FastPres\Empresas\';

  DefaultDir : string;
  ConfigFile : string;
  Separator : string;
  FUser: TUserClass;
  FConfig: TConfig;

  function InitVariables: String;

implementation

function InitVariables: String;
begin
  {$IFDEF LCLcarbon}
  Result := 'Mac OS X 10.';
  Separator := '/';
  {$ELSE}
  {$IFDEF Linux}
  Result := 'Linux Kernel ';
  Separator := '/';
  {$ELSE}
  {$IFDEF UNIX}
  Result := 'Unix ';
  Separator := '/';
  {$ELSE}
  {$IFDEF WINDOWS}
  Result := 'Windows';
  Separator := '\';
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}

  //GetUserDir
  //SysUtils.GetEnvironmentVariable('appdata')
  //SysUtils.GetEnvironmentVariable('localappdata')

  // Directorios:
  // Estructura de DefaultDir := homedir/ApplicationName/
  DefaultDir := SysUtils.GetEnvironmentVariable('localappdata');
  if not AnsiEndsText(DefaultDir, Separator) then
    DefaultDir := DefaultDir + Separator + ApplicationName + Separator;//Application.Name;
  ConfigFile :=  DefaultDir + 'config.ini';
end;

end.

