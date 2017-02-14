unit uPesPessoa;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Pessoa = class;
  TPes_PessoaClass = class of TPes_Pessoa;

  TPes_PessoaList = class;
  TPes_PessoaListClass = class of TPes_PessoaList;

  TPes_Pessoa = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fU_Version: String;
    fTp_Pessoa: String;
    fCd_Empresacad: Real;
    fCd_Operadorcad: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDt_Inclusao: TDateTime;
    fNm_Pessoa: String;
    fNr_Cpfcnpj: String;
    fIn_Contribuinte: String;
    fIn_Inativo: String;
    fIn_Privado: String;
    fCd_Coligador: Real;
    fNr_Seqemail: Real;
    fNr_Seqend: Real;
    fNr_Seqfone: Real;
    fNr_Endres: Real;
    fNr_Endcob: Real;
    fNr_Endcom: Real;
    fNr_Endent: Real;
    fNr_Endcor: Real;
    fDs_Homepage: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Pessoa : String read fTp_Pessoa write fTp_Pessoa;
    property Cd_Empresacad : Real read fCd_Empresacad write fCd_Empresacad;
    property Cd_Operadorcad : Real read fCd_Operadorcad write fCd_Operadorcad;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Dt_Inclusao : TDateTime read fDt_Inclusao write fDt_Inclusao;
    property Nm_Pessoa : String read fNm_Pessoa write fNm_Pessoa;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    property In_Contribuinte : String read fIn_Contribuinte write fIn_Contribuinte;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property In_Privado : String read fIn_Privado write fIn_Privado;
    property Cd_Coligador : Real read fCd_Coligador write fCd_Coligador;
    property Nr_Seqemail : Real read fNr_Seqemail write fNr_Seqemail;
    property Nr_Seqend : Real read fNr_Seqend write fNr_Seqend;
    property Nr_Seqfone : Real read fNr_Seqfone write fNr_Seqfone;
    property Nr_Endres : Real read fNr_Endres write fNr_Endres;
    property Nr_Endcob : Real read fNr_Endcob write fNr_Endcob;
    property Nr_Endcom : Real read fNr_Endcom write fNr_Endcom;
    property Nr_Endent : Real read fNr_Endent write fNr_Endent;
    property Nr_Endcor : Real read fNr_Endcor write fNr_Endcor;
    property Ds_Homepage : String read fDs_Homepage write fDs_Homepage;
  end;

  TPes_PessoaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Pessoa;
    procedure SetItem(Index: Integer; Value: TPes_Pessoa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Pessoa;
    property Items[Index: Integer]: TPes_Pessoa read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Pessoa }

constructor TPes_Pessoa.Create;
begin

end;

destructor TPes_Pessoa.Destroy;
begin

  inherited;
end;

{ TPes_PessoaList }

constructor TPes_PessoaList.Create(AOwner: TPersistent);
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