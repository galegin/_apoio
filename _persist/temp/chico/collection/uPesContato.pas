unit uPesContato;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Contato = class;
  TPes_ContatoClass = class of TPes_Contato;

  TPes_ContatoList = class;
  TPes_ContatoListClass = class of TPes_ContatoList;

  TPes_Contato = class(TmCollectionItem)
  private
    fCd_Pessoa: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Tipocontato: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Contato: String;
    fNr_Telefone: String;
    fDs_Funcao: String;
    fDs_Email: String;
    fDt_Nascimento: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Nr_Sequencia : String read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Tipocontato : String read fCd_Tipocontato write SetCd_Tipocontato;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Contato : String read fNm_Contato write SetNm_Contato;
    property Nr_Telefone : String read fNr_Telefone write SetNr_Telefone;
    property Ds_Funcao : String read fDs_Funcao write SetDs_Funcao;
    property Ds_Email : String read fDs_Email write SetDs_Email;
    property Dt_Nascimento : String read fDt_Nascimento write SetDt_Nascimento;
  end;

  TPes_ContatoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Contato;
    procedure SetItem(Index: Integer; Value: TPes_Contato);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Contato;
    property Items[Index: Integer]: TPes_Contato read GetItem write SetItem; default;
  end;

implementation

{ TPes_Contato }

constructor TPes_Contato.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Contato.Destroy;
begin

  inherited;
end;

{ TPes_ContatoList }

constructor TPes_ContatoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Contato);
end;

function TPes_ContatoList.Add: TPes_Contato;
begin
  Result := TPes_Contato(inherited Add);
  Result.create;
end;

function TPes_ContatoList.GetItem(Index: Integer): TPes_Contato;
begin
  Result := TPes_Contato(inherited GetItem(Index));
end;

procedure TPes_ContatoList.SetItem(Index: Integer; Value: TPes_Contato);
begin
  inherited SetItem(Index, Value);
end;

end.