unit Users;

{$mode objfpc}{$H+}


{------------------------------------------------------------------------------
Guardar en Base de datos:
Se guardará todo en un mismo registro:

ID | ¿NAME? | ¿SURNAME? | USERNAME | PASSWORD | USERTYPE | PERMITS | STATUS | ¿PICTURE?

 - Perminos
   1. Lectura (r): El usuario solo podrá ver los documentos, nunca modificarlos.
   2. Escritura (w): El usuario tendrá control total sobre los documentos.
      Este permiso sobreescribe los demás.
   3. Impresion (p): En el caso de que el usuario tenga permiso a leer podrá tener permiso a imprimir

 - Formato de guardar permisos en la DB:
   XX[---]    (7 caracteres como máximo)
   * donde:
     1. XX: será el tipo de documento.
     2. A continuación y entre corchetes se escribirán los permisos.
        Si no se dispone de uno o más permisos este se omite.

 - Separación entre permisos: ser realizará con una barra de separación: "|"
------------------------------------------------------------------------------}

interface

uses
  Classes, SysUtils;

type

  TPermit = class
  private
    FRead: boolean;
    FWrite: boolean;
    FPrint: boolean;
    FDocType: String;

    procedure SetRead(val: boolean);
    procedure SetWrite(val: boolean);
    procedure SetPrint(val: boolean);
  public
    constructor create(aDocType: string);
    function GetPermits: String;
    function SetPermits(Val: String): boolean;

    property Read: boolean read FRead write SetRead default false;
    property Write: boolean read FWrite write SetWrite default false;
    property Print: boolean read FPrint write SetPrint default false;
    property DocType: String read FDoctype;
  end;

  TUserPermits = class
  private
    FPermits: TList;
  public
    constructor create;
    destructor destroy;

    function AddDocPermit(aPermits: string): boolean;
    function AddDocPermit(aDocType: string; aRead, aWrite, aPrint: boolean): boolean;

    function GetDocPermit(aIndex: integer): TPermit;
    function GetDocPermit(aDocType: string): TPermit;

    function PermitsCount: integer;
  end;

  TUserClass = class
  private
    FUserPermits: TUserPermits;
    FName: string;
    FSurname: String;

    FUserName: String;
    FPassWord: String;
    FUserType: integer;

    FUserOpen: Boolean;

    procedure SetUserName(val: String);
    procedure SetUserType(val: Integer);

  public
    constructor create;
    destructor destroy;

    procedure ClearUser;

    property IsUserOpen: boolean read FUserOpen;

    procedure SetPermits(Values: string);
    function GetPermits: string;

    property Permits: TUserPermits read FUserPermits write FUserPermits;
    property UserType: integer read FUserType write SetUserType;
    property UserName: String read FUserName write SetUserName;
  end;

implementation

uses
  StrUtils;


{  TPermit  }
constructor TPermit.Create(aDocType: string);
begin
  FDocType := aDocType;
  FRead := true;
  FWrite := true;
  FPrint := true;
end;

function TPermit.GetPermits: String;
begin
  Result := FDocTYpe + '[';
  if FRead then Result := Result + 'r';
  if FWrite then Result := Result + 'w';
  if FPrint then Result := Result + 'p';
  Result := Result + ']';
end;

function TPermit.SetPermits(Val: String): boolean;
var
  tmp: string;
begin
  Result := false;
  if FDocType <> AnsiLeftStr(val, 2) then Exit;

  // 1234567
  // XX[---]
  tmp := AnsiMidStr(Val, 4, Length(Val) - 1);
  if AnsiContainsText(tmp, 'r') then FRead := true;
  if AnsiContainsText(tmp, 'w') then FWrite := true;
  if AnsiContainsText(tmp, 'p') then FPrint := true;
  Result := true;
end;

procedure TPermit.SetRead(val: boolean);
begin
  if FRead <> val then FRead := val;
end;

procedure TPermit.SetWrite(val: boolean);
begin
  if FWrite <> val then FWrite := val;
end;

