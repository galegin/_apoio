unit uSisCampo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TSis_Campo = class;
  TSis_CampoClass = class of TSis_Campo;

  TSis_CampoList = class;
  TSis_CampoListClass = class of TSis_CampoList;

  TSis_Campo = class(TcCollectionItem)
  private
    fCd_Campo: Real;
    fU_Version: String;
    fCd_Modelo: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Campo: String;
    fNr_Tamanho: Real;
    fIn_Tamfixo: String;
    fTp_Campo: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Campo : Real read fCd_Campo write fCd_Campo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Modelo : String read fCd_Modelo write fCd_Modelo;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Campo : String read fDs_Campo write fDs_Campo;
    property Nr_Tamanho : Real read fNr_Tamanho write fNr_Tamanho;
    property In_Tamfixo : String read fIn_Tamfixo write fIn_Tamfixo;
    property Tp_Campo : String read fTp_Campo write fTp_Campo;
  end;

  TSis_CampoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TSis_Campo;
    procedure SetItem(Index: Integer; Value: TSis_Campo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TSis_Campo;
    property Items[Index: Integer]: TSis_Campo read GetItem write SetItem; default;
  end;
  
implementation

{ TSis_Campo }

constructor TSis_Campo.Create;
begin

end;

destructor TSis_Campo.Destroy;
begin

  inherited;
end;

{ TSis_CampoList }

constructor TSis_CampoList.Create(AOwner: TPersistent);
begin
  inherited Create(TSis_Campo);
end;

function TSis_CampoList.Add: TSis_Campo;
begin
  Result := TSis_Campo(inherited Add);
  Result.create;
end;

function TSis_CampoList.GetItem(Index: Integer): TSis_Campo;
begin
  Result := TSis_Campo(inherited GetItem(Index));
end;

procedure TSis_CampoList.SetItem(Index: Integer; Value: TSis_Campo);
begin
  inherited SetItem(Index, Value);
end;

end.