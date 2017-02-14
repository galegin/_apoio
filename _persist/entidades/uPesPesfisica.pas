unit uPesPesfisica;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Pesfisica = class;
  TPes_PesfisicaClass = class of TPes_Pesfisica;

  TPes_PesfisicaList = class;
  TPes_PesfisicaListClass = class of TPes_PesfisicaList;

  TPes_Pesfisica = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Inativo: String;
    fTp_Estcivil: Real;
    fTp_Sexo: String;
    fCd_Seriectps: Real;
    fDs_Orgexpedidor: String;
    fNr_Ctps: Real;
    fNr_Cpf: String;
    fNr_Rg: String;
    fVl_Rendamensal: Real;
    fDs_Cargo: String;
    fDt_Admissao: TDateTime;
    fDt_Nascimento: TDateTime;
    fDs_Localtrab: String;
    fDs_Localnasc: String;
    fDs_Nacionalidade: String;
    fNm_Mae: String;
    fNm_Pai: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property Tp_Estcivil : Real read fTp_Estcivil write fTp_Estcivil;
    property Tp_Sexo : String read fTp_Sexo write fTp_Sexo;
    property Cd_Seriectps : Real read fCd_Seriectps write fCd_Seriectps;
    property Ds_Orgexpedidor : String read fDs_Orgexpedidor write fDs_Orgexpedidor;
    property Nr_Ctps : Real read fNr_Ctps write fNr_Ctps;
    property Nr_Cpf : String read fNr_Cpf write fNr_Cpf;
    property Nr_Rg : String read fNr_Rg write fNr_Rg;
    property Vl_Rendamensal : Real read fVl_Rendamensal write fVl_Rendamensal;
    property Ds_Cargo : String read fDs_Cargo write fDs_Cargo;
    property Dt_Admissao : TDateTime read fDt_Admissao write fDt_Admissao;
    property Dt_Nascimento : TDateTime read fDt_Nascimento write fDt_Nascimento;
    property Ds_Localtrab : String read fDs_Localtrab write fDs_Localtrab;
    property Ds_Localnasc : String read fDs_Localnasc write fDs_Localnasc;
    property Ds_Nacionalidade : String read fDs_Nacionalidade write fDs_Nacionalidade;
    property Nm_Mae : String read fNm_Mae write fNm_Mae;
    property Nm_Pai : String read fNm_Pai write fNm_Pai;
  end;

  TPes_PesfisicaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Pesfisica;
    procedure SetItem(Index: Integer; Value: TPes_Pesfisica);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Pesfisica;
    property Items[Index: Integer]: TPes_Pesfisica read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Pesfisica }

constructor TPes_Pesfisica.Create;
begin

end;

destructor TPes_Pesfisica.Destroy;
begin

  inherited;
end;

{ TPes_PesfisicaList }

constructor TPes_PesfisicaList.Create(AOwner: TPersistent);
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