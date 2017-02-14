unit uFisPafecf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Pafecf = class;
  TFis_PafecfClass = class of TFis_Pafecf;

  TFis_PafecfList = class;
  TFis_PafecfListClass = class of TFis_PafecfList;

  TFis_Pafecf = class(TcCollectionItem)
  private
    fCd_Laudo: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Cnpj: String;
    fNm_Razaosocial: String;
    fNm_Endereco: String;
    fNr_Endereco: Real;
    fNm_Bairro: String;
    fNr_Telefone: String;
    fNm_Contato: String;
    fNm_Aplicativo: String;
    fNm_Versao: String;
    fNm_Executavel: String;
    fDs_Codigoexe1: String;
    fDs_Codigoexe2: String;
    fDs_Codigoexe3: String;
    fDs_Cidade: String;
    fCd_Cep: Real;
    fDs_Versaopafecf: String;
    fNr_Inscmunicipal: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Laudo : String read fCd_Laudo write fCd_Laudo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Cnpj : String read fNr_Cnpj write fNr_Cnpj;
    property Nm_Razaosocial : String read fNm_Razaosocial write fNm_Razaosocial;
    property Nm_Endereco : String read fNm_Endereco write fNm_Endereco;
    property Nr_Endereco : Real read fNr_Endereco write fNr_Endereco;
    property Nm_Bairro : String read fNm_Bairro write fNm_Bairro;
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    property Nm_Contato : String read fNm_Contato write fNm_Contato;
    property Nm_Aplicativo : String read fNm_Aplicativo write fNm_Aplicativo;
    property Nm_Versao : String read fNm_Versao write fNm_Versao;
    property Nm_Executavel : String read fNm_Executavel write fNm_Executavel;
    property Ds_Codigoexe1 : String read fDs_Codigoexe1 write fDs_Codigoexe1;
    property Ds_Codigoexe2 : String read fDs_Codigoexe2 write fDs_Codigoexe2;
    property Ds_Codigoexe3 : String read fDs_Codigoexe3 write fDs_Codigoexe3;
    property Ds_Cidade : String read fDs_Cidade write fDs_Cidade;
    property Cd_Cep : Real read fCd_Cep write fCd_Cep;
    property Ds_Versaopafecf : String read fDs_Versaopafecf write fDs_Versaopafecf;
    property Nr_Inscmunicipal : String read fNr_Inscmunicipal write fNr_Inscmunicipal;
  end;

  TFis_PafecfList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Pafecf;
    procedure SetItem(Index: Integer; Value: TFis_Pafecf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Pafecf;
    property Items[Index: Integer]: TFis_Pafecf read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Pafecf }

constructor TFis_Pafecf.Create;
begin

end;

destructor TFis_Pafecf.Destroy;
begin

  inherited;
end;

{ TFis_PafecfList }

constructor TFis_PafecfList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Pafecf);
end;

function TFis_PafecfList.Add: TFis_Pafecf;
begin
  Result := TFis_Pafecf(inherited Add);
  Result.create;
end;

function TFis_PafecfList.GetItem(Index: Integer): TFis_Pafecf;
begin
  Result := TFis_Pafecf(inherited GetItem(Index));
end;

procedure TFis_PafecfList.SetItem(Index: Integer; Value: TFis_Pafecf);
begin
  inherited SetItem(Index, Value);
end;

end.