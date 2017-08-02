program FastPres;

{$mode objfpc}{$H+}

uses
  Classes, FileUtil, tachartlazaruspkg, SysUtils,
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, easydockmgr, FormMainWindow,
  u_variables, Users,u_Config,
  FormSaveOpenedDocuments, u_project_items_tree, u_defines, formSplash;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;

  // Iniciar variables:
  InitVariables;
  FConfig := TConfig.Create;
  FUser := TUserClass.create;

  // Crear los Formularios por defecto: ----------------------------------------
  SplashScreen := TSplashScreen.Create(nil) ;
  SplashScreen.ShowModal;
  SplashScreen.Update;
  Application.CreateForm(TSaveOpenedDocuments, SaveOpenedDocuments);
  // Ejecutar la aplicacion (main loop) ----------------------------------------
  Application.Run;

  // Al finalizar: -------------------------------------------------------------
  FConfig.Free;
  FUser.Free;
end.