procedure TPermit.SetPrint(val: boolean);
begin
  if FPrint <> val then FPrint := val;
end;

{  TUserPermits  }

constructor TUserPermits.create;
begin
  FPermits := TList.Create;
end;

destructor TUserPermits.destroy;
begin
  FPermits.Free;
end;

{
  Añade los permisos de un documento nuevo.
  Si ya existe los actualiza
}
function TUserPermits.AddDocPermit(aPermits: string): boolean;
var
  tmp: String;
  i: integer;
  p: TPermit;
begin
  tmp := AnsiLeftStr(aPermits, 2);
  for i := 0 to FPermits.Count - 1 do
  begin
    if TPermit(FPermits[i]).DocType = tmp then
    begin
      TPermit(FPermits[i]).SetPermits(aPermits);
      Exit;
    end;
  end;
  p := TPermit.create(tmp);
  p.SetPermits(aPermits);
  FPermits.Add(p);
end;

function TUserPermits.AddDocPermit(aDocType: string; aRead, aWrite, aPrint: boolean): boolean;
var
  i: integer;
  p: TPermit;
begin

  for i := 0 to FPermits.Count - 1 do
  begin
    if TPermit(FPermits[i]).DocType = aDocType then
    begin
      TPermit(FPermits[i]).Read := aRead;
      TPermit(FPermits[i]).Write := aWrite;
      TPermit(FPermits[i]).Print := aPrint;
      Exit;
    end;
  end;
  p := TPermit.create(aDocType);
  p.Read := aRead;
  p.Write := aWrite;
  p.Print := aPrint;
  FPermits.Add(p);
end;

function TUserPermits.GetDocPermit(aIndex: integer): TPermit;
begin
  Result := nil;
  if (aindex < 0) or (aIndex >= FPermits.Count) then exit;
  Result := TPermit(FPermits[aIndex]);
end;

function TUserPermits.GetDocPermit(aDocType: String): TPermit;
var
  i: integer;
begin
  Result := nil;

  for i:= 0 to FPermits.Count - 1 do
  begin
    if TPermit(FPermits[i]).DocType = aDocType then
    begin
      Result := TPermit(FPermits[i]);
      Exit;
    end;
  end;

  // Si llega aqui es que no existe y se crea uno nuevo:
  Result := TPermit.create(aDocType);
  FPermits.Add(Result);
end;

function TUserPermits.PermitsCount: integer;
begin
  Result := FPermits.Count;
end;

{  TUserClass  }

constructor TUserClass.create;
begin
  FName := '';
  FSurname := '';
  FUserName := '';
  FPassWord := '';
  FUserType := 0;
  FUserOpen := false;
  FUserPermits := TUserPermits.create;
end;

destructor TUserClass.destroy;
begin
  FUserPermits.Free;
end;

procedure TUserClass.ClearUser;
begin
  FName := '';
  FSurname := '';
  FUserName := '';
  FPassWord := '';
  FUserType := 0;
  FUserOpen := false;
end;

procedure TUserClass.SetPermits(Values: string);
var
  field : TStringList;
  i: integer;
begin
  field := TStringList.Create;
  try
    field.Clear;
    field.StrictDelimiter := true;
    field.Delimiter := '|';
    field.DelimitedText := Values;

    for i:= 0 to field.Count - 1 do
    begin
      FUserPermits.AddDocPermit(field[i]);
    end;
  finally
    field.Free;
  end;
end;

function TUserClass.GetPermits: string;
var
  i: integer;
begin
  Result := '';
  for i:= 0 to FUserPermits.PermitsCount - 1 do
  begin
    if Result <> '' then Result := Result + '|';
    Result := Result + FUserPermits.GetDocPermit(i).GetPermits;
  end;
end;

procedure TUserClass.SetUserName(val: String);
begin
  if self.FUserName <> val then
  begin
    FUserName := val;
    FUserOpen := true;
  end;
end;

procedure TUserClass.SetUserType(val: Integer);
begin
  if FUserType <> val then
    FUserType := Val;
end;

end.

