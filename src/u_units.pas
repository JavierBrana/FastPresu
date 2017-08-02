unit u_units;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

// Versiones futuras: añadir más unidades
const
  UnitOfPercent: array [0..0] of string = ('%');

  UnitsOfTime: array [0..6] of string = ('año', 'mes', 'sem', 'dia', 'h', 'min', 's');
  UnitOfDistance: array [0..2] of string = ('km', 'm', 'ml');
  UnitOfArea: array [0..2] of string = ('hec', 'are', 'm2');
  UnitOfVolumen: array [0..3] of string = ('hm3', 'm3', 'hl', 'l');
  UnitOfMass: array [0..2] of string = ('tn', 'kg', 'g');

  //ArrayOfUnits: array [0..4] of array of string = (UnitsOfTime, UnitOfDistance,
  //              UnitOfArea, UnitOfVolumen, UnitOfMass);

function ConverUnits(Amount: double; UnitFrom, UnitTo: String): double;

implementation

uses
  ConvUtils, StdConvs, StrUtils;

function GetConvType(aUnit: string):TConvType;
begin
  case aUnit of
    // Time:
    'año': Result := tuYears;
    'mes': Result := tuMonths;
    'sem': Result := tuWeeks;
    'dia': Result := tuDays;
    'h':   Result := tuHours;
    'min': Result := tuMinutes;
    's':   Result := tuSeconds;
    // Distance:
    'km':  Result := duKiloMeters;
    'm':   Result := duMeters;
    'ml':  Result := duMeters;
    // Area:
    'hec': Result := auHectares;
    'are': Result := auAres;
    'm2':  Result := auSquareMeters;
    // Volumen
    'hm3': Result := vuCubicHectometers;
    'm3':  Result := vuCubicMeters;
    'hl':  Result := vuHectoLiters;
    'l':   Result := vuLiters;
    // Mass
    'tn': Result := muTons;
    'kg': Result := muKilograms;
    'g':  Result := muGrams
    else Result := 0;
  end;
end;

function ConverUnits(Amount: double; UnitFrom, UnitTo: String): double;
begin
  {if AnsiMatchText(UnitFrom, UnitsOfTime) and AnsiMatchText(UnitTo, UnitsOfTime) then
  else if AnsiMatchText(UnitFrom, UnitOfDistance) and AnsiMatchText(UnitTo, UnitOfDistance) then;
  else if AnsiMatchText(UnitFrom, UnitOfArea) and AnsiMatchText(UnitTo, UnitOfArea) then;
  else if AnsiMatchText(UnitFrom, UnitOfVolumen) and AnsiMatchText(UnitTo, UnitOfVolumen) then;
  else if AnsiMatchText(UnitFrom, UnitOfMass) and AnsiMatchText(UnitTo, UnitOfMass) then;
  //else if (UnitFrom in UnitsOfTime) and (UnitTo in UnitsOfTime) then;}

  if UnitFrom = UnitTo then
    Result := Amount
  else
    Result := Convert(Amount, GetConvType(UnitFrom), GetConvType(UnitTo));
end;

end.

