unit uPesPesfisica;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Pesfisica = class;
  TPes_PesfisicaClass = class of TPes_Pesfisica;

  TPes_PesfisicaList = class;
  TPes_PesfisicaListClass = class of TPes_PesfisicaList;

  TPes_Pesfisica = class(TmCollectionItem)
  private
    fCd_Pessoa: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Inativo: String;
    fTp_Estcivil: String;
    fTp_Sexo: String;
    fCd_Seriectps: String;
    fDs_Orgexpedidor: String;
    fNr_Ctps: String;
    fNr_Cpf: String;
    fNr_Rg: String;
    fVl_Rendamensal: String;
    fDs_Cargo: String;
    fDt_Admissao: String;
    fDt_Nascimento: String;
    fDs_Localtrab: String;
    fDs_Localnasc: String;
    fDs_Nacionalidade: String;
    fNm_Mae: String;
    fNm_Pai: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Inativo : String read fIn_Inativo write SetIn_Inativo;
    property Tp_Estcivil : String read fTp_Estcivil write SetTp_Estcivil;
    property Tp_Sexo : String read fTp_Sexo write SetTp_Sexo;
    property Cd_Seriectps : String read fCd_Seriectps write SetCd_Seriectps;
    property Ds_Orgexpedidor : String read fDs_Orgexpedidor write SetDs_Orgexpedidor;
    property Nr_Ctps : String read fNr_Ctps write SetNr_Ctps;
    property Nr_Cpf : String read fNr_Cpf write SetNr_Cpf;
    property Nr_Rg : String read fNr_Rg write SetNr_Rg;
    property Vl_Rendamensal : String read fVl_Rendamensal write SetVl_Rendamensal;
    property Ds_Cargo : String read fDs_Cargo write SetDs_Cargo;
    property Dt_Admissao : String read fDt_Admissao write SetDt_Admissao;
    property Dt_Nascimento : String read fDt_Nascimento write SetDt_Nascimento;
    property Ds_Localtrab : String read fDs_Localtrab write SetDs_Localtrab;
    property Ds_Localnasc : String read fDs_Localnasc write SetDs_Localnasc;
    property Ds_Nacionalidade : String read fDs_Nacionalidade write SetDs_Nacionalidade;
    property Nm_Mae : String read fNm_Mae write SetNm_Mae;
    property Nm_Pai : String read fNm_Pai write SetNm_Pai;
  end;

  TPes_PesfisicaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Pesfisica;
    procedure SetItem(Index: Integer; Value: TPes_Pesfisica);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Pesfisica;
    property Items[Index: Integer]: TPes_Pesfisica read GetItem write SetItem; default;
  end;

implementation

{ TPes_Pesfisica }

constructor TPes_Pesfisica.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Pesfisica.Destroy;
begin

  inherited;
end;

{ TPes_PesfisicaList }

constructor TPes_PesfisicaList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Pesfisica);
end;

function TPes_PesfisicaList.Add: TPes_Pesfisica;
begin
  Result := TPes_Pesfisica(inherited Add);
  Result.create;
end;

function TPes_PesfisicaList.GetItem(Index: Integer): TPes_Pesfisica;
begin
  Result := TPes_Pesfisica(inherited GetItem(Index));
end;

procedure TPes_PesfisicaList.SetItem(Index: Integer; Value: TPes_Pesfisica);
begin
  inherited SetItem(Index, Value);
end;

end.