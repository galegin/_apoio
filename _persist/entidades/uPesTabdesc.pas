unit uPesTabdesc;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Tabdesc = class;
  TPes_TabdescClass = class of TPes_Tabdesc;

  TPes_TabdescList = class;
  TPes_TabdescListClass = class of TPes_TabdescList;

  TPes_Tabdesc = class(TcCollectionItem)
  private
    fCd_Tabdesc: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Tabdesc: String;
    fPr_Tabdesc: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tabdesc : Real read fCd_Tabdesc write fCd_Tabdesc;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tabdesc : String read fDs_Tabdesc write fDs_Tabdesc;
    property Pr_Tabdesc : Real read fPr_Tabdesc write fPr_Tabdesc;
  end;

  TPes_TabdescList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Tabdesc;
    procedure SetItem(Index: Integer; Value: TPes_Tabdesc);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Tabdesc;
    property Items[Index: Integer]: TPes_Tabdesc read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Tabdesc }

constructor TPes_Tabdesc.Create;
begin

end;

destructor TPes_Tabdesc.Destroy;
begin

  inherited;
end;

{ TPes_TabdescList }

constructor TPes_TabdescList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Tabdesc);
end;

function TPes_TabdescList.Add: TPes_Tabdesc;
begin
  Result := TPes_Tabdesc(inherited Add);
  Result.create;
end;

function TPes_TabdescList.GetItem(Index: Integer): TPes_Tabdesc;
begin
  Result := TPes_Tabdesc(inherited GetItem(Index));
end;

procedure TPes_TabdescList.SetItem(Index: Integer; Value: TPes_Tabdesc);
begin
  inherited SetItem(Index, Value);
end;

end.