unit uObsPessoa;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TObs_Pessoa = class;
  TObs_PessoaClass = class of TObs_Pessoa;

  TObs_PessoaList = class;
  TObs_PessoaListClass = class of TObs_PessoaList;

  TObs_Pessoa = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fNr_Linha: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Manutencao: String;
    fCd_Componente: String;
    fDs_Observacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Nr_Linha : Real read fNr_Linha write fNr_Linha;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Manutencao : String read fIn_Manutencao write fIn_Manutencao;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TObs_PessoaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TObs_Pessoa;
    procedure SetItem(Index: Integer; Value: TObs_Pessoa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TObs_Pessoa;
    property Items[Index: Integer]: TObs_Pessoa read GetItem write SetItem; default;
  end;
  
implementation

{ TObs_Pessoa }

constructor TObs_Pessoa.Create;
begin

end;

destructor TObs_Pessoa.Destroy;
begin

  inherited;
end;

{ TObs_PessoaList }

constructor TObs_PessoaList.Create(AOwner: TPersistent);
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