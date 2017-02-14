unit uTefCampo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Campo = class;
  TTef_CampoClass = class of TTef_Campo;

  TTef_CampoList = class;
  TTef_CampoListClass = class of TTef_CampoList;

  TTef_Campo = class(TcCollectionItem)
  private
    fNr_Campo: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Campo: String;
    fTp_Campo: Real;
    fNm_Item: String;
    fVl_Padrao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nr_Campo : String read fNr_Campo write fNr_Campo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Campo : String read fDs_Campo write fDs_Campo;
    property Tp_Campo : Real read fTp_Campo write fTp_Campo;
    property Nm_Item : String read fNm_Item write fNm_Item;
    property Vl_Padrao : String read fVl_Padrao write fVl_Padrao;
  end;

  TTef_CampoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Campo;
    procedure SetItem(Index: Integer; Value: TTef_Campo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Campo;
    property Items[Index: Integer]: TTef_Campo read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Campo }

constructor TTef_Campo.Create;
begin

end;

destructor TTef_Campo.Destroy;
begin

  inherited;
end;

{ TTef_CampoList }

constructor TTef_CampoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Campo);
end;

function TTef_CampoList.Add: TTef_Campo;
begin
  Result := TTef_Campo(inherited Add);
  Result.create;
end;

function TTef_CampoList.GetItem(Index: Integer): TTef_Campo;
begin
  Result := TTef_Campo(inherited GetItem(Index));
end;

procedure TTef_CampoList.SetItem(Index: Integer; Value: TTef_Campo);
begin
  inherited SetItem(Index, Value);
end;

end.