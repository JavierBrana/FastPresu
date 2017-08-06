unit NiceGrid;

{$MODE Delphi}
interface

uses
  LCLIntf, LCLType, Forms, Controls, LMessages, SysUtils, Classes, Graphics,
  Contnrs, StdCtrls, ExtCtrls, Clipbrd, lconvencoding,
  Themes, CalendarPopup, Calendar,
  NiceEditors, NiceLookUpComboBox, ImgList, DB, Menus, Buttons;

type
  // Control types
  TngControlTypes = (ctCheckBox, ctComboBox, ctDate, ctEdit, ctLookupComboBox,
    ctMemo, ctNumeric);
  TngBooleanType = (ngcbtCheckBox, ngcbtString);
  TngFormatTextType = (fttAsEntered, fttAsLowered, fttAsUpcase, fttAsName);
  //  TngFormatType     = (ftNone, ftNumeric, ftDateTime, ftBoolean);

  TGridStyle = (gsStandard, gsNative);


  PHeaderInfo = ^THeaderInfo;

  THeaderInfo = record
    Str: string;
    Rc: TRect;
  end;

  THorzAlign = (haLeft, haCenter, haRight);
  TVertAlign = (vaTop, vaCenter, vaBottom);
  TGutterKind = (gkNone, gkBlank, gkPointer, gkNumber, gkString);
  TGridHittest = (gtNone, gtLeftTop, gtLeft, gtTop, gtCell, gtColSizing, gtSmallBox);

  TNiceGrid = class;

  TNiceColumn = class(TCollectionItem)
  private
    FControlType: TngControlTypes;
    FCheckStyle: TngBooleanType;

    FComboBoxOptions: TComboBoxOptions;

    FFormatText: TngFormatTextType;
    FPrefix: string;
    FParenNegative: boolean;
    FDateFormat: integer;
    FTimeFormat: integer;
    FMaxLenght: integer;

    // Numeric
    FNumericOptions: TNumericOptions;
    FDecimals: integer;
    FThousands: boolean;
    FShowZero: boolean;

    FName: string;
    FTitle: string;
    FFooter: string;
    FWidth: integer;
    FFont: TFont;
    FColor: TColor;
    FHorzAlign: THorzAlign;
    FVertAlign: TVertAlign;
    FVisible: boolean;
    FStrings: TStrings;
    FTag: integer;
    FTag2: integer;
    FCanResize: boolean;
    FHint: string;
    FReadOnly: boolean;
    FWordBreak: boolean;
    FAllowShow: boolean;

    function GetGrid: TNiceGrid;
    function IsFontStored: boolean;
    procedure FontChange(Sender: TObject);
    procedure SetName(Value: string);
    procedure SetTitle(Value: string);
    procedure SetWidth(Value: integer);
    procedure SetFont(Value: TFont);
    procedure SetColor(Value: TColor);
    procedure SetHorzAlign(Value: THorzAlign);
    procedure SetVertAlign(Value: TVertAlign);
    procedure SetVisible(Value: boolean);
    procedure SetStrings(Value: TStrings);
    procedure SetFooter(const Value: string);

    procedure SetControlType(Value: TngControlTypes);
    function GetControlType: TngControlTypes;
    procedure SetFormatText(Value: TngFormatTextType);
    //function ShouldStoreDateFormatting : Boolean;
    procedure SetPrefix(Value: string);
    procedure SetDateFormat(Value: integer);
    procedure SetTimeFormat(Value: integer);
    procedure SetMaxLenght(Value: integer);
    procedure SetWordBreak(Value: boolean);

    procedure SetDecimals(Value: integer);
    procedure SetShowZero(Value: boolean);
    procedure SetThousands(Value: boolean);

    procedure SetNumericOptions(val: TNumericOptions);
    function GetNumericOptions: TNumericOptions;

    procedure SetComboBoxOptions(val: TComboBoxOptions);
    function GetComboBoxOptions: TComboBoxOptions;

    procedure SetAllowShow(val: boolean);

  protected
    function GetDisplayName: string; override;

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

  published
    property Grid: TNiceGrid read GetGrid;
    property Name: string read FName write SetName;
    property Title: string read FTitle write SetTitle;
    property Footer: string read FFooter write SetFooter;
    property Width: integer read FWidth write SetWidth;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property Color: TColor read FColor write SetColor default clWindow;
    property HorzAlign: THorzAlign read FHorzAlign write SetHorzAlign default haLeft;
    property VertAlign: TVertAlign read FVertAlign write SetVertAlign default vaTop;
    property Visible: boolean read FVisible write SetVisible default True;
    property Tag: integer read FTag write FTag default 0;
    property Tag2: integer read FTag2 write FTag2 default 0;
    property Hint: string read FHint write FHint;
    property Strings: TStrings read FStrings write SetStrings;
    property CanResize: boolean read FCanResize write FCanResize default True;
    property ReadOnly: boolean read FReadOnly write FReadOnly default False;

    property ControlType: TngControlTypes read GetControlType
      write SetControlType default ctEdit;

    property NumericOptions: TNumericOptions read GetNumericOptions
      write SetNumericOptions;

    // Combo box stuff
    property LookUpComboBoxOptions: TComboBoxOptions read GetComboBoxOptions
      write SetComboBoxOptions;
{    property Items              : TStrings read FItems write SetItems stored ShouldStoreComboItems;
    property AutoSuggest        : Boolean read FAutoSuggest write FAutoSuggest stored ShouldStoreComboItems;
    property ComboMaxWidth      : Boolean read FComboMaxWidth write SetComboMaxWidth stored ShouldStoreComboItems;
    property DropDownCount      : Integer read FDropDownCount write SetDropDownCount stored ShouldStoreComboItems;
    property DropDownList       : Boolean read FDropDownList write FDropDownList stored ShouldStoreComboItems;

  // Button stuff
    property ButtonStyle        : ThgButtonStyle read FButtonStyle write SetButtonStyle stored ShouldStoreButtonStuff;
    property ButtonPicture      : TPicture read FButtonPicture write SetButtonPicture stored ShouldStoreButtonPicture;
    property DrawButtonface     : Boolean read FDrawButtonFace write SetDrawButtonFace stored ShouldStoreButtonPicture;
    property ButtonVAlignment   : ThgVAlignment read FButtonVAlignment write SetButtonVAlignment stored ShouldStoreButtonPicture;

  // Formating}
    property FormatText: TngFormatTextType
      read FFormatText write SetFormatText default fttAsEntered;
    property Decimals: integer read FDecimals write SetDecimals default 2;
    property ThousandsSeparator: boolean read FThousands write SetThousands;
    property DateFormat: integer read FDateFormat write SetDateFormat;
    property TimeFormat: integer read FTimeFormat write SetTimeFormat;
    property MaxLength: integer read FMaxLenght write SetMaxLenght default 0;
    //}
    property ShowZero: boolean read FShowZero write SetShowZero default False;
    property WordBreak: boolean read FWordBreak write SetWordBreak default False;
    property AllowShowHide: boolean read FAllowShow write SetAllowShow default True;
  end;


  TNiceColumns = class(TCollection)
  private
    FGrid: TNiceGrid;
    function GetItem(Index: integer): TNiceColumn;
    procedure SetItem(Index: integer; Value: TNiceColumn);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AGrid: TNiceGrid);
    property Grid: TNiceGrid read FGrid;
    property Items[Index: integer]: TNiceColumn read GetItem write SetItem; default;
    function Add: TNiceColumn;
    function AddItem(Item: TNiceColumn; Index: integer): TNiceColumn;
    function Insert(Index: integer): TNiceColumn;
  end;

  //-----------------------------------------------------------------------------
  TNiceRow = class(TCollectionItem)
  private
    FHeight: integer;
    //FColor    : TColor;
    FVisible: boolean;
    FCanResize: boolean;
    FNodeIndex: integer;
    FImageIndex: TImageIndex;
    FObject: TObject;

    FParent: TObject;
    FRows: TObjectList;

    function GetGrid: TNiceGrid;
    function GetExternalObject: TObject;
    function GetParent: TObject;
    function GetRows: TObjectList;

    procedure SetHeight(Value: integer);
    procedure SetVisible(Value: boolean);
    procedure SetNodeIndex(Value: integer);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetExternalObject(Value: TObject);
    procedure SetParent(Value: TObject);
    procedure SetRows(Value: TObjectList);

  protected

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function IsEmpty: boolean;

  published
    property Grid: TNiceGrid read GetGrid;
    property Height: integer read FHeight write SetHeight;
    //property Color: TColor read FColor write SetColor default clWindow;
    property CanResize: boolean read FCanResize write FCanResize default True;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property NodeIndex: integer read FNodeIndex write SetNodeIndex default 0;
    property ExternalObject: TObject read GetExternalObject write SetExternalObject default nil;
    property Visible: boolean read FVisible write SetVisible default True;

    property Parent: TObject read GetParent write SetParent;
    property Rows: TObjectList read GetRows write SetRows;
  end;

  TNiceRows = class(TCollection)
  private
    FGrid: TNiceGrid;
    function GetItem(Index: integer): TNiceRow;
    procedure SetItem(Index: integer; Value: TNiceRow);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AGrid: TNiceGrid);
    property Grid: TNiceGrid read FGrid;
    property Items[Index: integer]: TNiceRow read GetItem write SetItem; default;
    function Add: TNiceRow;
    function AddItem(Item: TNiceRow; Index: integer): TNiceRow;
    function Insert(Index: integer): TNiceRow;
  end;

  //-----------------------------------------------------------------------------

  TngEditTypes = (eEdit, eMemo, eComboBox, eDate, eCheckBox);
  TDropUp = procedure(Sender: TObject; Data: TStringList) of object;
  TBeforeShowEdit = procedure(Sender: TObject; ARec: TRect; var aCanShow: boolean) of object;

  TNiceInplace = class(TNiceMemo)
  private
    FString: string;
    FGrid: TNiceGrid;
    FAlignment: THorzAlign;
    CellX, CellY: integer;
    FColumns: TDBColumnCollection;
    FChkForm: TDropForm;
    FChkFormWidth: integer;
    FChkFormHeight: integer;
    FShowGridTitleRow: boolean;
    FDataSourceLink: TDataSource;

    procedure SetAlignment(Value: THorzAlign);
    procedure ShowPopup(Focus: boolean);
    procedure HidePopup;
    function CheckDataSet: boolean;
    procedure WMKillFocus(var Msg: TLMKillFocus); message LM_KILLFOCUS;
    procedure ButtonClick(Sender: TObject);
    procedure GridResize(Sender: TObject);
    procedure GridHide(Sender: TObject);
    procedure GridClose(Sender: TObject; var Action: TCloseAction);
    procedure CalendarPopupReturnDate(Sender: TObject; const ADate: TDateTime);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Change; override;
    procedure SetHeight;
    procedure KeyDown(var Key: word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
  public
    constructor Create(Grid: TNiceGrid); reintroduce;
    procedure ShowEdit(X, Y: integer);
    procedure HideEdit(SaveChanges: boolean = True);
    property ShowGridTitleRow: boolean read FShowGridTitleRow write FShowGridTitleRow;
    property DataSource: TDataSource read FDataSourceLink write FDataSourceLink;
  end;

  TMergeCell = class(TObject)
  public
    Caption: string;
    Rc: TRect;
    Color: TColor;
    Font: TFont;
    HorzAlign: THorzAlign;
    VertAlign: TVertAlign;
    constructor Create;
    destructor Destroy; override;
  end;

  TOnDrawCellEvent = procedure(Sender: TObject; ACanvas: TCanvas;
    ACol, ARow: integer; Rc: TRect; var Handled: boolean) of object;

  TAfterDrawTextCell = procedure(Sender: TObject; ACanvas: TCanvas;
    ACol, ARow: integer; Rc: TRect) of object;

  TBeforeDrawTextCell = procedure(Sender: TObject; ACanvas: TCanvas;
    ACol, ARow: integer; Rc: TRect) of object;

  TOnDrawHeaderEvent = procedure(Sender: TObject; ACanvas: TCanvas;
    Rc: TRect; Str: string; var Handled: boolean) of object;

  TOnFilterChar = procedure(Sender: TObject; ACol: integer; ARow: integer;
    Chr: char; var Allowed: boolean) of object;

  TOnHeaderClick = procedure(Sender: TObject; ACol: integer;
    Button: TMouseButton; Shift: TShiftState) of object;

  TOnGutterClick = procedure(Sender: TObject; ARow: integer;
    Button: TMouseButton; Shift: TShiftState) of object;

  TOnCellAssignment = procedure(Sender: TObject; ACol, ARow: integer;
    var Str: string) of object;

  TOnCellChange = procedure(Sender: TObject; ACol, ARow: integer;
    var Str: string) of object;

  TOnCellChanging = procedure(Sender: TObject; ACol, ARow: integer;
    var CanChange: boolean) of object;

  TOnRowEvent = procedure(Sender: TObject; ARow: integer) of object;

  TOnColRowChanged = procedure(Sender: TObject; ACol, ARow: integer) of object;
  TOnCellExit = procedure(Sender: TObject; ACol, ARow: integer) of object;

  TNiceGridSync = class;

  TNiceGrid = class(TCustomControl)
  private
    ForcedColumn: integer;
    FixedWidth, FixedHeight: integer;
    BodyWidth, BodyHeight: integer;
    AllWidth, AllHeight: integer;
    FooterTop: integer;
    CellBox: TRect;

    FHorzOffset: integer;
    FVertOffset: integer;
    FMaxHScroll: integer;
    FMaxVScroll: integer;
    FSmallChange: integer;
    FLargeChange: integer;

    FAutoAddRow: boolean;
    FDefRowHeight: integer;
    FDefColWidth: integer;
    FFlat: boolean;

    FHeaderLine: integer;
    FHeaderInfos: TList;
    FUpdating: boolean;
    FColor: TColor;
    FAlternateColor: TColor;
    FGridColor: TColor;
    FShowGrid: boolean;
    FHeaderColor: TColor;
    FHeaderLightColor: TColor;
    FHeaderDarkColor: TColor;
    FSelectionColor: TColor;
    FHeaderFont: TFont;
    FGutterFont: TFont;
    FMergeCellColor: TColor;
    FMergeCellFont: TFont;

    FGutterKind: TGutterKind;
    FGutterWidth: integer;

    FFitToWidth: boolean;
    FAutoColWidth: boolean;
    FReadOnly: boolean;
    FColumns: TNiceColumns;

    ValidationEnabled: boolean;


    //-------------------------------------------------------------------------
    FEdit: TNiceInplace;
    FEditor: TCustomEdit;
    //-------------------------------------------------------------------------

    FCol, FRow: integer;
    FCol_Old, FRow_Old: integer;
    FCol2, FRow2: integer; // Selection
    FSelectArea: TRect;

    SmallBox: TRect;
    SmallBoxArea: TRect;
    SmallBoxPos: byte;

    BuffString: string;
    IsEditing: boolean;
    SizingCol: integer;
    SizingColX: integer;
    LastHover: integer;
    Sync: TNiceGridSync;
    Mergeds: TList;

    FOnDrawCell: TOnDrawCellEvent;
    FAfterDrawTextCell: TAfterDrawTextCell;
    FBeforeDrawTextCell: TBeforeDrawTextCell;
    FOnDrawHeader: TOnDrawHeaderEvent;
    FOnDrawGutter: TOnDrawHeaderEvent;
    FOnDrawFooter: TOnDrawHeaderEvent;
    FOnFilterChar: TOnFilterChar;
    FOnHeaderClick: TOnHeaderClick;
    FOnGutterClick: TOnGutterClick;
    FOnCellChange: TOnCellChange;
    FOnCellChanging: TOnCellChanging;
    FOnColRowChanged: TOnColRowChanged;
    FOnInsertRow: TOnRowEvent;
    FOnDeleteRow: TOnRowEvent;
    FOnCellAssignment: TOnCellAssignment;
    FOnCellExit: TOnCellExit;

    // Events of InplaceEdit:
    FBeforeShowEdit: TBeforeShowEdit;
    FOnDropDown: TNotifyEvent;
    FOnDropUp: TDropUp;

    FGutterStrings: TStrings;
    FShowFooter: boolean;
    FFooterFont: TFont;
    FEnabled: boolean;
    //FAutoFillRight: Boolean;
    //FAutoFillDown: Boolean;
    FRows: TNiceRows;
    FImages: TImageList;
    FZone: TGridHittest;

    // Menu:
    FPopupMenu: TPopupMenu;
    FPopupShow: boolean;

    FGridStyle: TGridStyle;

    procedure WMUnknown(var Msg: TLMessage); message LM_USER + $B902;
    procedure WMVScroll(var Msg: TLMVScroll); message LM_VSCROLL;
    procedure WMHScroll(var Msg: TLMHScroll); message LM_HSCROLL;
    procedure WMSize(var Msg: TLMessage); message LM_SIZE;
    procedure WMEraseBkgnd(var Msg: TLMEraseBkGnd); message LM_ERASEBKGND;
    procedure WMSetFocus(var Msg: TLMSetFocus); message LM_SETFOCUS;
    procedure WMKillFocus(var Msg: TLMKillFocus); message LM_KILLFOCUS;

    procedure CMWantSpecialKey(var Message: TLMKey); message CM_WANTSPECIALKEY;
    procedure CMFontChanged(var Msg: TLMessage); message CM_FONTCHANGED;

    function TotalWidth: integer;
    procedure ClearHeaderInfos;

    procedure ClearUnused;
    procedure RenderGutter;
    procedure RenderHeader;
    procedure DrawSelection;

    procedure SetHorzOffset(Value: integer);
    procedure SetVertOffset(Value: integer);
    function GetColCount: integer;
    function GetRowCount: integer;
    procedure SetColCount(Value: integer);
    procedure SetRowCount(Value: integer);
    procedure SetDefColWidth(Value: integer);
    procedure SetDefRowHeight(Value: integer);
    procedure SetFlat(Value: boolean);
    procedure SetColor(Value: TColor);
    procedure SetAlternateColor(Value: TColor);
    procedure SetGridColor(Value: TColor);
    procedure SetShowGrid(Value: boolean);
    procedure SetHeaderLine(Value: integer);
    procedure SetHeaderColor(Value: TColor);
    procedure SetHeaderLightColor(Value: TColor);
    procedure SetHeaderDarkColor(Value: TColor);
    procedure SetHeaderFont(Value: TFont);
    procedure SetSelectionColor(Value: TColor);
    procedure SetFitToWidth(Value: boolean);
    procedure SetAutoColWidth(Value: boolean);
    procedure SetReadOnly(Value: boolean);
    procedure InternalSetCell(X, Y: integer; Value: string; FireOnChange: boolean);
    procedure SetCell(X, Y: integer; Value: string);
    procedure SetCellT(stVal: string; Y: integer; Value: string);
    function GetColWidths(Index: integer): integer;
    procedure SetColWidths(Index: integer; Value: integer);
    procedure SetColumns(Value: TNiceColumns);
    procedure SetCol(Value: integer);
    procedure SetRow(Value: integer);
    procedure AdjustSelection(Value: TRect; Force: boolean);
    procedure SetSelectArea(Value: TRect);
    procedure SetGutterKind(Value: TGutterKind);
    procedure SetGutterWidth(Value: integer);
    procedure SetGutterFont(Value: TFont);
    procedure HeaderFontChange(Sender: TObject);
    procedure GutterFontChange(Sender: TObject);

    function CreateColumn: TNiceColumn;
    procedure UpdateColumn(Index: integer);
    procedure UpdateColumns;
    procedure UpdateHeader;

    function GetCellRect(x, y: integer): TRect;
    function CellRectToClient(R: TRect): TRect;
    function GetCellAtPos(X, Y: integer): TPoint;
    function GetColFromX(X: integer): integer;
    function GetRowFromY(Y: integer): integer;
    function GetColCoord(I: integer): integer;
    function GetRowCoord(I: integer): integer;
    function GetCell(X, Y: integer): string;
    function GetCellT(stVal: string; Y: integer): string;
    function SafeGetCell(X, Y: integer): string;
    function GetCellColor(X, Y: integer): TColor;
    function CalcRowHeight(X, Y: integer): integer;
    procedure DrawCell(X, Y: integer);
    //    function FastDrawCell(X, Y: Integer; IsEditing: Boolean): TPoint;
    procedure NormalizeVertOffset;
    procedure InvalidateCells;
    procedure InvalidateRightWard(Left: integer);
    procedure InvalidateDownWard(Top: integer);
    procedure InvalidateHeader;
    procedure InvalidateGutter;

    function GetFirstVisibleCol: integer;
    function GetLastVisibleCol: integer;
    function GetNextVisibleCol(Index: integer): integer;
    function GetPrevVisibleCol(Index: integer): integer;
    function GetFirstVisibleRow: integer;
    function GetLastVisibleRow: integer;
    function GetNextVisibleRow(Index: integer): integer;
    function GetPrevVisibleRow(Index: integer): integer;

    procedure ColRowChanged;
    procedure SetGutterStrings(const Value: TStrings);
    function GetObject(X, Y: integer): TObject;
    procedure SetObject(X, Y: integer; const Value: TObject);
    procedure BuildMergeData;
    procedure DrawMergedCell(Index: integer);
    procedure SetShowFooter(const Value: boolean);
    procedure RenderFooter;
    procedure SetFooterFont(const Value: TFont);
    procedure FooterFontChange(Sender: TObject);
    procedure DrawFixCell(Rc: TRect; Str: string; AFont: TFont;
      AEvent: TOnDrawHeaderEvent);
    procedure SetEnabled(const Value: boolean); reintroduce;

    function GetRowHeight(Index: integer): integer;
    procedure SetRowHeight(Index: integer; Value: integer);
    function GetRows(Index: integer): TNiceRow;
    procedure SetRows(Index: integer; Value: integer);

    procedure SetPopupShow(val: boolean);
    procedure MenuClick(Sender: TObject);

    procedure SetGridStyle(Value: TGridStyle);

  protected
    function GetMergedCellsData: TList;
    function GetHeaderInfo: TList;
    procedure SetScrollBar(AKind, AMax, APos, AMask: integer); virtual;
    procedure ShowHideScrollBar(HorzVisible, VertVisible: boolean); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Recalculate; virtual;
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure KeyDown(var Key: word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    procedure UTF8KeyPress(var UTF8Key: TUTF8Char); override;

    function  DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure GridMouseWheel(shift: TShiftState; Delta: Integer);


  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear;
    property Cells[X, Y: integer]: string read GetCell write SetCell; default;
    property CellsT[Title: string; Y: integer]: string read GetCellT write SetCellT;
    property Objects[X, Y: integer]: TObject read GetObject write SetObject;
    property ColWidths[Index: integer]: integer read GetColWidths write SetColWidths;
    procedure EnsureVisible(X, Y: integer); overload;
    procedure CutToClipboard;
    procedure CopyToClipboard;
    procedure PasteFromClipboard;
    function GetHitTestInfo(X, Y: integer): TGridHitTest;
    function HeaderCellsCount: integer;
    function HeaderCells(I: integer): THeaderInfo;
    property Col: integer read FCol write SetCol;
    property Row: integer read FRow write SetRow;
    property SelectArea: TRect read FSelectArea write SetSelectArea;
    procedure DeleteRow(ARow: integer);
    procedure InsertRow(ARow: integer);
    function AddRow: integer;
    property HorzOffset: integer read FHorzOffset write SetHorzOffset;
    property VertOffset: integer read FVertOffset write SetVertOffset;
    function MergeCells(const X1, Y1, X2, Y2: integer; ACaption: string): TMergeCell;
    procedure ClearMergeCells;

    property RowHeight[Index: integer]: integer read GetRowHeight write SetColWidths;
    property Rows[Index: integer]: TNiceRow read GetRows;// write SetRows;
    property Edit: TNiceInplace read FEdit write FEdit;
    procedure MouseToCell(X, Y: integer; var ACol, ARow: longint);
    function RowIsEmpty(ARow: integer): boolean;

    property Canvas;

  published
    property Enabled: boolean read FEnabled write SetEnabled default True;
    property ColCount: integer read GetColCount write SetColCount;
    property RowCount: integer read GetRowCount write SetRowCount default 5;
    property AutoAddRow: boolean read FAutoAddRow write FAutoAddRow default False;
    property DefRowHeight: integer read FDefRowHeight write SetDefRowHeight default 18;
    property DefColWidth: integer read FDefColWidth write SetDefColWidth default 80;
    property Flat: boolean read FFlat write SetFlat default True;
    property Color: TColor read FColor write SetColor default clWindow;
    property AlternateColor: TColor
      read FAlternateColor write SetAlternateColor default clWindow;
    property GridColor: TColor read FGridColor write SetGridColor default clBtnFace;
    property ShowGrid: boolean read FShowGrid write SetShowGrid default True;
    property HeaderLine: integer read FHeaderLine write SetHeaderLine default 1;
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor default
      clBtnFace;
    property HeaderLightColor: TColor read FHeaderLightColor
      write SetHeaderLightColor default clBtnHighlight;
    property HeaderDarkColor: TColor read FHeaderDarkColor
      write SetHeaderDarkColor default clBtnShadow;
    property HeaderFont: TFont read FHeaderFont write SetHeaderFont;
    property FooterFont: TFont read FFooterFont write SetFooterFont;

    property MergeCellColor: TColor read FMergeCellColor write FMergeCellColor;
    property MergeFont: TFont read FMergeCellFont write FMergeCellFont;

    property SelectionColor: TColor
      read FSelectionColor write SetSelectionColor default $00CAFFFF;
    property FitToWidth: boolean read FFitToWidth write SetFitToWidth default False;
    property AutoColWidth: boolean
      read FAutoColWidth write SetAutoColWidth default False;
    property ReadOnly: boolean read FReadOnly write SetReadOnly default False;
    property Columns: TNiceColumns read FColumns write SetColumns;
    property GutterKind: TGutterKind
      read FGutterKind write SetGutterKind default gkBlank;
    property GutterWidth: integer read FGutterWidth write SetGutterWidth default 20;
    property GutterFont: TFont read FGutterFont write SetGutterFont;
    property GutterStrings: TStrings read FGutterStrings write SetGutterStrings;
    property ShowFooter: boolean read FShowFooter write SetShowFooter;
    property OnDrawCell: TOnDrawCellEvent read FOnDrawCell write FOnDrawCell;
    property AfterDrawTextCell: TAfterDrawTextCell
      read FAfterDrawTextCell write FAfterDrawTextCell;
    property BeforeDrawTextCell: TBeforeDrawTextCell
      read FBeforeDrawTextCell write FBeforeDrawTextCell;
    property OnDrawHeader: TOnDrawHeaderEvent read FOnDrawHeader write FOnDrawHeader;
    property OnDrawGutter: TOnDrawHeaderEvent read FOnDrawGutter write FOnDrawGutter;
    property OnDrawFooter: TOnDrawHeaderEvent read FOnDrawFooter write FOnDrawFooter;
    property OnFilterChar: TOnFilterChar read FOnFilterChar write FOnFilterChar;
    property OnHeaderClick: TOnHeaderClick read FOnHeaderClick write FOnHeaderClick;
    property OnGutterClick: TOnGutterClick read FOnGutterClick write FOnGutterClick;
    property OnCellChange: TOnCellChange read FOnCellChange write FOnCellChange;
    property OnCellChanging: TOnCellChanging read FOnCellChanging write FOnCellChanging;
    property OnColRowChanged: TOnColRowChanged
      read FOnColRowChanged write FOnColRowChanged;
    property OnCellExit: TOnCellExit read FOnCellExit write FOnCellExit;
    property OnInsertRow: TOnRowEvent read FOnInsertRow write FOnInsertRow;
    property OnDeleteRow: TOnRowEvent read FOnDeleteRow write FOnDeleteRow;
    property OnCellAssignment: TOnCellAssignment
      read FOnCellAssignment write FOnCellAssignment;

    property OnBeforeShowEdit: TBeforeShowEdit
      read FBeforeShowEdit write FBeforeShowEdit;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnDropUp: TDropUp read FOnDropUp write FOnDropUP;

    property Font;
    property Anchors;
    property Align;
    //property BevelKind;
    property BorderStyle default bsSingle;
    //property BevelOuter default bvNone;
    //property BevelInner;

    property PopupMenu;
    property TabOrder;
    property TabStop default True;
    property Tag;
    property DoubleBuffered;

    property DragMode;
    property DragKind;
    property DragCursor;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyPress;
    property OnKeyDown;
    property OnKeyUp;

    property OnDragDrop;
    property OnDockDrop;
    property OnDockOver;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnStartDock;
    property OnStartDrag;

    //property OnEnter;
    //property OnExit;

    property Images: TImageList read FImages write FImages;
    property ShowDropDown: boolean read FPopupShow write SetPopupShow;
    property Style: TGridStyle read FGridStyle write SetGridStyle;
  end;

  TNiceGridSync = class(TNiceGrid)
  private
    FGrid: TNiceGrid;
    procedure SetGrid(const Value: TNiceGrid);
    procedure SyncDeleteRow(Sender: TObject; ARow: integer);
    procedure SyncInsertRow(Sender: TObject; ARow: integer);
    procedure SyncColRow(Sender: TObject; ACol, ARow: integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetScrollBar(AKind, AMax, APos, AMask: integer); override;
    procedure ShowHideScrollBar(HorzVisible, VertVisible: boolean); override;
    property OnDeleteRow;
    property OnInsertRow;
    property OnColRowChanged;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Grid: TNiceGrid read FGrid write SetGrid;
  end;


function DrawString(Canvas: TCanvas; Str: string; Rc: TRect;
  HorzAlign: THorzAlign; VertAlign: TVertAlign; IsEditing: boolean): TPoint;

procedure DrawStringMulti(Canvas: TCanvas; Str: string; Rc: TRect;
  HorzAlign: THorzAlign; VertAlign: TVertAlign);


implementation


{$R NiceCursors.res}

uses
  Math;

const
  crPlus = 101;
  crSmallCross = 102;
  crRight = 103;
  crDown = 104;
  crLeftTop = 105;

  CursorArray: array [TGridHitTest] of TCursor =
    //(gtNone, gtLeftTop, gtLeft, gtTop, gtCell, gtColSizing, gtSmallBox);
    (crDefault, crLeftTop, crRight, crDown, crPlus, crHSplit, crSmallCross);

  MergeID = -2;


{ TNiceGrid }

constructor TNiceGrid.Create(AOwner: TComponent);
begin
  FColumns := TNiceColumns.Create(Self);
  FRows := TNiceRows.Create(Self);
  FGutterStrings := TStringList.Create;
  Mergeds := TList.Create;
  inherited Create(AOwner);

  Width := 200;
  Height := 200;
  BorderStyle := bsSingle;
  TabStop := True;
  TabOrder := 0;
  ParentColor := False;
  ParentFont := False;

  FFlat := True;
  FEnabled := True;
  FColor := clWindow;
  FAlternateColor := clWindow;
  FGridColor := clBtnFace;
  FShowGrid := True;
  FHeaderColor := clBtnface;
  FHeaderLightColor := clBtnHighlight;
  FHeaderDarkColor := clBtnShadow;
  FHeaderFont := TFont.Create;
  FHeaderFont.OnChange := HeaderFontChange;
  FSelectionColor := $00CAFFFF;

  FFooterFont := TFont.Create;
  FFooterFont.OnChange := FooterFontChange;

  FDefRowHeight := 18;
  FDefColWidth := 80;
  FAutoAddRow := False;
  FGutterKind := gkBlank;
  FGutterWidth := 20;
  FGutterFont := TFont.Create;
  FGutterFont.OnChange := GutterFontChange;

  FMergeCellFont := TFont.Create;
  self.FMergeCellColor := clWindow;

  FHorzOffset := 0;
  FVertOffset := 0;
  FMaxHScroll := 0;
  FMaxVScroll := 0;
  FSmallChange := FDefRowHeight;
  FLargeChange := FDefRowHeight * 5;
  ForcedColumn := -1;
  AllWidth := 200;
  AllHeight := 200;

  FHeaderLine := 1;
  FHeaderInfos := TList.Create;

  ValidationEnabled := True;
  CellBox := Rect(0, 0, 0, 0);
  FCol := 0;
  FRow := 0;
  FCol_Old := 0;
  FRow_Old := 0;
  FCol2 := 0;
  FRow2 := 0;
  FSelectArea := Rect(0, 0, 0, 0);
  IsEditing := False;
  BuffString := '';
  SmallBox := Rect(-1, -1, -1, -1);
  SmallBoxArea := Rect(-1, -1, -1, -1);
  SmallBoxPos := 0;
  SizingCol := -1;
  SizingColX := -1;

  Screen.Cursors[crPlus] := LoadCursor(hinstance, 'CR_PLUS');
  Screen.Cursors[crSmallCross] := LoadCursor(hInstance, 'CR_CROSS');
  Screen.Cursors[crRight] := LoadCursor(hinstance, 'CR_RIGHT');
  Screen.Cursors[crDown] := LoadCursor(hinstance, 'CR_DOWN');
  Screen.Cursors[crLeftTop] := LoadCursor(hinstance, 'CR_LEFTTOP');
  Cursor := crPlus;
  FZone := gtNone;

  FGridStyle := gsStandard;

  FEdit := TNiceInplace.Create(Self);
end;

destructor TNiceGrid.Destroy;
begin
  ClearMergeCells;
  Mergeds.Free;
  FGutterStrings.Free;
  FEdit.Free;
  FColumns.Free;
  FRows.Free;
  ClearHeaderInfos;
  FHeaderInfos.Free;
  FHeaderFont.Free;
  FFooterFont.Free;
  FGutterFont.Free;
  inherited Destroy;
end;

procedure TNiceGrid.CreateParams(var Params: TCreateParams);
const
  ClassStylesOff = CS_VREDRAW or CS_HREDRAW;
begin
  inherited CreateParams(Params);
  //Params.Style := Params.Style or WS_HSCROLL or WS_VSCROLL;
  with Params do begin
    WindowClass.Style := WindowClass.Style and DWORD(not ClassStylesOff);
    Style := Style or WS_VSCROLL or WS_HSCROLL or WS_CLIPCHILDREN;
  end;

end;

procedure TNiceGrid.CreateWnd;
begin
  inherited CreateWnd;
  ShowHideScrollBar(False, False);
  Recalculate;
end;

procedure TNiceGrid.SetScrollBar(AKind, AMax, APos, AMask: integer);
var
  Info: TScrollInfo;
begin
  FillChar(Info, SizeOf(TScrollInfo), 0);
  Info.cbSize := SizeOf(TScrollInfo);
  Info.nMin := 0;
  Info.nMax := AMax;
  Info.nPos := APos;
  Info.fMask := AMask;
  SetScrollInfo(Handle, AKind, Info, True);
  if (AKind = SB_VERT) and Assigned(Sync) then
  begin
    if ((AMask and SIF_RANGE) <> 0) then
      Sync.FMaxVScroll := AMax;
    if ((AMask and SIF_POS) <> 0) then
      Sync.VertOffset := APos;
  end;
end;

procedure TNiceGrid.ShowHideScrollBar(HorzVisible, VertVisible: boolean);
begin
  ShowScrollBar(Handle, SB_HORZ, HorzVisible);
  ShowScrollBar(Handle, SB_VERT, VertVisible);
end;

procedure TNiceGrid.WMHScroll(var Msg: TLMVScroll);
var
  Old: integer;
begin
  Old := FHorzOffset;
  case Msg.ScrollCode of
    SB_LINELEFT:
      FHorzOffset := FHorzOffset - FSmallChange;
    SB_LINERIGHT:
      FHorzOffset := FHorzOffset + FSmallChange;
    SB_PAGELEFT:
      FHorzOffset := FHorzOffset - FLargeChange;
    SB_PAGERIGHT:
      FHorzOffset := FHorzOffset + FLargeChange;
    SB_THUMBTRACK:
      FHorzOffset := Msg.Pos;
    SB_THUMBPOSITION:
      FHorzOffset := Msg.Pos;
  end;
  FHorzOffset := Max(0, Min(FMaxHScroll, FHorzOffset));
  if (FHorzOffset <> Old) then
  begin
    SetScrollBar(SB_HORZ, 0, FHorzOffset, SIF_POS);
    InvalidateRightWard(FixedWidth);
  end;
end;

procedure TNiceGrid.WMVScroll(var Msg: TLMHScroll);
var
  Old: integer;
begin
  Old := FVertOffset;
  case Msg.ScrollCode of
    SB_LINEUP:
      FVertOffset := FVertOffset - FSmallChange;
    SB_LINEDOWN:
      FVertOffset := FVertOffset + FSmallChange;
    SB_PAGEUP:
      FVertOffset := FVertOffset - FLargeChange;
    SB_PAGEDOWN:
      FVertOffset := FVertOffset + FLargeChange;
    SB_THUMBTRACK:
      FVertOffset := Msg.Pos;
    SB_THUMBPOSITION:
      FVertOffset := Msg.Pos;
  end;
  FVertOffset := Max(0, Min(FMaxVScroll, FVertOffset));
  NormalizeVertOffset;
  if (FVertOffset <> Old) then
  begin
    SetScrollBar(SB_VERT, 0, FVertOffset, SIF_POS);
    InvalidateDownWard(FixedHeight);
  end;
end;

procedure TNiceGrid.SetColCount(Value: integer);
begin
  if (ColCount <> Value) then
  begin
    FColumns.BeginUpdate;
    while (ColCount > Value) do
      FColumns.Delete(FColumns.Count - 1);
    while (ColCount < Value) do
      FColumns.Add;
    FHorzOffset := 0;
    FVertOffset := 0;
    FCol := Max(0, Min(FCol, ColCount - 1));
    FRow := Max(0, Min(FRow, RowCount - 1));
    if (RowCount = 0) or (ColCount = 0) then
    begin
      FCol := -1;
      FRow := -1;
    end;
    FSelectArea := Rect(FCol, FRow, FCol, FRow);
    FColumns.EndUpdate;
    ColRowChanged;
  end;
end;

procedure TNiceGrid.SetRowCount(Value: integer);
begin
  if (RowCount <> Value) then
  begin
    FRows.BeginUpdate;
    while RowCount > Value do
      FRows.Delete(FRows.Count - 1);
    while RowCount < Value do
      FRows.Add;

    FCol := Max(0, Min(FCol, ColCount - 1));
    FRow := Max(0, Min(FRow, RowCount - 1));
    if (RowCount = 0) or (ColCount = 0) then
    begin
      FCol := -1;
      FRow := -1;
    end;
    FSelectArea := Rect(FCol, FRow, FCol, FRow);
    Recalculate;
    Invalidate;
    FRows.EndUpdate;
    ColRowChanged;
  end;
end;

procedure TNiceGrid.ClearHeaderInfos;
var
  x: integer;
  P: PHeaderInfo;
begin
  for x := 0 to FHeaderInfos.Count - 1 do
  begin
    P := PHeaderInfo(FHeaderInfos[x]);
    Dispose(P);
  end;
  FHeaderInfos.Clear;
end;

procedure TNiceGrid.Recalculate;
var
  x: integer;
  HVisible, VVisible: boolean;
  VisCount: integer;
  WidthAvail, HeightAvail: integer;
  v: integer;
  LastBodyWidth: integer;

  function GetColAutoWidth(i: integer): integer;
  var
    n: integer;
    t: TStrings;
  begin
    Result := 0;
    t := Columns[i].FStrings;
    for n := 0 to t.Count - 1 do
      Result := Max(Result, Canvas.TextWidth(t[n]) + 7);
    Result := Max(Result, 20);
  end;

begin

  BuildMergeData;

  VisCount := 0;
  for x := 0 to FColumns.Count - 1 do
  begin
    if FColumns[x].FVisible then
      Inc(VisCount);
  end;

  if (VisCount = 0) then
  begin
    FixedHeight := 0;
    FixedWidth := 0;
    BodyWidth := 0;
    BodyHeight := 0;
    ShowHideScrollBar(False, False);
    Exit;
  end;

  if FAutoColWidth then
  begin
    Canvas.Font.Assign(Font);
    for x := 0 to FColumns.Count - 1 do
      FColumns[x].FWidth := Max(FDefColWidth, GetColAutoWidth(x));
  end;

  FixedWidth := 0;
  if (FGutterKind <> gkNone) then
    FixedWidth := FGutterWidth;

  FixedHeight := FHeaderLine * FDefRowHeight;
  BodyHeight := RowCount * FDefRowHeight;
  BodyHeight := 0;
  for x := 0 to FRows.Count - 1 do
  begin
    if FRows[x].FVisible then
      BodyHeight := BodyHeight + FRows[x].FHeight;
  end;

  WidthAvail := ClientWidth - FixedWidth;
  HeightAvail := ClientHeight - FixedHeight;
  if FShowFooter then
    HeightAvail := HeightAvail - FDefRowHeight;

  BodyWidth := 0;
  for x := 0 to FColumns.Count - 1 do
  begin
    if FColumns[x].FVisible then
      BodyWidth := BodyWidth + FColumns[x].FWidth;
  end;

  if FFitToWidth then
  begin
    if (BodyWidth < WidthAvail) then
    begin
      LastBodyWidth := BodyWidth;
      x := 0;
      while (BodyWidth < WidthAvail) do
      begin
        if (x > ColCount - 1) then
        begin
          if (BodyWidth = LastBodyWidth) then
            Break
          else
            x := 0;
        end;
        if FColumns[x].FVisible and FColumns[x].FCanResize then
        begin
          FColumns[x].FWidth := FColumns[x].FWidth + 1;
          Inc(BodyWidth);
        end;
        Inc(x);
      end;
    end;
    if (BodyWidth > WidthAvail) then
    begin
      LastBodyWidth := BodyWidth;
      x := 0;
      while (BodyWidth > WidthAvail) do
      begin
        if (x > ColCount - 1) then
        begin
          if (BodyWidth = LastBodyWidth) then
            Break
          else
            x := 0;
        end;
        if FColumns[x].FVisible and (x <> ForcedColumn) and FColumns[x].FCanResize then
        begin
          FColumns[x].FWidth := FColumns[x].FWidth - 1;
          Dec(BodyWidth);
        end;
        Inc(x);
      end;
    end;
    ForcedColumn := -1;
  end;

  if (BodyWidth < WidthAvail) then
    FHorzOffset := 0;

  if (BodyHeight < HeightAvail) then
    FVertOffset := 0;

  HVisible := BodyWidth > WidthAvail;
  VVisible := BodyHeight > HeightAvail;

  ShowHideScrollBar(HVisible, VVisible);

  FMaxHScroll := Max(0, BodyWidth - ClientWidth + FixedWidth);
  if FShowFooter then
    FMaxVScroll := Max(0, BodyHeight - ClientHeight + FixedHeight + FDefRowHeight)
  else
    FMaxVScroll := Max(0, BodyHeight - ClientHeight + FixedHeight);

  // Align to FDefRowHeight
  v := FMaxVScroll div FDefRowHeight;
  if (FMaxVScroll mod FDefRowHeight) > 0 then
    Inc(v);
  FMaxVScroll := v * FDefRowHeight;

  if FShowFooter then
  begin
    if VVisible then
      FooterTop := (((ClientHeight div FDefRowHeight) - 1) * FDefRowHeight) - 1
    else
      FooterTop := (FDefRowHeight * (FHeaderLine + RowCount)) - 1;
  end;

  FHorzOffset := Max(0, Min(FHorzOffset, FMaxHScroll));
  FVertOffset := Max(0, Min(FVertOffset, FMaxVScroll));

  SetScrollBar(SB_HORZ, FMaxHScroll, FHorzOffset, SIF_POS or SIF_RANGE);
  SetScrollBar(SB_VERT, FMaxVScroll, FVertOffset, SIF_POS or SIF_RANGE);

  AllWidth := Min(ClientWidth, BodyWidth + FixedWidth);
  if FShowFooter then
  begin
    AllHeight := Min(ClientHeight, BodyHeight + FixedHeight + FDefRowHeight);
    CellBox := Rect(FixedWidth, FixedHeight, ClientWidth, FooterTop);
  end
  else
  begin
    AllHeight := Min(ClientHeight, BodyHeight + FixedHeight);
    CellBox := Rect(FixedWidth, FixedHeight, ClientWidth, ClientHeight);
  end;
end;

function DrawString(Canvas: TCanvas; Str: string; Rc: TRect;
  HorzAlign: THorzAlign; VertAlign: TVertAlign; IsEditing: boolean): TPoint;
var
  w, h, x, y: integer;
  rw: integer;
begin
  w := Canvas.TextWidth(Str);
  h := Canvas.TextHeight('gM');
  x := 0;
  y := 0;
  rw := Rc.Right - rc.Left;
  case HorzAlign of
    haLeft:
    begin
      x := Rc.Left;
      if (w > rw) and IsEditing then
        x := Rc.Left - (w - rw);
    end;
    haCenter: x := Rc.Left + ((rw - w) div 2);
    haRight: x := Rc.Right - w;
  end;
  case VertAlign of
    vaTop: y := Rc.Top;
    vaCenter: y := Rc.Top + (((Rc.Bottom - Rc.Top) - h) div 2);
    vaBottom: y := Rc.Bottom - h;
  end;
  Canvas.TextRect(Rc, x, y, Str);
  // Return next cursor position
  Result := Point(Min(x + w + 1, Rc.Right), Rc.Top - 1);
end;

procedure DrawStringMulti(Canvas: TCanvas; Str: string; Rc: TRect;
  HorzAlign: THorzAlign; VertAlign: TVertAlign);
var
  w, h, x, y: integer;
  t: TStringList;
  i: integer;
  dh: integer;

begin
  if Pos(';', Str) = 0 then
  begin
    DrawString(Canvas, Str, Rc, HorzAlign, VertAlign, False);
    Exit;
  end;

  t := TStringList.Create;
  t.Text := StringReplace(Str, ';', #13, [rfReplaceAll]);
  h := Canvas.TextHeight('gM');
  dh := Rc.Top + (((Rc.Bottom - Rc.Top) - (h * t.Count)) div 2);
  for i := 0 to t.Count - 1 do
  begin
    w := Canvas.TextWidth(t[i]);
    x := 0;
    y := 0;
    case HorzAlign of
      haLeft: x := Rc.Left;
      haCenter: x := Rc.Left + (((Rc.Right - Rc.Left) - w) div 2);
      haRight: x := Rc.Right - w;
    end;
    case VertAlign of
      vaTop: y := Rc.Top + (i * h);
      vaCenter: y := dh + (i * h);
      vaBottom: y := Rc.Bottom - (h * (t.Count - i));
    end;
    Canvas.TextRect(Rc, x, y, t[i]);
  end;
  t.Free;
end;

function TNiceGrid.GetCellColor(X, Y: integer): TColor;
var
  cl: TColor;
  R: TRect;
begin
  cl := FColumns[x].Color;
  if Odd(Y) then
  begin
    if (cl = FColor) then
      cl := FAlternateColor;
  end;
  if FEnabled then
  begin
    with FSelectArea do
      R := Rect(Left, Top, Right + 1, Bottom + 1);
    if PtInRect(R, Point(X, Y)) then
    begin
      if not ((X = FCol) and (y = FRow)) then
        cl := FSelectionColor;
    end;
  end;
  Result := cl;
end;

procedure TNiceGrid.DrawFixCell(Rc: TRect; Str: string; AFont: TFont;
  AEvent: TOnDrawHeaderEvent);

  procedure DrawContent(re: TRect);
  var
    mh, mv: integer;
  begin
    with Canvas do
    begin
      if (Rc.Top = -1) and (Rc.Left = -1) then
      begin
        if FPopupShow then
        begin
          Pen.Color := $8D665A;
          Brush.Color := Pen.Color;
          mh := Rc.Right div 2;
          mv := Rc.Bottom div 2;
          { triangle: }//FixedWidth, FixedHeight
          //Polygon([Point(mh - 4, mv - 2), Point(mh + 4, mv - 2), Point(mh, mv + 2)]);
          { modern: }
          Polygon([Point(mh - 4, mv - 1), Point(mh - 3, mv - 2), Point(mh, mv + 1),
            Point(mh + 3, mv - 2), Point(mh + 4, mv - 1), Point(mh, mv + 3)]);
        end;
      end
      else
        DrawStringMulti(Canvas, Str, Re, haCenter, vaCenter);
    end;
  end;

var
  Rt: TRect;
  Handled: boolean;
  Details: TThemedElementDetails;
begin
  Handled := False;
  with Canvas do
  begin

    case FGridStyle of
      gsNative:
      begin
        Details := ThemeServices.GetElementDetails(thHeaderItemNormal);
        ThemeSErvices.DrawElement(Canvas.Handle, Details, Rc, nil);
        Brush.Style := bsClear;
        Rt := Rect(Rc.Left + 2, Rc.Top + 2, Rc.Right - 3, Rc.Bottom - 3);
        DrawContent(Rt);
      end;

      gsStandard:
      begin
        // Clear area
        if FFlat then
          Pen.Color := FHeaderDarkColor
        else
          Pen.Color := clBlack;
        Brush.Style := bsSolid;
        Brush.Color := FHeaderColor;
        Font.Assign(AFont);
        if not FEnabled then
          Font.Color := FHeaderDarkColor;
        if Assigned(AEvent) then
          AEvent(Self, Canvas, Rc, Str, Handled);
        if Handled then
          Exit;
        Rectangle(Rc);
        // Draw text immediately
        Brush.Style := bsClear;
        Rt := Rect(Rc.Left + 2, Rc.Top + 2, Rc.Right - 3, Rc.Bottom - 3);
        DrawContent(Rt);
        // cosmetics
        Pen.Color := FHeaderLightColor;
        MoveTo(Rc.Left + 1, Rc.Bottom - 2);
        LineTo(Rc.Left + 1, Rc.Top + 1);
        LineTo(Rc.Right - 1, Rc.Top + 1);
        if not FFlat then
        begin
          Pen.Color := FHeaderDarkColor;
          MoveTo(Rc.Right - 2, Rc.Top + 1);
          LineTo(Rc.Right - 2, Rc.Bottom - 2);
          LineTo(Rc.Left, Rc.Bottom - 2);
        end;
      end;
    end;
  end;
end;

procedure TNiceGrid.RenderGutter;
const
  ArrowWidth = 8;
var
  x, top: integer;
  R, Dummy: TRect;
  Str: string;
  l, t, m: integer;
  GutterBox: TRect;
begin
  if (FGutterKind = gkNone) then Exit;

  CopyRect(GutterBox, CellBox);
  GutterBox.Left := 0;
  top := 0;
  for x := 0 to RowCount - 1 do
  begin
    if not Rows[x].Visible then
      continue;

    R := Rect(-1, top - 1, FGutterWidth, top + Rows[x].Height);
    top := top + Rows[x].Height;

    OffsetRect(R, 0, -FVertOffset + FixedHeight);
    if IntersectRect(Dummy, R, GutterBox) then
    begin
      case FGutterKind of
        gkBlank, gkPointer:
          Str := '';
        gkNumber:
          Str := IntToStr(x + 1);
        gkString:
          if (x > FGutterStrings.Count - 1) then
            Str := ''
          else
            Str := FGutterStrings[x];
      end;

      DrawFixCell(R, Str, FGutterFont, FOnDrawGutter);

      // Draw pointer triangle
      if (FGutterKind = gkpointer) and (x = FRow) then
      begin
        with Canvas do
        begin
          Pen.Color := $8D665A;
          Brush.Color := Pen.Color;
          m := R.Top + (Rows[x].FHeight div 2);
          l := (FGutterWidth) - 4;
          Polygon([Point(l - 6, m + 4), Point(l - 6, m - 4), Point(l, m)]);
        end;
      end;
    end;
  end;
end;

procedure TNicegrid.RenderHeader;
var
  x: integer;
  R, Dummy: TRect;
  P: PHeaderInfo;
begin
  Canvas.Font.Assign(FHeaderFont);
  for x := 0 to FHeaderInfos.Count - 1 do
  begin
    P := PHeaderInfo(FHeaderInfos[x]);
    R := Rect(GetColCoord(P^.Rc.Left) - 1,
      (FDefRowHeight * P^.Rc.Top) - 1, GetColCoord(P^.Rc.Right + 1),
      FDefRowHeight * (P^.Rc.Bottom + 1));
    OffsetRect(R, -FHorzOffset + FixedWidth, 0);
    if IntersectRect(Dummy, R, ClientRect) then
      DrawFixCell(R, P^.Str, FHeaderFont, FOnDrawHeader);
  end;
  // Draw cell TopLeft
  R := Rect(-1, -1, FixedWidth, FixedHeight);
  DrawFixCell(R, '', FHeaderFont, FOnDrawHeader);
end;

procedure TNiceGrid.RenderFooter;
var
  x: integer;
  R, Dummy: TRect;
  FooterBottom: integer;
  Right: integer;
begin
  Canvas.Font.Assign(FFooterFont);
  FooterBottom := FooterTop + FDefRowHeight + 1;
  for x := 0 to FColumns.Count - 1 do
  begin
    R := Rect(GetColCoord(x) - 1, FooterTop, GetColCoord(x + 1), FooterBottom);
    OffsetRect(R, -FHorzOffset + FixedWidth, 0);
    if IntersectRect(Dummy, R, ClientRect) then
      DrawFixCell(R, FColumns[x].FFooter, FFooterFont, FOnDrawFooter);
  end;
  R := Rect(-1, FooterTop, FixedWidth, FooterBottom);
  DrawFixCell(R, '', FFooterFont, FOnDrawFooter);
  Right := Min(AllWidth, ClientWidth);
  R := Rect(-1, FooterBottom - 1, Right, ClientHeight);
  DrawFixCell(R, '', FFooterFont, FOnDrawFooter);
end;

// Calcular el alto de una fila
function TNiceGrid.CalcRowHeight(X: integer; Y: integer): integer;
var
  tmp, h, ts: integer;
  uFrmt: Uint;
  Rc: TRect;
begin
  if Cells[X, Y] = '' then
    exit;

  if FColumns[X].WordBreak then
  begin
    Rc := Rect(0, 0, FColumns[X].Width - 10, 18);
    case FColumns[X].HorzAlign of
      haLeft: uFrmt := DT_LEFT;
      haCenter: uFrmt := DT_CENTER;
      haRight: uFrmt := DT_RIGHT;
    end;
    //uFrmt := uFrmt or DT_WORDBREAK or DT_NOPREFIX or DT_CALCRECT;
    uFrmt := DT_WORDBREAK or DT_CALCRECT;
    h := DrawText(canvas.handle, PChar(Cells[X, Y]), -1 {length(Cells[X, Y])},
      Rc, uFrmt);
    if h < FDefRowHeight then
      Result := FDefRowHeight
    else
      Result := h + 2;
  end
  else
    Result := FDefRowHeight;
end;

procedure TNiceGrid.DrawCell(X, Y: integer);
const
  CHECKState: array[boolean] of integer = (DFCS_BUTTONCHECK,
    DFCS_BUTTONCHECK or DFCS_CHECKED);
  RADIOState: array[boolean] of integer = (DFCS_BUTTONRADIO,
    DFCS_BUTTONRADIO or DFCS_CHECKED);
  STR_BOOLFRMT = (DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  arrtb: array[TCheckboxState] of TThemedButton =
    (tbCheckBoxUncheckedNormal, tbCheckBoxCheckedNormal, tbCheckBoxMixedNormal);
var
  Rc, Dummy: TRect;
  Column: TNiceColumn;
  Handled: boolean;
  Index, yy: integer;
  uFrmt: Uint;
  FloatValue: extended;
  Format: string;
  Checked: boolean;

  details: TThemedElementDetails;
  aState: TCheckboxState;
begin
  Handled := False;
  Rc := GetCellRect(x, y);
  OffsetRect(Rc, -FHorzOffset + FixedWidth, -FVertOffset + FixedHeight);
  if IntersectRect(Dummy, Rc, CellBox) then
  begin
    Column := FColumns[x];
    with Canvas do
    begin
      Font.Assign(Column.Font);
      if not FEnabled then
        Font.Color := FGridColor;
      Pen.Color := FGridColor;
      Brush.Color := GetCellColor(X, Y);

      if Assigned(FOnDrawCell) then
        FOnDrawCell(Self, Canvas, X, Y, Rc, Handled);

      if not Handled then
      begin
        Brush.Style := bsSolid;

        if FColumns[X].ControlType = ctCheckBox then
        begin
          // Default size of rectangle : 16
          if (X = FCol) and (Y = FRow) and (FEdit.Visible = False) then
          begin
            Brush.Color := clHighLight;
            Font.Color := clHighlightText;
          end;
          Rectangle(Rc);
          if (X = FCol) and (Y = FRow) and (FEdit.Visible = False) then
          begin
            InflateRect(Rc, -1, -1);
            DrawFocusRect(Rc);
            InflateRect(Rc, 1, 1);
          end;
          yy := ((Rc.Bottom - Rc.Top) - 16) div 2;
          Inc(RC.top, yy);
          Dec(RC.bottom, yy);
  {case BooleanType of
    hgcbtString:
      if Checked then
        DrawText(  Canvas.Handle, pchar(columns[ACol].StringAsTrue),-1,Arect,STR_BOOLFRMT)
      else
        DrawText(  Canvas.Handle, pchar(columns[ACol].StringAsFalse),-1,Arect,STR_BOOLFRMT);
    hgcbtCheckBox:
      DrawFrameControl(Canvas.Handle,  ARect, DFC_BUTTON, CHECKState[CHECKED]);
    hgcbtRadio:
      DrawFrameControl(Canvas.Handle,ARect, DFC_BUTTON, RADIOState[CHECKED]);
  end;}
          //if (Cells[X,Y] = '') or (Cells[X,Y] = '0') then Checked := False
          //else Checked := True;
          //DrawFrameControl(Canvas.Handle,  RC, DFC_BUTTON, CHECKState[Checked]);

          //ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect, nil);

          if (Cells[X, Y] = '') or (Cells[X, Y] = '0') then
            AState := cbUnchecked
          else
            AState := cbChecked;
          Details := ThemeServices.GetElementDetails(arrtb[AState]);
          ThemeServices.DrawElement(Canvas.Handle, Details, RC, nil);
          Exit;
        end;

        if X = 0 then
        begin
          Rectangle(Rc);
          Rc.Left := Rc.Left + 18 * FRows.Items[y].NodeIndex;
        end;

        if Assigned(FBeforeDrawTextCell) then
          FBeforeDrawTextCell(Self, Canvas, X, Y, Rc);

        // Dibujar celda:
        if FShowGrid then
          Rectangle(Rc)
        else
          FillRect(Rc);

        // Dibujar Imagen en la columna 0: -------------------------------------
        if (X = 0) then
        begin
          if (Images <> nil) and (Rows[Y].ImageIndex > -1) then
          begin
            Images.Draw(Canvas, Rc.Left + 2, Rc.Top + 2, Rows[Y].ImageIndex);
            Rc.Left := Rc.Left + Images.Width + 4;
            //Rc.Right := Rc.Right;
          end;
        end;
        // ---------------------------------------------------------------------

        // Dibujar highlight: --------------------------------------------------
        if (X = FCol) and (Y = FRow) and not FEdit.Visible then
        begin
          Brush.Color := clHighLight;
          Font.Color := clHighlightText;
          if FShowGrid then
            Rectangle(Rc)
          else
            FillRect(Rc);
          InflateRect(Rc, -1, -1);
          DrawFocusRect(Rc);
          InflateRect(Rc, 1, 1);
        end;
        // ---------------------------------------------------------------------

        // Draw Text: ----------------------------------------------------------
        Brush.Style := bsClear;
        InflateRect(Rc, -4, -2);
        case FColumns[X].HorzAlign of
          haLeft: uFrmt := DT_LEFT;
          haCenter: uFrmt := DT_CENTER;
          haRight: uFrmt := DT_RIGHT;
        end;
        case FColumns[X].VertAlign of
          vaTop: uFrmt := uFrmt or DT_TOP;
          vaCenter: uFrmt := uFrmt or DT_VCENTER;
          vaBottom: uFrmt := uFrmt or DT_BOTTOM;
        end;
        if FColumns[X].WordBreak then
          uFrmt := uFrmt or DT_WORDBREAK;

        uFrmt := uFrmt or DT_NOPREFIX;

        if (FColumns[X].ControlType = ctNumeric) and (FColumns[X].ThousandsSeparator) then
        begin
          if not TextToFloat(PChar(Cells[X, Y]), FloatValue, fvExtended) then
            FloatValue := 0;
          Format := FloatToStrF(FloatValue, ffNumber, 10, Columns[x].Decimals);
          if (not FColumns[X].FShowZero) and (FloatValue = 0) then
            Format := '';
        end
        else
          Format := Cells[X, Y];
        Rc.Top := Rc.Top - 1;
        DrawText(Handle, PChar(Format), -1, Rc, uFrmt);
        // ---------------------------------------------------------------------

        if Assigned(FAfterDrawTextCell) then
          FAfterDrawTextCell(Self, Canvas, X, Y, Rc);
      end;
    end;
  end;
end;

procedure TNiceGrid.DrawSelection;
var
  R, R1, R2: TRect;
  HOffset, VOffset: integer;

begin

  if (FCol = -1) or (FRow = -1) then
    Exit;

  HOffset := -FHorzOffset + FixedWidth;
  VOffset := -FVertOffset + FixedHeight;

  R1 := GetCellRect(FSelectArea.Left, FSelectArea.Top);
  R2 := GetCellRect(FSelectArea.Right, FSelectArea.Bottom);
  R := Rect(R1.Left, R1.Top, R2.Right, R2.Bottom);
  OffsetRect(R, HOffset, VOffset);

  with Canvas do
  begin

    if Focused then
      Pen.Color := clBlack
    else
      Pen.Color := FGridColor;

    Pen.Width := 3;
    Brush.Style := bsClear;
    Rectangle(R);

    Pen.Width := 1;
    Brush.Style := bsSolid;
    if Focused then
      Brush.Color := clBlack
    else
      Brush.Color := FGridColor;
    Pen.Color := clWhite;

    case SmallBoxPos of
      0: SmallBox := Rect(R.Right - 3, R.Bottom - 3, R.Right + 3, R.Bottom + 3);
      1: SmallBox := Rect(R.Right - 3, R.Top - 3 + 5, R.Right + 3, R.Top + 3 + 5);
      2: SmallBox := Rect(R.Left - 3 + 5, R.Bottom - 3, R.Left + 3 + 5, R.Bottom + 3);
    end;

    Rectangle(SmallBox);
    SmallBoxPos := 0;  // Reset to Right Bottom

  end;

  if (SmallBoxArea.Left <> -1) then
  begin
    R1 := GetCellRect(SmallBoxArea.Left, SmallBoxArea.Top);
    OffsetRect(R1, HOffset, VOffset);
    R2 := GetCellRect(SmallBoxArea.Right, SmallBoxArea.Bottom);
    OffsetRect(R2, HOffset, VOffset);
    R := Rect(R1.Left, R1.Top, R2.Right, R2.Bottom);

    with Canvas do
    begin
      Pen.Color := clBlack;
      Pen.Width := 1;
      Pen.Style := psDot;
      Brush.Style := bsClear;
      Rectangle(R);
      Pen.Style := psSolid;
      Pen.Width := 1;
    end;
  end;
end;

procedure TNiceGrid.ClearUnused;
var
  t: integer;
begin
  if (AllWidth < ClientWidth) then
  begin
    with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := FColor;
      FillRect(Rect(AllWidth, 0, ClientWidth, ClientHeight));
    end;
  end;
  if FShowFooter then
    Exit;
  if (AllHeight < ClientHeight) then
  begin
    with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := FColor;
      FillRect(Rect(0, AllHeight, ClientWidth, ClientHeight));
    end;
  end;
  if ((FMaxVScroll - FVertOffset) < FDefRowHeight) then
  begin
    with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := FColor;
      t := FixedHeight + (((ClientHeight - FixedHeight) div FDefRowHeight) *
        FDefRowHeight);
      FillRect(Rect(0, t, ClientWidth, ClientHeight));
    end;
  end;
end;

procedure TNiceGrid.Paint;
var
  x, y: integer;
  RgnInv, RgnAll, RgnBody, RgnSel, Temp: HRGN;
  HOffset, VOffset: integer;
  R, R1, R2: TRect;
  RH, htmp: integer;
begin
  if FUpdating then Exit;
  if not HandleAllocated then Exit;

  if (ColCount = 0) then
  begin
    with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := FColor;
      FillRect(Rect(0, 0, ClientWidth, ClientHeight));
    end;
    Exit;
  end;

  if (RowCount > 0) then
  begin
    // Calculating area that will be covered by selection rectangle
    HOffset := -FHorzOffset + FixedWidth;
    VOffset := -FVertOffset + FixedHeight;
    R1 := GetCellRect(FSelectArea.Left, FSelectArea.Top);
    R2 := GetCellRect(FSelectArea.Right, FSelectArea.Bottom);
    R := Rect(R1.Left, R1.Top, R2.Right, R2.Bottom);
    OffsetRect(R, HOffset, VOffset);

    // Creating region, excluding selection rectangle to reduce flicker
    RgnSel := CreateRectRgn(R.Left - 1, R.Top - 1, R.Right + 1, R.Bottom + 1);
    Temp := CreateRectRgn(R.Left - 1, R.Top - 1, R.Right + 1, R.Bottom + 1);
    //Temp := CreateRectRgn(R.Left+2, R.Top+2, R.Right-2, R.Bottom-2);
    CombineRgn(RgnSel, RgnSel, Temp, RGN_XOR);

    //??
    if FShowFooter then
      RgnInv := CreateRectRgn(FixedWidth, FixedHeight, ClientWidth, FooterTop)
    else
      RgnInv := CreateRectRgn(FixedWidth, FixedHeight, ClientWidth, ClientHeight);
    if FEnabled then
      CombineRgn(RgnInv, RgnInv, RgnSel, RGN_DIFF);
    SelectClipRgn(Canvas.Handle, RgnInv);

    for y := 0 to RowCount - 1 do
    begin
      if Rows[y].Visible then
      begin
        // Calcular el RowHeight:
        RH := DefRowHeight;
        for x := 0 to ColCount - 1 do
        begin
          if Columns[x].Visible then
          begin
            if (integer(GetObject(x, y)) <> MergeID) then
            begin
              htmp := CalcRowHeight(x, y);
              if RH < htmp then
                RH := htmp;
            end;
          end;
        end;
        Rows[y].Height := RH;

        // Dibujar row celda a celda:
        for x := 0 to ColCount - 1 do
        begin
          if Columns[x].Visible then
          begin
            if (integer(GetObject(x, y)) <> MergeID) then
              DrawCell(X, Y);
          end;
        end;
      end;
    end;

    for x := 0 to Mergeds.Count - 1 do
    begin
      DrawMergedCell(x);
    end;

    RgnAll := CreateRectRgn(0, 0, ClientWidth, ClientHeight);
    if FEnabled then
      CombineRgn(RgnAll, RgnAll, RgnSel, RGN_DIFF);
    SelectClipRgn(Canvas.Handle, RgnAll);
    ClearUnused;

    if FShowFooter then
      RgnBody := CreateRectRgn(FixedWidth, FixedHeight, ClientWidth, FooterTop)
    else
      RgnBody := CreateRectRgn(FixedWidth, FixedHeight, ClientWidth, ClientHeight);
    SelectClipRgn(Canvas.Handle, RgnBody);

    //if FEnabled then DrawSelection;

    SelectClipRgn(Canvas.Handle, 0);

    DeleteObject(RgnInv);
    DeleteObject(RgnAll);
    DeleteObject(RgnBody);
    DeleteObject(RgnSel);
    DeleteObject(Temp);

  end
  else
    ClearUnused;

  RenderGutter;
  RenderHeader;
  if FShowFooter then
    RenderFooter;

end;

procedure TNiceGrid.UpdateHeader;
var
  P: PHeaderInfo;
  x, y: integer;
  t: TStringList;
  s: string;
  LastX: TList;
  LastY: PHeaderInfo;
  Blank: PHeaderInfo;

begin

  ClearHeaderInfos;

  LastX := TList.Create;
  t := TStringList.Create;

  Blank := New(PHeaderInfo);
  Blank^.Str := '^%%%%%^******^';

  while (LastX.Count < FHeaderLine) do
    LastX.Add(Blank);

  P := nil;
  for x := 0 to FColumns.Count - 1 do
  begin
    if not FColumns[x].FVisible then
    begin
      for y := 0 to FHeaderLine - 1 do
        LastX[y] := Blank;
      Continue;
    end;
    t.Text := StringReplace(FColumns[x].Title, '|', #13, [rfReplaceAll]);
    while (t.Count < FHeaderLine) do
    begin
      if (t.Count = 0) then
        t.Add('')
      else
        t.Add(t[t.Count - 1]);
    end;
    LastY := Blank;
    for y := 0 to FHeaderLine - 1 do
    begin
      s := t[y];
      if (s = LastY.Str) then
      begin
        LastY^.Rc.Bottom := Min(FHeaderLine - 1, Max(LastY^.Rc.Bottom, y));
      end
      else
      begin
        if (s = PHeaderInfo(LastX[y])^.Str) then
        begin
          P := PHeaderInfo(LastX[y]);
          P^.Rc.Right := P^.Rc.Right + 1;
        end
        else
        begin
          P := New(PHeaderInfo);
          P^.Rc := Rect(x, y, x, y);
          P^.Str := s;
          FHeaderInfos.Add(P);
        end;
        LastX[y] := P;
      end;
      LastY := P;
    end;
  end;

  LastX.Free;
  t.Free;
  Dispose(Blank);

  Recalculate;
end;

function TNiceGrid.GetColCoord(I: integer): integer;
var
  x: integer;
  Column: TNiceColumn;
begin
  Result := 0;
  for x := 0 to I - 1 do
  begin
    Column := FColumns[x];
    if Column.FVisible then
      Result := Result + Column.FWidth;
  end;
end;

function TNiceGrid.GetRowCoord(I: integer): integer;
var
  x: integer;
  Row: TNiceRow;
begin
  Result := 0;
  for x := 0 to I - 1 do
  begin
    Row := FRows[x];
    if Row.FVisible then
      Result := Result + Row.FHeight;
  end;
end;

function TNiceGrid.GetCellRect(x, y: integer): TRect;
var
  l, t, w, h, i: integer;
begin
  if (x = -1) or (y = -1) then
  begin
    Result := Rect(0, 0, 0, 0);
    Exit;
  end;
  l := GetColCoord(x);
  t := GetRowCoord(y);
  w := 0;
  if (FColumns[x].FVisible) then
    w := FColumns[x].FWidth;
  if (Rows[y].FVisible) then
    h := Rows[y].Height;
  Result := Rect(l - 1, t - 1, l + w, t + h);
end;

function TNiceGrid.CellRectToClient(R: TRect): TRect;
begin
  Result := R;
  OffsetRect(Result, -FHorzOffset + FixedWidth, -FVertOffset + FixedHeight);
end;

function TNiceGrid.GetCellAtPos(X, Y: integer): TPoint;
var
  ax, ay: integer;
begin
  ax := (FHorzOffset + X) - FixedWidth;
  ay := (FVertOffset + Y) - FixedHeight;
  Result.X := 0;
  while (GetColCoord(Result.X) < ax) do
  begin
    Result.X := Result.X + 1;
    if (Result.X > FColumns.Count - 1) then
      Break;
  end;
  Result.X := Max(0, Result.X - 1);
  Result.Y := 0;
  while (GetRowCoord(Result.Y) < ay) do
  begin
    Result.Y := Result.Y + 1;
    if (Result.Y > FRows.Count - 1) then
      Break;
  end;

  Result.Y := Max(0, Result.Y - 1);
end;

function TNiceGrid.GetColFromX(X: integer): integer;
var
  ax: integer;
begin
  if (X < FixedWidth) then
  begin
    Result := -1;
    Exit;
  end;
  Result := 0;
  ax := (FHorzOffset + X) - FixedWidth;
  while (GetColCoord(Result) < ax) do
  begin
    Result := Result + 1;
    if (Result > FColumns.Count - 1) then
      Break;
  end;
  Result := Result - 1;
  if (Result > FColumns.Count - 1) or (Result < 0) then
    Result := -1;
end;

function TNiceGrid.GetRowFromY(Y: integer): integer;
var
  ay: integer;
begin
  if (Y < FixedHeight) then
  begin
    Result := -1;
    Exit;
  end;

  ay := (FVertOffset + Y) - FixedHeight;
  Result := ay div FDefRowHeight;
  if (Result > RowCount - 1) then
    Result := -1;

{
var
  ax, ay: integer;
begin
  ax := (FHorzOffset + X) - FixedWidth;
  ay := (FVertOffset + Y) - FixedHeight;
  Result.X := 0;
  while (GetColCoord(Result.X) < ax) do
  begin
    Result.X := Result.X + 1;
    if (Result.X > FColumns.Count - 1) then
      Break;
  end;
  Result.X := Max(0, Result.X - 1);
  Result.Y := 0;
  while (GetRowCoord(Result.Y) < ay) do
  begin
    Result.Y := Result.Y + 1;
    if (Result.Y > FRows.Count - 1) then
      Break;
  end;

  Result.Y := Max(0, Result.Y - 1);
}


end;

function TNiceGrid.SafeGetCell(X, Y: integer): string;
var
  t: TStringList;
begin
  Result := '';
  t := TStringList(Columns[X].FStrings);
  if (Y < t.Count) then
    Result := t[Y];
end;

function TNiceGrid.GetCell(X, Y: integer): string;
var
  t: TStrings;
begin
  Result := '';
  if (X > ColCount - 1) or (Y > RowCount - 1) then
    raise Exception.Create('Cell Index out of bound.');
  t := Columns[X].FStrings;
  if (Y < t.Count) then
    Result := t[Y];
end;

function TNiceGrid.GetCellT(stVal: string; Y: integer): string;
var
  i: integer;
begin
  for i := 0 to FColumns.Count - 1 do
    if FColumns[i].Name = stVal then
    begin
      Result := GetCell(i, Y);
      Exit;
    end;
end;

procedure TNiceGrid.InternalSetCell(X, Y: integer; Value: string;
  FireOnChange: boolean);
var
  t: TStringList;
  s: string;
  CanChange: boolean;
begin
  if (ColCount = 0) or (RowCount = 0) then Exit;
  if FireOnChange and FColumns[X].FReadOnly then Exit; // <--- revisar FReadOnly (javi)

  if (X > ColCount - 1) or (Y > RowCount - 1) then
    raise Exception.Create('Cell Index out of bound.');

  t := TStringList(FColumns[X].FStrings);
  while (Y > t.Count - 1) do
    t.Add('');

  if (t[Y] = Value) then Exit;

  if FireOnChange then
  begin
    s := Value;
    CanChange := True;
    if Assigned(FOnCellChanging) then
      FOnCellChanging(Self, X, Y, CanChange);
    if not CanChange then Exit;
    if Assigned(FOnCellChange) then
      FOnCellChange(Self, X, Y, s);
    t[Y] := s;
  end
  else
    t[Y] := Value;
  if not FUpdating then
    DrawCell(X, Y);
end;

procedure TNiceGrid.SetCell(X, Y: integer; Value: string);
var
  Rnum: double;
  Pot, i: integer;
begin

  case FColumns[X].ControlType of
    ctNumeric:
    begin
      Rnum := 0;
      TryStrToFloat(Value, Rnum);
      if (Rnum - Int(Rnum)) > 0 then
      begin
        Pot := 1;//IntPower(10, Single(FColumns[Y].Decimals));
        for i := 1 to Fcolumns[X].Decimals do
          Pot := Pot * 10;
        Rnum := Round(Rnum * Pot);
        Value := FloatToStr(Rnum / Pot);
      end;
    end;
  end;
  InternalSetCell(X, Y, Value, true);
end;

procedure TNiceGrid.SetCellT(stVal: string; Y: integer; Value: string);
var
  i: integer;
begin
  for i := 0 to FColumns.Count - 1 do
    if FColumns[i].Name = stVal then
    begin
      SetCell(i, Y, Value);
      Exit;
    end;
end;

procedure TNiceGrid.BeginUpdate;
begin
  FUpdating := True;
end;

procedure TNiceGrid.EndUpdate;
begin
  FUpdating := False;
  UpdateHeader;
  Invalidate;
end;

procedure TNiceGrid.SetFlat(Value: boolean);
begin
  if (FFlat <> Value) then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TNiceGrid.SetColor(Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    inherited Color := Value;
    Invalidate;
  end;
end;

procedure TNiceGrid.SetAlternateColor(Value: TColor);
begin
  if (FAlternateColor <> Value) then
  begin
    FAlternateColor := Value;
    InvalidateCells;
  end;
end;

procedure TNiceGrid.SetGridColor(Value: TColor);
begin
  if (FGridColor <> Value) then
  begin
    FGridColor := Value;
    InvalidateCells;
  end;
end;

function TNiceGrid.GetColWidths(Index: integer): integer;
begin
  Result := FColumns[Index].FWidth;
end;

procedure TNiceGrid.SetColWidths(Index, Value: integer);
begin
  if not FAutoColWidth then
  begin
    if (ColWidths[Index] <> Value) then
      FColumns[Index].Width := Value;
  end;
end;

function TNiceGrid.GetRowHeight(Index: integer): integer;
begin
  Result := FRows[Index].FHeight;
end;

procedure TNiceGrid.SetRowHeight(Index: integer; Value: integer);
begin
  //if not FAutoColWidth then
  //begin
  if (RowHeight[Index] <> Value) then
    FRows[Index].Height := Value;
  //end;
end;

function TNiceGrid.GetRows(Index: integer): TNiceRow;
begin
  Result := FRows[Index];
end;

procedure TNiceGrid.SetRows(Index: integer; Value: integer);
begin

end;

procedure TNiceGrid.SetAutoColWidth(Value: boolean);
begin
  if (FAutoColWidth <> Value) then
  begin
    FAutoColWidth := Value;
    Recalculate;
    Invalidate;
  end;
end;

procedure TNiceGrid.SetDefColWidth(Value: integer);
begin
  if (FDefColWidth <> Value) then
  begin
    FDefColWidth := Value;
    if not FAutoColWidth then
    begin
      Recalculate;
      Invalidate;
    end;
  end;
end;

procedure TNiceGrid.SetDefRowHeight(Value: integer);
begin
  if (FDefRowHeight <> Value) then
  begin
    FDefRowHeight := Value;
    FSmallChange := Value;
    FLargeChange := Value * 5;
    Recalculate;
    Invalidate;
  end;
end;

procedure TNiceGrid.SetFitToWidth(Value: boolean);
begin
  if (FFitToWidth <> Value) then
  begin
    FFitToWidth := Value;
    FHorzOffset := 0;
    Recalculate;
    Invalidate;
  end;
end;

procedure TNiceGrid.SetHeaderColor(Value: TColor);
begin
  if (FHeaderColor <> Value) then
  begin
    FHeaderColor := Value;
    Invalidate;
  end;
end;

procedure TNiceGrid.SetHeaderDarkColor(Value: TColor);
begin
  if (FHeaderDarkColor <> Value) then
  begin
    FHeaderDarkColor := Value;
    Invalidate;
  end;
end;

procedure TNiceGrid.SetHeaderLightColor(Value: TColor);
begin
  if (FHeaderLightColor <> Value) then
  begin
    FHeaderLightColor := Value;
    Invalidate;
  end;
end;

procedure TNiceGrid.SetHeaderLine(Value: integer);
begin
  if (FHeaderLine <> Value) then
  begin
    FHeaderLine := Value;
    UpdateHeader;
    Invalidate;
  end;
end;

procedure TNiceGrid.SetSelectionColor(Value: TColor);
begin
  if (FSelectionColor <> Value) then
  begin
    FSelectionColor := Value;
    InvalidateCells;
  end;
end;

procedure TNiceGrid.KeyDown(var Key: word; Shift: TShiftState);
var
  l, t, r, b: integer;
  x, y: integer;
  Empty: boolean;
  Str: string;
  FillDown: boolean;
  FillRight: boolean;
  Old: integer;
  OldS: string;

  procedure UpdateColRow;
  begin
    FUpdating := True;
    BuffString := '';
    FCol2 := FCol;
    FRow2 := FRow;
    EnsureVisible(FCol, FRow);
    FUpdating := False;
    SetSelectArea(Rect(FCol, FRow, FCol, FRow));
    ColRowChanged;
  end;

  procedure UpdateSelectArea;
  begin
    l := Min(FCol2, FCol);
    t := Min(FRow2, FRow);
    r := Max(FCol2, FCol);
    b := Max(FRow2, FRow);
    SetSelectArea(Rect(l, t, r, b));
    EnsureVisible(FCol2, FRow2);
  end;

begin

  inherited KeyDown(Key, Shift);

  if not FEnabled then Exit;
  if (ColCount < 0) or (RowCount < 0) then Exit;

  if (ssCtrl in Shift) then
  begin
    case Key of
      Ord('X'), Ord('x'):
        if not FReadOnly then
          CutToClipboard;

      Ord('C'), Ord('c'):
        CopyToClipboard;

      Ord('V'), Ord('v'):
        if not FReadOnly then
          PasteFromClipboard;

      VK_HOME:
      begin
        FCol := GetFirstVisibleCol;
        FRow := 0;
        UpdateColRow;
      end;

      VK_END:
      begin
        FCol := GetLastVisibleCol;
        FRow := RowCount - 1;
        UpdateColRow;
      end;

      VK_DELETE:
      begin
        if not FReadOnly and (RowCount > 1) then
        begin
          Old := FRow;
          DeleteRow(FRow);
          if Assigned(FOnDeleteRow) then
            FOnDeleteRow(Self, Old);
          UpdateColRow;
        end;
      end;

    end;
  end
  else
  if (ssShift in Shift) then
  begin
    case Key of
      VK_LEFT:
      begin
        FCol2 := Max(GetPrevVisibleCol(FCol2), GetFirstVisibleCol);
        UpdateSelectArea;
      end;

      VK_RIGHT:
      begin
        FCol2 := Min(GetNextVisibleCol(FCol2), GetLastVisibleCol);
        UpdateSelectArea;
      end;

      VK_UP:
      begin
        FRow2 := Max(FRow2 - 1, 0);
        UpdateSelectArea;
      end;

      VK_DOWN:
      begin
        FRow2 := Min(FRow2 + 1, RowCount - 1);
        UpdateSelectArea;
      end;

      VK_RETURN:
        if (FSelectArea.Left = FSelectArea.Right) and
          (FSelectArea.Top = FSelectArea.Bottom) then
        begin
          FRow := Max(0, FRow - 1);
          UpdateColRow;
        end
        else
        begin
          if (FCol = FSelectArea.Left) and (FRow = FSelectArea.Top) then
          begin
            FCol := FSelectArea.Right;
            FRow := FSelectArea.Bottom;
          end
          else
          if (FRow = FSelectArea.Top) then
          begin
            FCol := FCol - 1;
            FRow := FSelectArea.Bottom;
          end
          else
          begin
            FRow := Row - 1;
          end;
          BuffString := '';
          EnsureVisible(FCol, FRow);
          InvalidateCells;
          ColRowChanged;
        end;
      ($30)..($39),
      ($41)..($5A):
      begin
        if (not (FColumns[FCol].ControlType = ctCheckBox)) and
          (not FColumns[FCol].ReadOnly) then
        begin
          FEdit.ShowEdit(FCol, FRow);
        end;
      end;
    end;
  end
  else if integer(Shift) = 0  then
  begin
    case Key of
      VK_HOME:
      begin
        FCol := GetFirstVisibleCol;
        UpdateColRow;
      end;

      VK_END:
      begin
        FCol := GetLastVisibleCol;
        UpdateColRow;
      end;

      VK_PRIOR:
      begin
        FRow := 0;
        UpdateColRow;
      end;

      VK_NEXT:
      begin
        FRow := RowCount - 1;
        UpdateColRow;
      end;

      VK_BACK,
      VK_LEFT:
      begin
        Old := FCol;
        FCol := Max(GetPrevVisibleCol(FCol), GetFirstVisibleCol);
        if (FCol = GetFirstVisibleCol) and (Old = FCol) then
        begin
          if FRow <> GetFirstVisibleRow then
          begin
            FCol := GetLastVisibleCol;
            FRow := Max(GetPrevVisibleRow(FRow), GetFirstVisibleRow);
          end;
        end;
        UpdateColRow;
      end;

      VK_RETURN,
      VK_RIGHT:
      begin
        Old := FCol;
        FCol := Min(GetNextVisibleCol(FCol), GetLastVisibleCol);
        if (FCol = GetLastVisibleCol) and (Old = FCol) then
        begin
          if FRow <> GetLastVisibleRow then
          begin
            FCol := GetFirstVisibleCol;
            FRow := Min(GetNextVisibleRow(FRow), GetLastVisibleRow);
          end;
        end;
        UpdateColRow;
      end;

      VK_UP:
      begin
        if FAutoAddRow and (FRow = (RowCount - 1)) and (FRow > 0) and not FReadOnly then
        begin
          Empty := True;
          for x := 0 to ColCount - 1 do
          begin
            if (SafeGetCell(x, RowCount - 1) <> '') then
            begin
              Empty := False;
              Break;
            end;
          end;
          if Empty then
          begin
            RowCount := RowCount - 1;
            FRow := RowCount - 1;
            if Assigned(FOnDeleteRow) then
              FOnDeleteRow(Self, RowCount);
          end
          else
            FRow := Max(0, FRow - 1);
        end
        else
        begin
          //FRow := Max(0, FRow - 1);
          FRow := Max(GetPrevVisibleRow(FRow), GetFirstVisibleRow);
        end;
        UpdateColRow;
      end;

      VK_DOWN:
      begin
        if FAutoAddRow and (FRow = (RowCount - 1)) and not FReadOnly then
        begin
          Inc(FRow);
          RowCount := RowCount + 1;
          if Assigned(FOnInsertRow) then
            FOnInsertRow(Self, FRow);
        end
        else
        begin
          //FRow := Min(RowCount - 1, FRow + 1);
          FRow := Min(GetNextVisibleRow(FRow), GetLastVisibleRow);
        end;
        UpdateColRow;
      end;

      VK_DELETE:
      begin
        if (BuffString = '') then
        begin
          if not FReadOnly then
          begin
            FUpdating := True;
            for x := SelectArea.Left to SelectArea.Right do
            begin
              for y := SelectArea.Top to SelectArea.Bottom do
                InternalSetCell(X, Y, '', True);
            end;
            FUpdating := False;
            InvalidateCells;
          end;
        end;
      end;

      VK_INSERT:
      begin
          {if not FReadOnly then
          begin
            InsertRow(Max(0, FRow));
            if Assigned(FOnInsertRow) then FOnInsertRow(Self, FRow);
            UpdateColRow;
          end;}
      end;

      VK_F2:
      begin
        if (not (FColumns[FCol].ControlType = ctCheckBox)) and
          (not FColumns[FCol].ReadOnly) then
        begin
          //FEditor := TNiceNumeric.Create(self, x, y);
          FEdit.ShowEdit(FCol, FRow);
        end;
      end;

      ($30)..($39), ($41)..($5A), (188), (190):
      begin
        if (not (FColumns[FCol].ControlType = ctCheckBox)) and
          (not FColumns[FCol].ReadOnly) then
        begin
          FEdit.ShowEdit(FCol, FRow);
          FEdit.KeyDown(Key, Shift);
        end;
      end;
    end;
  end;
end;

procedure TNiceGrid.UTF8KeyPress(var UTF8Key: TUTF8Char);
var
  Key: char;
  uSt: utf8string;
  St: ansistring;
begin
  inherited UTF8KeyPress(UTF8Key);
  uSt := utf8key;
  St := lconvencoding.UTF8ToCP1252(uSt);
  if length(St) = 1 then
    Key := St[1]
  else
    Key := Chr($0);
  KeyPress(Key);
end;

function TNiceGrid.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
  //if FMouseWheelOption=mwCursor then FSelectActive := false;
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
end;

function TNiceGrid.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result:=inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then begin
    GridMouseWheel(Shift, 1);
    Result := True; // handled, no further scrolling by the widgetset
  end;
end;

function TNiceGrid.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result:=inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then begin
    GridMouseWheel(Shift, -1);
    Result := True; // handled, no further scrolling by the widgetset
  end;
end;

procedure TNiceGrid.GridMouseWheel(shift: TShiftState; Delta: Integer);
  procedure UpdateColRow;
  begin
    FUpdating := True;
    BuffString := '';
    FCol2 := FCol;
    FRow2 := FRow;
    EnsureVisible(FCol, FRow);
    FUpdating := False;
    SetSelectArea(Rect(FCol, FRow, FCol, FRow));
    ColRowChanged;
  end;
begin
  if ssCtrl in Shift then
    if Delta = -1 then
      FCol := Max(GetPrevVisibleCol(FCol), GetFirstVisibleCol)
    else
      FCol := Min(GetNextVisibleCol(FCol), GetLastVisibleCol)
  else
    if Delta = -1 then
      FRow := Max(GetPrevVisibleRow(FRow), GetFirstVisibleRow)
    else
      FRow := Min(GetNextVisibleRow(FRow), GetLastVisibleRow);

  UpdateColRow;
end;

procedure TNiceGrid.KeyPress(var Key: char);
var
  s: string;
begin
  inherited KeyPress(Key);

  if not FEnabled then Exit;
  if FReadOnly then Exit;
  if (ColCount < 0) or (RowCount < 0) then Exit;

  if FColumns[FCol].ControlType = ctCheckBox then
  begin
    if (Key = Chr($31)) or (Key = 'y') or (Key = 'Y') or (Key = 's') or (Key = 'S') then
      Cells[FCol, FRow] := '1'
    else if (Key = Chr($30)) or (Key = 'n') or (Key = 'N') then
      Cells[FCol, FRow] := '0'
    else if Key = Chr(VK_SPACE) then
      if (Cells[FCol, FRow] <> '1') then
        Cells[FCol, FRow] := '1'
      else
        Cells[FCol, FRow] := '0'
    else
      Key := Chr(0);

    if Assigned(FOnCellChange) then
    begin
      s := Cells[FCol, FRow];
      FOnCellChange(Self, FCol, FRow, s);
    end;
    DrawCell(FCol, FRow);
  end
  else if FEdit.Visible = True then
  begin
    FEdit.KeyPress(Key);
    FEdit.Text := Key;
    FEdit.SelStart := Length(FEdit.Text);
  end;

{
inherited KeyPress(Key);
if not EditorKey then
  // we are interested in these keys only if they came from the grid
  if not EditorMode and EditingAllowed(FCol) then begin
    if (Key=#13) then begin
      SelectEditor;
      EditorShow(True);
      Key := #0;
    end else
    if (Key in [^H, #32..#255]) then begin
      EditorShowChar(Key);
      Key := #0;
    end;
  end;
 }
end;

function TNiceGrid.GetHitTestInfo(X, Y: integer): TGridHitTest;
var
  a, i1, i2: integer;
  ax, ay: integer;
  IsSizing: boolean;

begin
  Result := gtNone;
  IsSizing := False;

  ax := (FHorzOffset + X) - FixedWidth;
  ay := (FVertOffset + Y) - FixedHeight;

  if not FAutoColWidth then
  begin
    for a := 1 to ColCount do
    begin
      i1 := GetColCoord(a);
      i2 := X + FHorzOffset - FixedWidth;
      if (i2 > (i1 - 2)) and (i2 < (i1 + 2)) then
      begin
        SizingCol := a - 1;
        IsSizing := FColumns[SizingCol].FCanResize;
        Break;
      end;
    end;
  end;

  if PtInRect(SmallBox, Point(X, Y)) then
    Result := gtSmallBox
  else if IsSizing then
    Result := gtColSizing
  else if ((X < FixedWidth) and (Y < FixedHeight)) then
    Result := gtLeftTop
  else if ((X < FixedWidth) and (Y > FixedHeight) and (ay < BodyHeight)) then
    Result := gtLeft
  else if ((Y < FixedHeight) and (X > FixedWidth) and (ax < BodyWidth)) then
    Result := gtTop
  else if ((X > FixedWidth) and (Y > FixedHeight) and (ax < BodyWidth) and
    (ay < BodyHeight)) then
    Result := gtCell;

end;

procedure TNiceGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  Pt: TPoint;
begin
  if not FEnabled then
  begin
    inherited;
    Exit;
  end;

  case Button of
    mbLeft:
    begin
      case FZone of
        gtLeftTop:
        begin
          if FPopupShow then
          begin
            Pt.X := 0;
            Pt.Y := FixedHeight - 1;
            Pt := ClientToScreen(Pt);
            FPopupMenu.Popup(Pt.X, Pt.Y);
            FZone := gtNone;
          end
          else
          begin
            FRow := 0;
            FCol := 0;
            BuffString := '';
            EnsureVisible(0, 0);
            FCol2 := ColCount - 1;
            FRow2 := RowCount - 1;
            SetSelectArea(Rect(0, 0, ColCount - 1, RowCount - 1));
            ColRowChanged;
          end;
        end;

        gtLeft:
        begin
          //FRow := GetRowFromY(Y);
          FRow := GetCellAtPos(X, Y).y;
          FCol := 0;
          if (ssShift in Shift) then
          begin
            LastHover := FRow;
            BuffString := '';
            EnsureVisible(FCol, FRow);
            FCol2 := ColCount - 1;
            FRow2 := FRow;
            SmallBoxPos := 2;
            AdjustSelection(Rect(0, FRow, ColCount - 1, FRow), True);
            ColRowChanged;
          end;
          if Assigned(OnGutterClick) then
            FOnGutterClick(Self, FRow, Button, Shift);
        end;

        gtTop:
        begin
          if (ssShift in Shift) then
          begin
            FCol := GetColFromX(X);
            FRow := 0;
            LastHover := FCol;
            BuffString := '';
            EnsureVisible(FCol, FRow);
            FCol2 := FCol;
            FRow2 := RowCount - 1;
            SmallBoxPos := 1;
            AdjustSelection(Rect(FCol, 0, FCol, RowCount - 1), True);
            ColRowChanged;
          end;
          if Assigned(FOnHeaderClick) then
            FOnHeaderClick(Self, FCol, Button, Shift);
        end;

        gtCell:
        begin
          if IsEditing then FEdit.HideEdit;
          BuffString := '';
          Pt := GetCellAtPos(X, Y);
          if (Pt.X = FCol) and (Pt.Y = FRow) then
          begin
            EnsureVisible(FCol, FRow);
            if (not FReadOnly) and (not FColumns[FCol].FReadOnly) then
            begin
              IsEditing := True;
              if Columns[Pt.X].ControlType = ctCheckBox then
              begin
                if (Cells[Pt.X, Pt.Y] = '') or (Cells[Pt.X, Pt.Y] = '0') then
                  Cells[Pt.X, Pt.Y] := '1'
                else
                  Cells[Pt.X, Pt.Y] := '0';
                DrawCell(Pt.X, Pt.Y);
              end
              else
              begin
                FEdit.ShowEdit(FCol, FRow);
                SetCapture(FEdit.Handle);
                Exit;
              end;
            end;
          end
          else
          if (Pt.X <> -1) and (pt.Y <> -1) then
          begin
            EnsureVisible(Pt.X, Pt.Y);
            FCol := Pt.X;
            FRow := Pt.Y;
            BuffString := '';
            FCol2 := FCol;
            FRow2 := FRow;
            SetSelectArea(Rect(FCol, FRow, FCol, FRow));
          end;
          ColRowChanged;
        end;
        gtColSizing: SizingColX := GetColCoord(SizingCol);
        gtSmallBox: SmallBoxArea := FSelectArea;
      end;
    end;
    //mbRight:
    //if Assigned(PopupMenu) then
    //PopupMenu.Popup(Pt.X , Pt.Y);
    //mbMiddle:
    //self.PopupMenu.Popup(X,Y);
  end;

  SetCapture(Handle);
  SetFocus;
  inherited;
end;

procedure TNiceGrid.MouseMove(Shift: TShiftState; X, Y: integer);
var
  Total2Col: integer;
  Suggested: integer;
  Pt: TPoint;
  l, t, r, b: integer;
  i: integer;

begin

  if not FEnabled then
  begin
    Cursor := crDefault;
    inherited;
    Exit;
  end;

  if (ssLeft in Shift) then
  begin
    if (Cursor = crPlus) then
    begin
      Pt := GetCellAtPos(X, Y);
      if (Pt.X <> -1) and (Pt.Y <> -1) then
      begin
        l := Min(Pt.X, FCol);
        t := Min(Pt.Y, FRow);
        r := Max(Pt.X, FCol);
        b := Max(Pt.Y, FRow);
        FCol2 := Pt.X;
        FRow2 := Pt.Y;
        SetSelectArea(Rect(l, t, r, b));
        EnsureVisible(FCol2, FRow2);
      end;
    end
    else

    if (Cursor = crSmallCross) then
    begin
      Pt := GetCellAtPos(X, Y);
      if (Pt.X <> -1) and (Pt.Y <> -1) then
      begin
        l := Min(Pt.X, SmallBoxArea.Left);
        t := Min(Pt.Y, SmallBoxArea.Top);
        r := Max(Pt.X, SmallBoxArea.Right);
        b := Max(Pt.Y, SmallBoxArea.Bottom);
        FCol2 := Pt.X;
        FRow2 := Pt.Y;
        SetSelectArea(Rect(l, t, r, b));
        EnsureVisible(FCol2, FRow2);
      end;
    end
    else

    if (Cursor = crRight) then
    begin
      i := GetRowFromY(Y);
      if (i <> -1) and (i <> LastHover) then
      begin
        LastHover := i;
        t := Min(i, FRow);
        b := Max(i, FRow);
        FRow2 := i;
        SmallBoxPos := 2;
        AdjustSelection(Rect(0, t, ColCount - 1, b), True);
      end;
    end
    else

    if (Cursor = crDown) then
    begin
      i := GetColFromX(X);
      if (i <> -1) and (i <> LastHover) then
      begin
        LastHover := i;
        l := Min(i, FCol);
        r := Max(i, FCol);
        FCol2 := i;
        SmallBoxPos := 1;
        AdjustSelection(Rect(l, 0, r, RowCount - 1), True);
      end;
    end
    else

    if (Cursor = crHSplit) then
    begin
      Suggested := Max(5, X + FHorzOffset - SizingColX - FixedWidth);
      if FFitToWidth then
      begin
        if (SizingCol = ColCount - 1) or (SizingCol = -1) then
        begin
          inherited;
          Exit;
        end;
        Total2Col := (ClientWidth - FixedWidth) -
          (TotalWidth - Columns[SizingCol].FWidth - Columns[SizingCol + 1].FWidth);
        if (Total2Col > 10) then
        begin
          Columns[SizingCol].FWidth := Suggested;
          Columns[SizingCol + 1].FWidth := Total2Col - Suggested;
        end;
        if (Columns[SizingCol + 1].FWidth < 5) then
        begin
          Columns[SizingCol].FWidth := Total2Col - 5;
          Columns[SizingCol + 1].FWidth := 5;
        end;
      end
      else
      begin
        Columns[SizingCol].FWidth := Suggested;
      end;
      Recalculate;
      InvalidateRightWard(FixedWidth);
    end;

  end
  else
  begin
    FZone := GetHitTestInfo(X, Y);
    case FZone of
      //gtNone,
      //gtLeftTop: ;
      gtLeft,
      gtTop:
        if (ssShift in Shift) then Cursor := CursorArray[FZone]
        else Cursor := CursorArray[gtNone];
      //gtCell,
      gtColSizing,
      gtSmallBox:
        Cursor := CursorArray[FZone];
      else
        Cursor := CursorArray[gtNone];
    end;
  end;

  inherited;
end;

procedure TNiceGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  Ls: TList;
  ax, ay: integer;
  l, t, w, h: integer;

  function GetCopy(nx, ny: integer): string;
  var
    ix, iy: integer;
  begin
    ix := nx;
    iy := ny;
    while (ix < l) do
      ix := ix + w;
    while (iy < t) do
      iy := iy + h;
    ix := ((ix - l) mod w) + l;
    iy := ((iy - t) mod h) + t;
    Result := SafeGetCell(TNiceColumn(Ls[ix]).Index, iy);
  end;

begin

  if (Cursor = crSmallCross) then
  begin
    if FReadOnly then
    begin
      SmallBoxArea := Rect(-1, -1, -1, -1);
      InvalidateCells;
    end
    else
    begin
      FUpdating := True;
      Ls := TList.Create;
      for ax := FSelectArea.Left to FSelectArea.Right do
        if FColumns[ax].FVisible then
          Ls.Add(FColumns[ax]);
      l := 0;
      for ax := 0 to Ls.Count - 1 do
      begin
        if (TNiceColumn(Ls[ax]).Index = SmallBoxArea.Left) then
        begin
          l := ax;
          Break;
        end;
      end;
      t := SmallBoxArea.Top;
      w := (SmallBoxArea.Right - SmallBoxArea.Left) + 1;
      h := (SmallBoxArea.Bottom - SmallBoxArea.Top) + 1;
      for ax := 0 to Ls.Count - 1 do
        for ay := FSelectArea.Top to FSelectArea.Bottom do
          InternalSetCell(TNiceColumn(Ls[ax]).Index, ay, GetCopy(ax, ay), True);
      Ls.Free;
      SmallBoxArea := Rect(-1, -1, -1, -1);
      BuffString := '';
      FUpdating := False;
      InvalidateCells;
    end;
  end;

  //Cursor := CursorArray[GetHitTestInfo(X, Y)];
  FZone := GetHitTestInfo(X, Y);
  case FZone of
    //gtNone,
    //gtLeftTop: ;
    gtLeft,
    gtTop:
      if (ssShift in Shift) then Cursor := CursorArray[FZone]
      else Cursor := CursorArray[gtNone];
    //gtCell,
    gtColSizing,
    gtSmallBox:
      Cursor := CursorArray[FZone];
    else
      Cursor := CursorArray[gtNone];
  end;
  ReleaseCapture;
  LastHover := -1;

  inherited MouseUp(Button, Shift, X, Y);

end;

procedure TNiceGrid.SetColumns(Value: TNiceColumns);
begin
  FColumns.Assign(Value);
end;

function TNiceGrid.CreateColumn: TNiceColumn;
begin
  Result := TNiceColumn.Create(Columns);
end;

procedure TNiceGrid.UpdateColumn(Index: integer);
var
  l, w: integer;
  Rc: TRect;
begin
  l := GetColCoord(Index);
  w := FColumns[Index].FWidth;
  Rc := Rect(l - 3, 0, l + w + 3, ClientHeight);
  InvalidateRect(Handle, @Rc, False);
end;

procedure TNiceGrid.UpdateColumns;
begin
  UpdateHeader;
  Invalidate;
end;

function TNiceGrid.GetColCount: integer;
begin
  Result := FColumns.Count;
end;

function TNiceGrid.GetRowCount: integer;
begin
  Result := FRows.Count;
end;

function TNiceGrid.TotalWidth: integer;
var
  x: integer;
begin
  Result := 0;
  for x := 0 to FColumns.Count - 1 do
  begin
    if FColumns[x].FVisible then
      Result := Result + FColumns[x].FWidth;
  end;
end;

procedure TNiceGrid.CMFontChanged(var Msg: TLMessage);
var
  x: integer;
begin
  inherited;
  for x := 0 to FColumns.Count - 1 do
    FColumns[x].Font.Assign(Font);
end;

procedure TNiceGrid.WMSize(var Msg: TLMessage);
begin
  inherited;
  Recalculate;
  if (FColumns.Count > 0) then EnsureVisible(FCol, FRow);
end;

procedure TNiceGrid.WMEraseBkgnd(var Msg: TLMEraseBkGnd);
begin
  Msg.Result := 1;
end;

procedure TNiceGrid.CMWantSpecialKey(var Message: TLMKey);
begin
  inherited;
  with Message do
    case CharCode of
      VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN:
        Result := 1;
    end;
end;

procedure TNiceGrid.SetShowGrid(Value: boolean);
begin
  if (FShowGrid <> Value) then
  begin
    FShowGrid := Value;
    InvalidateCells;
  end;
end;

procedure TNiceGrid.SetShowFooter(const Value: boolean);
begin
  if (FShowFooter <> Value) then
  begin
    FShowFooter := Value;
    Recalculate;
    Invalidate;
  end;
end;

procedure TNiceGrid.Clear;
var
  x: integer;
begin
  for x := 0 to ColCount - 1 do
    FColumns[x].FStrings.Clear;
  InvalidateCells;
end;

procedure TNiceGrid.SetHorzOffset(Value: integer);
begin
  if (FHorzOffset <> Value) then
  begin
    FHorzOffset := Max(0, Min(FMaxHScroll, Value));
    SetScrollBar(SB_HORZ, 0, FHorzOffset, SIF_POS);
    InvalidateRightWard(FixedWidth);
  end;
end;

procedure TNiceGrid.SetVertOffset(Value: integer);
begin
  if (FVertOffset <> Value) then
  begin
    FVertOffset := Max(0, Min(FMaxVScroll, Value));
    NormalizeVertOffset;
    SetScrollBar(SB_VERT, 0, FVertOffset, SIF_POS);
    InvalidateDownWard(FixedHeight);
  end;
end;

procedure TNiceGrid.EnsureVisible(X, Y: integer);
var
  i: integer;
  t, b, h: integer;
  l, r: integer;
  Horz, Vert: boolean;
  SuggestedHorz, SuggestedVert: integer;

begin

  if (X = -1) or (Y = -1) then Exit;
  if (AllWidth < ClientWidth) and (AllHeight < ClientHeight) then Exit;

  SuggestedVert := FVertOffset;
  t := GetRowCoord(y) - FVertOffset + FixedHeight;
  h := FRows[y].Height;
  //if FShowFooter then h := h + ;
  b := t + h;
  Vert := (t < FixedHeight) or (b > ClientHeight);
  if (t < FixedHeight) then
    SuggestedVert := Max(0, SuggestedVert + (t - FixedHeight));
  if (b > ClientHeight) then
    SuggestedVert := Min(FMaxVScroll, SuggestedVert - (ClientHeight - b) + 1);


  SuggestedHorz := FHorzOffset;
  l := GetColCoord(X) - FHorzOffset + FixedWidth;
  r := l + FColumns[x].FWidth;
  Horz := (l < FixedWidth) or (r > ClientWidth);
  if (l < FixedWidth) then
    SuggestedHorz := Max(0, SuggestedHorz + (l - FixedWidth));
  if (r > ClientWidth) then
    SuggestedHorz := Min(FMaxHScroll, SuggestedHorz - (ClientWidth - r) + 1);

  if Vert and not Horz then
    SetVertOffset(SuggestedVert)
  else
  if Horz and not Vert then
    SetHorzOffset(SuggestedHorz)
  else
  if Horz and Vert then
  begin
    FHorzOffset := SuggestedHorz;
    FVertOffset := SuggestedVert;
    SetScrollBar(SB_HORZ, 0, FHorzOffset, SIF_POS);
    SetScrollBar(SB_VERT, 0, FVertOffset, SIF_POS);
    Invalidate;
  end;
end;

function TNiceGrid.HeaderCells(I: integer): THeaderInfo;
begin
  Result := PHeaderInfo(FHeaderInfos[I])^;
end;

function TNiceGrid.HeaderCellsCount: integer;
begin
  Result := FHeaderInfos.Count;
end;

procedure TNiceGrid.SetReadOnly(Value: boolean);
begin
  if (FReadOnly <> Value) then
  begin
    FReadOnly := Value;
  end;
end;

procedure TNiceGrid.SetCol(Value: integer);
begin
  if (FCol <> Value) then
  begin
    FCol := Value;
    FCol2 := Value;
    FRow2 := FRow;
    BuffString := '';
    SetSelectArea(Rect(FCol, FRow, FCol, FRow));
    InvalidateRightWard(FixedWidth);
    ColRowChanged;
  end;
end;

procedure TNiceGrid.SetRow(Value: integer);
begin
  if (FRow <> Value) then
  begin
    FRow := Value;
    FRow2 := Value;
    FCol2 := FCol;
    BuffString := '';
    SetSelectArea(Rect(FCol, FRow, FCol, FRow));
    InvalidateDownWard(FixedHeight);
    ColRowChanged;
  end;
end;

procedure TNiceGrid.AdjustSelection(Value: TRect; Force: boolean);
var
  Old, Rc: TRect;
  R1, R2, R: TRect;
begin

  if EqualRect(FSelectArea, Value) and not Force then
    Exit;

  Old := FSelectArea;
  FSelectArea := Value;

  Rc.Left := Min(Old.Left, FSelectArea.Left);
  Rc.Top := Min(Old.Top, FSelectArea.Top);
  Rc.Right := Max(Old.Right, FselectArea.Right);
  Rc.Bottom := Max(Old.Bottom, FSelectArea.Bottom);

  R1 := GetCellRect(Rc.Left, Rc.Top);
  R2 := GetCellRect(Rc.Right, Rc.Bottom);
  R := Rect(R1.Left, R1.Top, R2.Right, R2.Bottom);
  OffsetRect(R, -FHorzOffset + FixedWidth, -FVertOffset + FixedHeight);

  InflateRect(R, 3, 3);
  InvalidateRect(Handle, @R, False);

  if (FGutterKind = gkPointer) then
  begin
    R := Rect(0, FixedHeight, FixedWidth, ClientHeight);
    InvalidateRect(Handle, @R, False);
  end;

end;

procedure TNiceGrid.SetSelectArea(Value: TRect);
begin
  AdjustSelection(Value, False);
end;

procedure TNiceGrid.WMKillFocus(var Msg: TLMKillFocus);
begin
  if not IsEditing then
    InvalidateCells;
end;

procedure TNiceGrid.WMSetFocus(var Msg: TLMSetFocus);
begin
  InvalidateCells;
end;

procedure TNiceGrid.SetGutterKind(Value: TGutterKind);
var
  Rc: TRect;
  RedrawAll: boolean;
  Old: TGutterKind;
begin
  Old := FGutterKind;
  if (FGutterKind <> Value) then
  begin
    FGutterKind := Value;
    Recalculate;
    RedrawAll := (Old = gkNone) or (Value = gkNone);
    if RedrawAll then
    begin
      Invalidate;
    end
    else
    begin
      Rc := Rect(0, FixedHeight, FixedWidth, ClientHeight);
      InvalidateRect(Handle, @Rc, False);
    end;
  end;
end;

procedure TNiceGrid.SetGutterWidth(Value: integer);
begin
  if (FGutterWidth <> Value) then
  begin
    FGutterWidth := Value;
    Recalculate;
    Invalidate;
  end;
end;

procedure TNiceGrid.CopyToClipboard;
var
  s: string;
  t: TStringList;
  x, y: integer;
begin
  t := TStringList.Create;
  for y := FSelectArea.Top to FSelectArea.Bottom do
  begin
    s := '';
    for x := FSelectArea.Left to FSelectArea.Right do
    begin
      if FColumns[x].FVisible then
      begin
        if (x = FSelectArea.Left) then
          s := SafeGetCell(X, Y)
        else
          s := s + #9 + SafeGetCell(X, Y);
      end;
    end;
    t.Add(s);
  end;
  Clipboard.AsText := t.Text;
  t.Free;
end;

procedure TNiceGrid.CutToClipboard;
var
  s: string;
  t: TStringList;
  x, y: integer;
begin
  FUpdating := True;
  t := TStringList.Create;
  for y := FSelectArea.Top to FSelectArea.Bottom do
  begin
    s := '';
    for x := FSelectArea.Left to FSelectArea.Right do
    begin
      if FColumns[x].FVisible then
      begin
        if (x = FSelectArea.Left) then
          s := SafeGetCell(X, Y)
        else
          s := s + #9 + SafeGetCell(X, Y);
        InternalSetCell(X, Y, '', True);
      end;
    end;
    t.Add(s);
  end;
  Clipboard.AsText := t.Text;
  t.Free;
  FUpdating := False;
  InvalidateCells;
end;

procedure TNiceGrid.PasteFromClipboard;
var
  tr, tc: TStringList;
  x, y: integer;
  s: string;
  n: integer;
  TabCnt: integer;
  ax, ay: integer;
  ColCnt: integer;

begin

  if not Clipboard.HasFormat(CF_TEXT) then
    Exit;

  FUpdating := True;
  tr := TStringList.Create;
  tc := TStringList.Create;
  tr.Text := Clipboard.AsText;
  TabCnt := 1;

  for y := 0 to tr.Count - 1 do
  begin
    n := 1;
    s := tr[y];
    for x := 1 to Length(s) do
      if (s[x] = #9) then
        Inc(n);
    TabCnt := Max(TabCnt, n);
  end;

  ColCnt := ColCount; // Just to make it fast

  if (FSelectArea.Left = FSelectArea.Right) and (FSelectArea.Top =
    FSelectArea.Bottom) then
  begin

    for y := 0 to tr.Count - 1 do
    begin
      tc.Text := StringReplace(tr[y], #9, #13#10, [rfReplaceAll]);
      while (tc.Count < TabCnt) do
        tc.Add('');
      x := 0;
      ax := FCol;
      while (x < tc.Count) do
      begin
        ay := FRow + y;
        if FColumns[ax].FVisible then
        begin
          if (ax < ColCnt) and (ay < RowCount) then
            InternalSetCell(ax, ay, tc[x], True);
          Inc(x);
        end;
        Inc(ax);
      end;
    end;

  end
  else
  begin

    ay := FSelectArea.Top;
    while (ay <= FSelectArea.Bottom) do
    begin
      tc.Text := StringReplace(tr[(ay - FSelectArea.Top) mod tr.Count], #9,
        #13#10, [rfReplaceAll]);
      while (tc.Count < TabCnt) do
        tc.Add('');
      ax := FSelectArea.Left;
      x := 0;
      while (ax <= FSelectArea.Right) do
      begin
        if FColumns[ax].FVisible then
        begin
          InternalSetCell(ax, ay, tc[x], True);
          Inc(x);
          if (x = tc.Count) then
            x := 0;
        end;
        Inc(ax);
      end;
      Inc(ay);
    end;

  end;

  tr.Free;
  tc.Free;

  FUpdating := False;
  InvalidateCells;

end;

procedure TNiceGrid.InvalidateCells;
var
  Rc: TRect;
begin
  Rc := Rect(FixedWidth - 2, FixedHeight - 2, ClientWidth, ClientHeight);
  InvalidateRect(Handle, @Rc, False);
end;

procedure TNiceGrid.InvalidateDownWard(Top: integer);
var
  Rc: TRect;
begin
  Rc := Rect(0, Top, ClientWidth, ClientHeight);
  InvalidateRect(Handle, @Rc, False);
end;

procedure TNiceGrid.InvalidateRightWard(Left: integer);
var
  Rc: TRect;
begin
  Rc := Rect(Left, 0, ClientWidth, ClientHeight);
  InvalidateRect(Handle, @Rc, False);
end;

procedure TNiceGrid.NormalizeVertOffset;
begin
  FVertOffset := (FVertOffset div FDefRowHeight) * FDefRowHeight;
end;

procedure TNiceGrid.SetGutterFont(Value: TFont);
begin
  FGutterFont.Assign(Value);
  InvalidateGutter;
end;

procedure TNiceGrid.SetHeaderFont(Value: TFont);
begin
  FHeaderFont.Assign(Value);
  InvalidateHeader;
end;

procedure TNiceGrid.SetFooterFont(const Value: TFont);
begin
  FFooterFont.Assign(Value);
  Invalidate;
end;

procedure TNiceGrid.InvalidateGutter;
var
  Rc: TRect;
begin
  Rc := Rect(0, FixedHeight, FixedWidth, ClientHeight);
  InvalidateRect(Handle, @Rc, False);
end;

procedure TNiceGrid.InvalidateHeader;
var
  Rc: TRect;
begin
  Rc := Rect(0, 0, ClientWidth, FixedHeight);
  InvalidateRect(Handle, @Rc, False);
end;

procedure TNiceGrid.HeaderFontChange(Sender: TObject);
begin
  InvalidateHeader;
end;

procedure TNiceGrid.GutterFontChange(Sender: TObject);
begin
  InvalidateGutter;
end;

procedure TNiceGrid.FooterFontChange(Sender: TObject);
begin
  Invalidate;
end;

function TNiceGrid.GetFirstVisibleCol: integer;
var
  x: integer;
begin
  Result := -1;
  if (ColCount > 0) then
  begin
    for x := 0 to ColCount - 1 do
    begin
      if Columns[x].Visible then
      begin
        Result := x;
        Break;
      end;
    end;
  end;
end;

function TNiceGrid.GetLastVisibleCol: integer;
var
  x: integer;
begin
  Result := -1;
  if (ColCount > 0) then
  begin
    for x := ColCount - 1 downto 0 do
    begin
      if Columns[x].Visible then
      begin
        Result := x;
        Break;
      end;
    end;
  end;
end;

function TNiceGrid.GetNextVisibleCol(Index: integer): integer;
var
  x: integer;
begin
  Result := Index;
  if (ColCount > 0) and (Index < ColCount) then
  begin
    for x := (Index + 1) to (ColCount - 1) do
    begin
      if Columns[x].Visible then
      begin
        Result := x;
        Break;
      end;
    end;
  end;
end;

function TNiceGrid.GetPrevVisibleCol(Index: integer): integer;
var
  x: integer;
begin
  Result := Index;
  if (ColCount > 0) and (Index > 0) then
  begin
    for x := (Index - 1) downto 0 do
    begin
      if Columns[x].Visible then
      begin
        Result := x;
        Break;
      end;
    end;
  end;
end;


function TNiceGrid.GetFirstVisibleRow: integer;
var
  y: integer;
begin
  Result := -1;
  if (RowCount > 0) then
  begin
    for y := 0 to RowCount - 1 do
    begin
      if Rows[y].Visible then
      begin
        Result := y;
        Break;
      end;
    end;
  end;
end;

function TNiceGrid.GetLastVisibleRow: integer;
var
  y: integer;
begin
  Result := -1;
  if (RowCount > 0) then
  begin
    for y := RowCount - 1 downto 0 do
    begin
      if Rows[y].Visible then
      begin
        Result := y;
        Break;
      end;
    end;
  end;
end;

function TNiceGrid.GetNextVisibleRow(Index: integer): integer;
var
  y: integer;
begin
  Result := Index;
  if (RowCount > 0) and (Index < RowCount) then
  begin
    for y := (Index + 1) to (RowCount - 1) do
    begin
      if Rows[y].Visible then
      begin
        Result := y;
        Break;
      end;
    end;
  end;
end;

function TNiceGrid.GetPrevVisibleRow(Index: integer): integer;
var
  y: integer;
begin
  Result := Index;
  if (RowCount > 0) and (Index > 0) then
  begin
    for y := (Index - 1) downto 0 do
    begin
      if Rows[y].Visible then
      begin
        Result := y;
        Break;
      end;
    end;
  end;
end;


procedure TNiceGrid.DeleteRow(ARow: integer);
var
  x, y: integer;
begin

  if (ARow >= 0) and (ARow < RowCount) then
  begin
    for x := 0 to ColCount - 1 do
    begin
      with FColumns[x].Strings do
      begin
        if (Count > ARow) then
        begin
          for y := ARow to Count - 2 do
            Strings[y] := Strings[y + 1];
          Strings[Count - 1] := '';
        end;
      end;
    end;
    if (FRow = RowCount - 1) then Dec(FRow);
    FRows.Delete(ARow);
  end;
end;

procedure TNiceGrid.InsertRow(ARow: integer);
var
  x: integer;
begin
  if (ARow >= 0) and (ARow < RowCount) then
  begin
    for x := 0 to ColCount - 1 do
    begin
      with FColumns[x].Strings do
      begin
        while (Count < ARow) do
        begin
          Add('');
        end;
        Insert(ARow, '');
      end;
    end;
    FRows.Insert(ARow);
  end
  else if ARow = RowCount then
    RowCount := RowCount + 1;
end;

function TNiceGrid.AddRow: integer;
var
  x: integer;
  n: integer;
begin
  n := RowCount + 1;
  for x := 0 to ColCount - 1 do
  begin
    with FColumns[x].Strings do
    begin
      while (Count < n) do
        Add('');
      Strings[RowCount] := '';
    end;
  end;
  RowCount := RowCount + 1;
  Result := RowCount - 1;
end;


// This is a workaround to avoid mess up with accelerators.
// NiceGrid was unable to capture keyboard event of chars that already
// defined as accelerator of another control.
// (Char after '&' (ampersand) in ex. TButton.Caption, TMenuItem.Caption, etc.)
// Don't know why and how this workaround works, but this is found after
// spying with WinSight. WM_USER + $B902          - mPri-

procedure TNiceGrid.WMUnknown(var Msg: TLMessage);
begin
  Msg.Result := 0;
end;

procedure TNiceGrid.ColRowChanged;
begin
  if Assigned(Sync) then
    Sync.Row := FRow;

  if Assigned(FOnCellExit) then
    FOnCellExit(Self, FCol_Old, FRow_Old);
  if Assigned(FOnColRowChanged) then
    FOnColRowChanged(Self, FCol, FRow);
  FCol_Old := FCol;
  FRow_Old := FRow;
end;

procedure TNiceGrid.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (AComponent = Sync) and (Operation = opRemove) then
    Sync := nil;
  inherited;
end;

procedure TNiceGrid.SetGutterStrings(const Value: TStrings);
begin
  FGutterStrings.Assign(Value);
  if (FGutterKind = gkString) then
    InvalidateGutter;
end;

function TNiceGrid.GetObject(X, Y: integer): TObject;
var
  t: TStrings;
begin
  Result := nil;
  if (X > ColCount - 1) or (Y > RowCount - 1) then
    raise Exception.Create('Cell Index out of bound.');
  t := Columns[X].FStrings;
  if (Y < t.Count) then
    Result := t.Objects[Y];
end;

procedure TNiceGrid.SetObject(X, Y: integer; const Value: TObject);
var
  t: TStrings;
begin
  if (X > ColCount - 1) or (Y > RowCount - 1) then
    raise Exception.Create('Cell Index out of bound.');
  t := Columns[X].FStrings;
  while (Y > t.Count - 1) do
    t.Add('');
  t.Objects[Y] := Value;
end;

procedure TNiceGrid.ClearMergeCells;
var
  x, y: integer;
  List: TStrings;
begin
  for x := 0 to FColumns.Count - 1 do
  begin
    List := FColumns[x].FStrings;
    for y := 0 to List.Count - 1 do
      List.Objects[y] := nil;
  end;
  for x := 0 to Mergeds.Count - 1 do
    TMergeCell(Mergeds[x]).Free;
  Mergeds.Clear;
  invalidate;
end;

function TNiceGrid.MergeCells(const X1, Y1, X2, Y2: integer;
  ACaption: string): TMergeCell;
begin
  Result := TMergeCell.Create;
  Result.Font.Assign(Font);
  Result.Color := Color;
  Result.Caption := ACaption;
  Result.HorzAlign := haCenter;
  Result.VertAlign := vaCenter;
  Result.Rc := Rect(Min(X1, X2), Min(Y1, Y2), Max(X1, X2), Max(Y1, Y2));
  Mergeds.Add(Result);
  if not FUpdating then
  begin
    Recalculate;
    Invalidate;
  end;
end;

procedure TNiceGrid.BuildMergeData;
var
  Rc: TRect;
  x, y, z: integer;
begin
  for x := 0 to Mergeds.Count - 1 do
  begin
    CopyRect(Rc, TMergeCell(Mergeds[x]).Rc);
    for y := Rc.Left to Rc.Right do
    begin
      if (y >= FColumns.Count) then
        Continue;
      for z := Rc.Top to Rc.Bottom do
      begin
        InternalSetCell(y, z, '', False);
        SetObject(y, z, TObject(MergeID));
      end;
    end;
  end;
end;

procedure TNiceGrid.DrawMergedCell(Index: integer);
var
  Data: TMergeCell;
  R, Rc, Dummy, cells: TRect;
  l1, l2, t, h: integer;
begin
  Data := TMergeCell(Mergeds[Index]);
  cells := Data.Rc;
  l1 := GetColCoord(Data.Rc.Left);
  l2 := GetColCoord(Data.Rc.Right + 1);
  t := FDefRowHeight * Data.Rc.Top;
  h := FDefRowHeight * (Data.Rc.Bottom - Data.Rc.Top + 1);
  Rc := Rect(l1 - 1, t - 1, l2, t + h);
  OffsetRect(Rc, -FHorzOffset + FixedWidth, -FVertOffset + FixedHeight);
  R := Rc;

  if IntersectRect(Dummy, Rc, CellBox) then
  begin
    with Canvas do
    begin
      Font.Assign(FMergeCellFont);
      if not FEnabled then
        Font.Color := FGridColor;
      Pen.Color := FGridColor;

      if (cells.Left <= FCol) and (cells.Right >= FCol) and
        (cells.top <= FRow) and (cells.Bottom >= FRow) then
      begin
        Brush.Color := clHighLight;
        Font.Color := clHighlightText;
      end
      else
      begin
        Brush.Color := FMergeCellColor;
      end;

      if FShowGrid then
        Rectangle(Rc)
      else
        FillRect(Rc);

      if (cells.Left <= FCol) and (cells.Right >= FCol) and
        (cells.top <= FRow) and (cells.Bottom >= FRow) then
      begin
        InflateRect(Rc, -1, -1);
        DrawFocusRect(Rc);
        InflateRect(Rc, 1, 1);
      end;

      Brush.Style := bsClear;
      InflateRect(Rc, -4, -2);
      DrawString(Canvas, Data.Caption, Rc, Data.HorzAlign, Data.VertAlign, False);
    end;
  end;
end;

function TNiceGrid.GetHeaderInfo: TList;
begin
  Result := FHeaderInfos;
end;

function TNiceGrid.GetMergedCellsData: TList;
begin
  Result := Mergeds;
end;

procedure TNiceGrid.SetEnabled(const Value: boolean);
begin
  if (FEnabled <> Value) then
  begin
    FEnabled := Value;
    Invalidate;
  end;
end;

procedure TNiceGrid.MouseToCell(X, Y: integer; var ACol, ARow: longint);
var
  tmp: TPoint;
begin
  tmp := GetCellAtPos(X, Y);
  ACol := tmp.X;
  ARow := tmp.Y;
end;

function TNiceGrid.RowIsEmpty(ARow: integer): boolean;
var
  i: integer;
begin
  if ARow < 0 then
    Exit;
  if ARow >= RowCount then
    Exit;

  Result := True;
  for i := 0 to (ColCount - 1) do
  begin
    if FColumns[i].ControlType = ctCheckBox then
      continue;
    if Cells[i, ARow] <> '' then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

procedure TNiceGrid.SetPopupShow(val: boolean);
var
  i: integer;
  it: TMenuItem;
begin
  FPopupShow := val;
  if FPopupShow then
  begin
    FPopupMenu := TPopupMenu.Create(self);
    FPopupMenu.AutoPopup := False;
    for i := 0 to ColCount - 1 do
    begin
      if not Columns[i].FAllowShow then
        continue;
      it := TMenuItem.Create(FpopupMenu);
      it.Caption := Columns[i].Title;
      it.Name := Columns[i].Name;
      it.Checked := Columns[i].Visible;
      it.OnClick := MenuClick;
      FpopupMenu.Items.Add(it);
    end;
  end
  else
  begin
    FPopupMenu.Free;
    FPopupMenu := nil;
  end;
  RenderHeader;
end;

procedure TNiceGrid.MenuClick(Sender: TObject);
var
  i: integer;
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  for i := 0 to ColCount - 1 do
  begin
    if Columns[i].Name = TMenuItem(Sender).Name then
    begin
      Columns[i].Visible := TMenuItem(Sender).Checked;
      Exit;
    end;
  end;
end;

procedure TNiceGrid.SetGridStyle(Value: TGridStyle);
begin
  if FGridStyle = Value then
    Exit;
  FGridStyle := Value;
  Invalidate;
end;

{ TNiceColumn }

constructor TNiceColumn.Create(Collection: TCollection);
begin
  FStrings := TStringList.Create;
  FFont := TFont.Create;
  FHorzAlign := haLeft;
  FVertAlign := vaCenter;
  FVisible := True;
  FCanResize := True;
  FReadOnly := False;
  FTag := 0;
  FTag2 := 0;
  FDecimals := 2;

  with TNiceColumns(Collection).Grid do
  begin
    Self.FFont.Assign(Font);
    Self.FWidth := DefColWidth;
    Self.FColor := Color;
  end;
  FFont.OnChange := FontChange;

  FComboBoxOptions := TComboBoxOptions.Create(self);
  FNumericOptions := TNumericOptions.Create;

  inherited Create(Collection);

  FName := 'Column' + IntToStr(Index);
  FTitle := FName;
  FAllowShow := True;
  FControlType := ctEdit;
end;

destructor TNiceColumn.Destroy;
begin
  inherited Destroy;
  FFont.Free;
  FStrings.Free;
end;

procedure TNiceColumn.Assign(Source: TPersistent);
begin
  if (Source is TNiceColumn) then
  begin
    Title := TNiceColumn(Source).Title;
    Footer := TNiceColumn(Source).Footer;
    Width := TNiceColumn(Source).Width;
    Font := TNiceColumn(Source).Font;
    Color := TNiceColumn(Source).Color;
    HorzAlign := TNiceColumn(Source).HorzAlign;
    VertAlign := TNiceColumn(Source).VertAlign;
    Visible := TNiceColumn(Source).Visible;
    Tag := TNiceColumn(Source).Tag;
    Tag2 := TNiceColumn(Source).Tag2;
    Hint := TNiceColumn(Source).Hint;
    CanResize := TNiceColumn(Source).CanResize;
    ReadOnly := TNiceColumn(Source).ReadOnly;
    Strings.Assign(TNiceColumn(Source).Strings);
    Changed(False);
  end;
end;

procedure TNiceColumn.SetColor(Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    Changed(False);
  end;
end;

procedure TNiceColumn.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  Changed(False);
end;

procedure TNiceColumn.SetHorzAlign(Value: THorzAlign);
begin
  if (FHorzAlign <> Value) then
  begin
    FHorzAlign := Value;
    Changed(False);
  end;
end;

procedure TNiceColumn.SetName(Value: string);
begin
  if (FName <> Value) then
  begin
    FName := Value;
    Changed(True);
  end;
end;


procedure TNiceColumn.SetTitle(Value: string);
begin
  if (FTitle <> Value) then
  begin
    FTitle := Value;
    Changed(True);
  end;
end;

procedure TNiceColumn.SetFooter(const Value: string);
begin
  if (FFooter <> Value) then
  begin
    FFooter := Value;
    Changed(False);
  end;
end;

procedure TNiceColumn.SetVertAlign(Value: TVertAlign);
begin
  if (FVertAlign <> Value) then
  begin
    FVertAlign := Value;
    Changed(False);
  end;
end;

procedure TNiceColumn.SetWidth(Value: integer);
begin
  if (FWidth <> Value) then
  begin
    FWidth := Value;
    Changed(True);
  end;
end;

procedure TNiceColumn.SetVisible(Value: boolean);
begin
  if (FVisible <> Value) then
  begin
    FVisible := Value;
    TNiceColumns(Collection).FGrid.ForcedColumn := Index;
    Changed(True);
  end;
end;

procedure TNiceColumn.SetStrings(Value: TStrings);
begin
  FStrings.Assign(Value);
  Changed(False);
end;

procedure TNiceColumn.FontChange(Sender: TObject);
begin
  Changed(False);
end;

function TNiceColumn.IsFontStored: boolean;
begin
  Result := True;
  with TNiceColumns(Collection).FGrid.Font do
  begin
    if (Charset = FFont.Charset) and (Color = FFont.Color) and
      (Height = FFont.Height) and (Name = FFont.Name) and
      (Pitch = FFont.Pitch) and (PixelsPerInch = FFont.PixelsPerInch) and
      (Size = FFont.Size) and (Style = FFont.Style) then
      Result := False;
  end;
end;

function TNiceColumn.GetGrid: TNiceGrid;
begin
  Result := TNiceColumns(Collection).FGrid;
end;

function TNiceColumn.GetDisplayName: string;
begin
  if (FTitle <> '') then
    Result := FTitle
  else
    Result := 'Column ' + IntToStr(Index);
end;

procedure TNiceColumn.SetControlType(Value: TngControlTypes);
begin
  if FControlType = Value then
    Exit;
  FControlType := Value;
  //DoRefreshEvent;
end;

function TNiceColumn.GetControlType: TngControlTypes;
begin
  Result := FControlType;
end;

procedure TNiceColumn.SetDateFormat(Value: integer);
begin
  if Value = FDateFormat then
    Exit;
  FDateFormat := Value;
  //DoRefreshEvent;
end;

procedure TNiceColumn.SetTimeFormat(Value: integer);
begin
  if Value = FTimeFormat then
    Exit;
  FTimeFormat := Value;
  //DoRefreshEvent;
end;

procedure TNiceColumn.SetFormatText(Value: TngFormatTextType);
begin
  if Value = FFormatText then
    Exit;
  FFormatText := Value;
  //DoRefreshEvent;
end;

procedure TNiceColumn.SetDecimals(Value: integer);
begin
  if Value = FDecimals then
    Exit;
  FDecimals := Value;
  //DoRefreshEvent;
end;

procedure TNiceColumn.SetPrefix(Value: string);
begin
  if Value = FPrefix then
    Exit;
  FPrefix := Value;
  //DoRefreshEvent;
end;

procedure TNiceColumn.SetThousands(Value: boolean);
begin
  if Value = FThousands then
    Exit;
  FThousands := Value;
  //DoRefreshEvent;
end;

procedure TNiceColumn.SetComboBoxOptions(val: TComboBoxOptions);
begin
  FComboBoxOptions := val;
end;

function TNiceColumn.GetComboBoxOptions: TComboBoxOptions;
begin
  Result := FComboBoxOptions;
end;

procedure TNiceColumn.SetNumericOptions(val: TNumericOptions);
begin
  FNumericOptions := val;
end;

function TNiceColumn.GetNumericOptions: TNumericOptions;
begin
  Result := FNumericOptions
end;

procedure TNiceColumn.SetMaxLenght(Value: integer);
begin
  FMaxLenght := Value;
end;

procedure TNiceColumn.SetShowZero(Value: boolean);
begin
  FShowZero := Value;
end;

procedure TNiceColumn.SetWordBreak(Value: boolean);
begin
  FWordBreak := Value;
end;

{function TNiceColumn.ShouldStoreDateFormatting : Boolean;
begin
  Result := FFormatType = ftDateTime;
end;}

procedure TNiceColumn.SetAllowShow(Val: boolean);
begin
  FAllowShow := Val;
end;

{ TNiceColumns }

constructor TNiceColumns.Create(AGrid: TNiceGrid);
begin
  inherited Create(TNiceColumn);
  FGrid := AGrid;
end;

function TNiceColumns.Add: TNiceColumn;
begin
  Result := TNiceColumn(inherited Add);
end;

function TNiceColumns.GetItem(Index: integer): TNiceColumn;
begin
  Result := TNiceColumn(inherited GetItem(Index));
end;

procedure TNiceColumns.SetItem(Index: integer; Value: TNiceColumn);
begin
  inherited SetItem(Index, Value);
end;

function TNiceColumns.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

function TNiceColumns.Insert(Index: integer): TNiceColumn;
begin
  Result := AddItem(nil, Index);
end;

function TNiceColumns.AddItem(Item: TNiceColumn; Index: integer): TNiceColumn;
begin
  if (Item = nil) then
    Result := FGrid.CreateColumn
  else
  begin
    Result := Item;
    if Assigned(Item) then
    begin
      Result.Collection := Self;
      if (Index < 0) then
        Index := Count - 1;
      Result.Index := Index;
    end;
  end;
end;

procedure TNiceColumns.Update(Item: TCollectionItem);
begin
  if (Item <> nil) then
    FGrid.UpdateColumn(Item.Index)
  else
    FGrid.UpdateColumns;
end;

{ TNiceRow }
constructor TNiceRow.Create(Collection: TCollection);
begin
  FVisible := True;
  FCanResize := True;
  FNodeIndex := 0;
  FImageIndex := -1;
  FObject := nil;
  FParent := Parent;
  FRows := TObjectList.Create;

  with TNiceRows(Collection).Grid do
  begin
    Self.FHeight := DefRowHeight;
  end;
  inherited Create(Collection);
end;

destructor TNiceRow.Destroy;
begin
  FNodeIndex := 0;
  FParent := nil;
  FRows.Destroy;
  inherited Destroy;
end;

function TNiceRow.GetGrid: TNiceGrid;
begin
  Result := TNiceRows(Collection).FGrid;
end;

procedure TNiceRow.SetHeight(Value: integer);
begin
  if (FHeight <> Value) then
  begin
    FHeight := Value;
    Changed(True);
  end;
end;

function TNiceRow.GetExternalObject: TObject;
begin
  Result := FObject;
end;

function TNiceRow.GetParent: TObject;
begin
  Result := FParent;
end;

function TNiceRow.GetRows: TObjectList;
begin
  Result := FRows;
end;

procedure TNiceRow.SetVisible(Value: boolean);
begin
  if (FVisible <> Value) then
  begin
    FVisible := Value;
    //TNiceRows(Collection).FGrid.ForcedRow := Index;
    Changed(True);
  end;
end;

procedure TNiceRow.SetNodeIndex(Value: integer);
begin
  if FNodeIndex <> Value then
  begin
    FNodeIndex := Value;
    Changed(True);
  end;
end;

procedure TNiceRow.SetImageIndex(Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(True);
  end;
end;

procedure TNiceRow.SetExternalObject(Value: TObject);
begin
  if FObject <> Value then FObject := Value;
end;

procedure TNiceRow.SetParent(Value: TObject);
begin
  if FParent <> Value then FParent := Value;
end;

procedure TNiceRow.SetRows(Value: TObjectList);
begin
  if FRows <> Value then FRows := Value;
end;

procedure TNiceRow.Assign(Source: TPersistent);
begin
  if (Source is TNiceRow) then
  begin
    Height := TNiceRow(Source).Height;
    Visible := TNiceRow(Source).Visible;
    CanResize := TNiceRow(Source).CanResize;
    Changed(False);
  end;
end;

function TNiceRow.IsEmpty: boolean;
var
  x: integer;
begin
  Result := True;
  for x := 0 to Grid.ColCount - 1 do
    if Grid.Cells[x, Index] <> '' then
    begin
      Result := False;
      break;
    end;
end;

{ TNiceRows }

constructor TNiceRows.Create(AGrid: TNiceGrid);
begin
  inherited Create(TNiceRow);
  FGrid := AGrid;
end;

function TNiceRows.Add: TNiceRow;
begin
  Result := TNiceRow(inherited Add);
end;

function TNiceRows.GetItem(Index: integer): TNiceRow;
begin
  Result := TNiceRow(inherited GetItem(Index));
end;

procedure TNiceRows.SetItem(Index: integer; Value: TNiceRow);
begin
  inherited SetItem(Index, Value);
end;

function TNiceRows.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

function TNiceRows.Insert(Index: integer): TNiceRow;
begin
  Result := AddItem(nil, Index);
  Result.Index := Index;
end;

function TNiceRows.AddItem(Item: TNiceRow; Index: integer): TNiceRow;
begin
  if (Item = nil) then
    Result := TNiceRow.Create(self)
  else
  begin
    Result := Item;
    if Assigned(Item) then
    begin
      Result.Collection := Self;
      if (Index < 0) then
        Index := Count - 1;
      Result.Index := Index;
    end;
  end;
end;

procedure TNiceRows.Update(Item: TCollectionItem);
begin
  if (Item <> nil) then
    FGrid.UpdateColumn(Item.Index)
  else
    FGrid.UpdateColumns;
end;

{ TNiceInplace}

constructor TNiceInplace.Create(Grid: TNiceGrid);
begin
  inherited Create(FGrid);
  FGrid := Grid;
  FAlignment := haLeft;
  FChkFormWidth := -1;
  FChkFormHeight := -1;

  Parent := FGrid;
  ParentColor := False;
  BorderStyle := bsNone;
  Left := -200;
  Top := -200;
  Visible := False;
end;

procedure TNiceInplace.CreateParams(var Params: TCreateParams);
const
  Alignments: array [THorzAlign] of cardinal = (ES_LEFT, ES_CENTER, ES_RIGHT);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or Alignments[FAlignment];
end;

procedure TNiceInplace.SetAlignment(Value: THorzAlign);
begin
  if (FAlignment <> Value) then
  begin
    FAlignment := Value;
    RecreateWnd(self);
  end;
end;

procedure TNiceInplace.ShowEdit(X, Y: integer);
var
  Rc: TRect;
  Column: TNiceColumn;
  l, t, w, h: integer;
  aCanShow: boolean;
begin

  CellX := X;
  CellY := Y;
  Column := FGrid.FColumns[x];
  Color := FGrid.GetCellColor(X, Y);
  SetAlignment(Column.FHorzAlign);
  Text := FGrid.SafeGetCell(X, Y);
  Font.Assign(Column.FFont);
  FString := Text;

  Rc := FGrid.GetCellRect(X, Y);
  Rc := FGrid.CellRectToClient(Rc);

  if (FAlignment = haRight) then
    Rc.Right := Rc.Right + 1;
  InflateRect(Rc, -1, -1);

  t := Rc.Top;
  l := Rc.Left;
  w := Rc.Right - Rc.Left;
  h := Rc.Bottom - Rc.Top;

  if X = 0 then
  begin
    if (FGrid.Images <> nil) and (FGrid.Rows[Y].ImageIndex > -1) then
    begin
      l := l + 18;
      w := w - 18;
    end;
    l := l + 18 * FGrid.Rows[Y].NodeIndex;
    w := w - 18 * FGrid.Rows[Y].NodeIndex;
  end;

  if FGrid.Columns[CellX].HorzAlign = haRight then
    w := w - 1;

  SetBounds(l, t, w, h);
  case Column.FControlType of
    ctEdit, ctNumeric:
    begin
      WordWrap := False;
      BorderStyle := bsNone;
      ShowButton := False;
    end;

    ctComboBox, ctDate, ctLookupComboBox:
    begin
      WordWrap := False;
      BorderStyle := bsNone;
      ShowButton := True;
      OnButtonClick := ButtonClick;
    end;

    ctMemo:
    begin
      WordWrap := True;
      BorderStyle := bsSingle;
      ShowButton := False;
    end;
  end;

  //FBeforeShowEdit
  aCanShow := true;
  if Assigned(FGrid.FBeforeShowEdit) then
    FGrid.FBeforeShowEdit(self, Rect(t, l, w, h), aCanShow);
  if not aCanShow then Exit;

  SetHeight;
  Show;
  SetFocus;
  SelectAll;
  FGrid.IsEditing := True;

end;

procedure TNiceInplace.HideEdit(SaveChanges: boolean = True);
begin
  if Visible then
  begin
    if SaveChanges then
    begin
      if (FGrid.Columns[CellX].ControlType = ctNumeric) and (Text <> '') then
        FGrid.Cells[CellX, CellY] := FloatToStr(StrToFloat(Text))
      else
        FGrid.InternalSetCell(CellX, CellY, Text, True);
    end;
    Hide;
    FGrid.SetFocus;
    FGrid.IsEditing := False;
    ShowButton := False;
  end;
end;

procedure TNiceInplace.Change;
begin
  inherited;
  SetHeight;
end;

procedure TNiceInplace.SetHeight;
var
  size, textheight, lin: integer;
begin

  case FGrid.Columns[FGrid.Col].ControlType of
    ctMemo:
    begin
      textheight := FGrid.Canvas.TextHeight(Text);
      size := FGrid.DefRowHeight - textheight;
      if Lines.Count = 0 then
        lin := 1
      else
        lin := 0;
      Height := (Lines.Count + lin + 1) * FGrid.Canvas.TextHeight(Text) + size;
    end;
  end;

end;

procedure TNiceInplace.KeyDown(var Key: word; Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    case Key of
      VK_DOWN:
      begin
        case FGrid.Columns[CellX].ControlType of
          ctComboBox, ctDate, ctLookupComboBox:
          begin
            ShowPopup(True);
          end;
          else
            inherited;
        end;
      end;
    end;
  end
  else
  begin
    case Key of
      VK_ESCAPE:
      begin
        HideEdit(False);
      end;

      VK_UP, VK_DOWN:
      begin
        if not FGrid.Columns[FGrid.Col].WordBreak then
        begin
          HideEdit;
          FGrid.KeyDown(Key, Shift);
        end;
      end;

      VK_RETURN:
      begin
        HideEdit;
        FGrid.KeyDown(Key, Shift);
      end;

      VK_LEFT:
        if SelStart = 0 then
        begin
          HideEdit;
          FGrid.KeyDown(Key, Shift);
        end;

      VK_RIGHT:
        if SelStart = Length(Text) then
        begin
          HideEdit;
          FGrid.KeyDown(Key, Shift);
        end;
      else
        inherited;
    end;
  end;
end;

procedure TNiceInplace.KeyPress(var Key: char);
begin
  inherited;
  case FGrid.Columns.Items[CellX].ControlType of
    ctCheckBox, ctComboBox, ctDate, ctLookupComboBox, ctMemo:
    begin
      Exit;
    end;

    ctEdit:
    begin
      case FGrid.Columns.Items[CellX].FormatText of
        fttAsUpcase: Key := upcase(Key);
        fttAsLowered: Key := lowerCase(Key);
      end;
    end;

    ctNumeric:
    begin
      if (Key in ['.', ',']) then
        Key := DefaultFormatSettings.Decimalseparator;
      if not (Key in ['0'..'9', DefaultFormatSettings.DecimalSeparator, '+', '-', #8, #9])
      then
        Key := #0;
      if (Key = DefaultFormatSettings.DecimalSeparator) and
        (FGrid.Columns.Items[CellX].Decimals = 0) then
        Key := #0;
      if (Pos(DecimalSeparator, Text) > 0) then
      begin
        if (Key = DecimalSeparator) then
          if SelLength > 0 then
            Text := ''
          else
            Key := #0;
        if ((Length(Text) - Pos(DecimalSeparator, Text) + 1) >
          FGrid.Columns.Items[FGrid.Col].FDecimals) and (Key in ['0'..'9']) and
          (Pos(DecimalSeparator, Text) <= SelStart) then
          Key := #0;
      end;
    end;
  end;
end;

procedure TNiceInplace.WMKillFocus(var Msg: TLMKillFocus);
begin
  //if not assigned(FChkForm) then
  //  HideEdit;
end;

procedure TNiceInplace.ButtonClick(Sender: TObject);
begin
  ShowPopup(True);
end;

procedure TNiceInplace.ShowPopup(Focus: boolean);
const
  NullDate: TDateTime = 0;
var
  P, P2: TPoint;
  i, j, k: integer;
  dr: TRect;
  sbw: integer;
  s, txt: string;
  HeaderHeight: integer;
  R: TRect;
  ADate: TDateTime;
  DisplaySettings: TDisplaySettings;
begin

  case FGrid.Columns[CellX].ControlType of
    ctDate:
    begin
      DisplaySettings := [dsShowHeadings, dsShowDayNames];
      P := ControlToScreen(Point(0, Height));
      ADate := NullDate;
      if Text <> '' then
      begin
        try
          ADate := StrToDate(Text);
        finally
        end;
      end;

      if ADate = NullDate then
        ADate := SysUtils.Date;
      ShowCalendarPopup(P, ADate, DisplaySettings, CalendarPopupReturnDate, nil);
      Exit;
    end;
    ctComboBox: ;
    ctLookupComboBox:
    begin

    end;
  end;

  //  if not Assigned(FColumns) then Exit;
  //  if FColumns.Count = 0 then Exit;

  if Assigned(FGrid.FOnDropDown) then
    FGrid.FOnDropDown(Self);

  if not assigned(FChkForm) then
  begin
    FChkForm := TDropForm.CreateNew(self);
    FChkForm.Visible := False;
    FChkForm.Sizeable := True;
    FChkForm.BorderStyle := bsNone;
    FChkForm.FormStyle := fsStayOnTop;
    FChkForm.Font.Assign(Self.Font);
    FChkForm.Width := Self.Width;
    FChkForm.OnResize := GridResize;
    //FChkForm.OnClose := GridClose;
    //FChkForm.OnHide := GridHide;
  end;

  P := Point(0, 0);
  P := ClientToScreen(P);

  // Se crean al columnas (y los t�tulos si es necesario):
  if FShowGridTitleRow then // >>>>  modificar  >>>>>>>>>>>>>>>>>>>>>
  begin
    FChkForm.Grid.RowCount := 1;
    for i := 0 to FColumns.Count - 1 do
    begin
      FChkForm.Grid.ColCount := i + 1;
      FChkForm.Grid.Cells[i, 0] := FColumns[i].Title;
      FChkForm.Grid.ColWidths[i] := FColumns[i].Width;
    end;
  end;  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

{  if CheckDataSet then
  begin
    while not FDataSourceLink.DataSet.Eof do
    begin
      FChkForm.Grid.RowCount := FChkForm.Grid.RowCount + 1;
      for i := 0 to FColumns.Count - 1 do
      begin
        FChkForm.Grid.Cells[i, FChkForm.Grid.RowCount - 1] :=
          FDataSourceLink.DataSet.FieldByName(FColumns[i].ListField).AsAnsiString;
      end;
      FDataSourceLink.DataSet.Next;
    end;
  end else
  begin
    if FColumns.Count > 0 then
    begin
      for i := 0 to FColumns[0].Strings.Count - 1 do
      begin
        FChkForm.Grid.RowCount := FChkForm.Grid.RowCount + 1;
        for j := 0 to FColumns.Count - 1 do
          FChkForm.Grid.Cells[j, i + 1] := FColumns[j].Strings[i];
      end;
    end;
  end;
 }
  if FShowGridTitleRow then
  begin
    if FChkForm.Grid.RowCount < 2 then
      FChkForm.Grid.RowCount := 2;
    FChkForm.Grid.FixedRows := 1;
  end;

  FChkForm.Visible := False;
  FChkForm.Show;
  FChkForm.Top := P.y + self.Height + 1;
  FChkForm.Left := P.X;
  FChkForm.Visible := True;

  //  FChkForm.Grid.Cells[1,1] := Parent.Name;

  if FChkFormWidth = -1 then
    FChkForm.Width := 300
  else
    FChkForm.Width := FChkFormWidth;
  if FChkFormHeight = -1 then
    FChkForm.Height := 150
  else
    FChkForm.Height := FChkFormHeight;

  //  if Focus then FGrid.SetFocus;
end; //}

procedure TNiceInplace.HidePopup;
var
  List: TStringList;
  i: integer;
begin

  //PostMessage(FChkForm.Handle, WM_CLOSE, 0, 0);
  FChkForm.Close;
  List := TStringList.Create;
  for i := 0 to FChkForm.Grid.ColCount - 1 do
    List.Add(FChkForm.Grid.Cells[i, FChkForm.Grid.Row]);

  if Assigned(FGrid.FOnDropUp) then
    FGrid.FOnDropUp(Self, List);
  //if Assigned(OnChange) then OnChange(Self);

  FChkFormWidth := FChkForm.Width;
  FChkFormHeight := FChkForm.Height;

end;

function TNiceInplace.CheckDataSet: boolean;
begin
  Result := False;
  if not Assigned(FDataSourceLink) then
    Exit;
  if not Assigned(FDataSourceLink.DataSet) then
    Exit;
  //if not FDataSourceLink.DataSet.Active then Exit;
  Result := True;
end;

procedure TNiceInplace.GridResize(Sender: TObject);
begin
  FChkForm.Invalidate;
end;

procedure TNiceInplace.GridHide(Sender: TObject);
begin
  //HidePopup;
end;

procedure TNiceInplace.GridClose(Sender: TObject; var Action: TCloseAction);
begin
  //HidePopup;
end;

procedure TNiceInplace.CalendarPopupReturnDate(Sender: TObject; const ADate: TDateTime);
var
  B: boolean;
  D: TDateTime;
begin
  try
    B := True;
    D := ADate;
    //Self.Date := D;
    Text := DateToStr(D);
  except
  end;
end;

{ TNiceGridSync }

constructor TNiceGridSync.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOnDeleteRow := SyncDeleteRow;
  FOnInsertRow := SyncInsertRow;
  FOnColRowChanged := SyncColRow;
end;

procedure TNiceGridSync.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (AComponent = FGrid) and (Operation = opRemove) then
    FGrid := nil;
  inherited;
end;

procedure TNiceGridSync.SetGrid(const Value: TNiceGrid);
begin
  if (FGrid <> Value) then
  begin
    FGrid := Value;
    FGrid.Sync := Self;
    FGrid.RowCount := RowCount;
  end;
end;

procedure TNiceGridSync.SetScrollBar(AKind, AMax, APos, AMask: integer);
begin
  if (AKind = SB_VERT) and Assigned(FGrid) then
  begin
    if ((AMask and SIF_POS) <> 0) then
      FGrid.VertOffset := APos;
  end;
end;

procedure TNiceGridSync.ShowHideScrollBar(HorzVisible, VertVisible: boolean);
begin
  ShowScrollBar(Handle, SB_HORZ, True);
  ShowScrollBar(Handle, SB_VERT, False);
  EnableScrollBar(Handle, SB_HORZ, 3{ESB_DISABLE_BOTH});
end;

procedure TNiceGridSync.SyncColRow(Sender: TObject; ACol, ARow: integer);
begin
  if Assigned(FGrid) then
    FGrid.Row := ARow;
end;

procedure TNiceGridSync.SyncDeleteRow(Sender: TObject; ARow: integer);
begin
  if Assigned(FGrid) then
    FGrid.DeleteRow(ARow);
end;

procedure TNiceGridSync.SyncInsertRow(Sender: TObject; ARow: integer);
begin
  if Assigned(FGrid) then
  begin
    if (ARow = FGrid.RowCount) then
      FGrid.AddRow
    else
      FGrid.InsertRow(ARow);
  end;
end;

{ TMergeCell }

constructor TMergeCell.Create;
begin
  inherited Create;
  Font := TFont.Create;
end;

destructor TMergeCell.Destroy;
begin
  Font.Free;
  inherited Destroy;
end;

end.
