unit uPesContato;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Contato = class;
  TPes_ContatoClass = class of TPes_Contato;

  TPes_ContatoList = class;
  TPes_ContatoListClass = class of TPes_ContatoList;

  TPes_Contato = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fNr_Sequencia: Real;
    fU_Version: String;
    fCd_Tipocontato: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Contato: String;
    fNr_Telefone: String;
    fDs_Funcao: String;
    fDs_Email: String;
    fDt_Nascimento: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Tipocontato : Real read fCd_Tipocontato write fCd_Tipocontato;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Contato : String read fNm_Contato write fNm_Contato;
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    property Ds_Funcao : String read fDs_Funcao write fDs_Funcao;
    property Ds_Email : String read fDs_Email write fDs_Email;
    property Dt_Nascimento : TDateTime read fDt_Nascimento write fDt_Nascimento;
  end;

  TPes_ContatoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Contato;
    procedure SetItem(Index: Integer; Value: TPes_Contato);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Contato;
    property Items[Index: Integer]: TPes_Contato read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Contato }

constructor TPes_Contato.Create;
begin

end;

destructor TPes_Contato.Destroy;
begin

  inherited;
end;

{ TPes_ContatoList }

constructor TPes_ContatoList.Create(AOwner: TPersistent);
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