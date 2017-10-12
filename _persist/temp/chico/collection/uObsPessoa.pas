unit uObsPessoa;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TObs_Pessoa = class;
  TObs_PessoaClass = class of TObs_Pessoa;

  TObs_PessoaList = class;
  TObs_PessoaListClass = class of TObs_PessoaList;

  TObs_Pessoa = class(TmCollectionItem)
  private
    fCd_Pessoa: String;
    fNr_Linha: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Manutencao: String;
    fCd_Componente: String;
    fDs_Observacao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Nr_Linha : String read fNr_Linha write SetNr_Linha;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Manutencao : String read fIn_Manutencao write SetIn_Manutencao;
    property Cd_Componente : String read fCd_Componente write SetCd_Componente;
    property Ds_Observacao : String read fDs_Observacao write SetDs_Observacao;
  end;

  TObs_PessoaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TObs_Pessoa;
    procedure SetItem(Index: Integer; Value: TObs_Pessoa);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TObs_Pessoa;
    property Items[Index: Integer]: TObs_Pessoa read GetItem write SetItem; default;
  end;

implementation

{ TObs_Pessoa }

constructor TObs_Pessoa.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TObs_Pessoa.Destroy;
begin

  inherited;
end;

{ TObs_PessoaList }

constructor TObs_PessoaList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TObs_Pessoa);
end;

function TObs_PessoaList.Add: TObs_Pessoa;
begin
  Result := TObs_Pessoa(inherited Add);
  Result.create;
end;

function TObs_PessoaList.GetItem(Index: Integer): TObs_Pessoa;
begin
  Result := TObs_Pessoa(inherited GetItem(Index));
end;

procedure TObs_PessoaList.SetItem(Index: Integer; Value: TObs_Pessoa);
begin
  inherited SetItem(Index, Value);
end;

end.