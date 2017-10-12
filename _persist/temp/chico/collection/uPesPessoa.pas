unit uPesPessoa;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Pessoa = class;
  TPes_PessoaClass = class of TPes_Pessoa;

  TPes_PessoaList = class;
  TPes_PessoaListClass = class of TPes_PessoaList;

  TPes_Pessoa = class(TmCollectionItem)
  private
    fCd_Pessoa: String;
    fU_Version: String;
    fTp_Pessoa: String;
    fCd_Empresacad: String;
    fCd_Operadorcad: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDt_Inclusao: String;
    fNm_Pessoa: String;
    fNr_Cpfcnpj: String;
    fIn_Contribuinte: String;
    fIn_Inativo: String;
    fIn_Privado: String;
    fCd_Coligador: String;
    fNr_Seqemail: String;
    fNr_Seqend: String;
    fNr_Seqfone: String;
    fNr_Endres: String;
    fNr_Endcob: String;
    fNr_Endcom: String;
    fNr_Endent: String;
    fNr_Endcor: String;
    fDs_Homepage: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property U_Version : String read fU_Version write SetU_Version;
    property Tp_Pessoa : String read fTp_Pessoa write SetTp_Pessoa;
    property Cd_Empresacad : String read fCd_Empresacad write SetCd_Empresacad;
    property Cd_Operadorcad : String read fCd_Operadorcad write SetCd_Operadorcad;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Dt_Inclusao : String read fDt_Inclusao write SetDt_Inclusao;
    property Nm_Pessoa : String read fNm_Pessoa write SetNm_Pessoa;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write SetNr_Cpfcnpj;
    property In_Contribuinte : String read fIn_Contribuinte write SetIn_Contribuinte;
    property In_Inativo : String read fIn_Inativo write SetIn_Inativo;
    property In_Privado : String read fIn_Privado write SetIn_Privado;
    property Cd_Coligador : String read fCd_Coligador write SetCd_Coligador;
    property Nr_Seqemail : String read fNr_Seqemail write SetNr_Seqemail;
    property Nr_Seqend : String read fNr_Seqend write SetNr_Seqend;
    property Nr_Seqfone : String read fNr_Seqfone write SetNr_Seqfone;
    property Nr_Endres : String read fNr_Endres write SetNr_Endres;
    property Nr_Endcob : String read fNr_Endcob write SetNr_Endcob;
    property Nr_Endcom : String read fNr_Endcom write SetNr_Endcom;
    property Nr_Endent : String read fNr_Endent write SetNr_Endent;
    property Nr_Endcor : String read fNr_Endcor write SetNr_Endcor;
    property Ds_Homepage : String read fDs_Homepage write SetDs_Homepage;
  end;

  TPes_PessoaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Pessoa;
    procedure SetItem(Index: Integer; Value: TPes_Pessoa);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Pessoa;
    property Items[Index: Integer]: TPes_Pessoa read GetItem write SetItem; default;
  end;

implementation

{ TPes_Pessoa }

constructor TPes_Pessoa.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Pessoa.Destroy;
begin

  inherited;
end;

{ TPes_PessoaList }

constructor TPes_PessoaList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Pessoa);
end;

function TPes_PessoaList.Add: TPes_Pessoa;
begin
  Result := TPes_Pessoa(inherited Add);
  Result.create;
end;

function TPes_PessoaList.GetItem(Index: Integer): TPes_Pessoa;
begin
  Result := TPes_Pessoa(inherited GetItem(Index));
end;

procedure TPes_PessoaList.SetItem(Index: Integer; Value: TPes_Pessoa);
begin
  inherited SetItem(Index, Value);
end;

end.