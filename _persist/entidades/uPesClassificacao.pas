unit uPesClassificacao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Classificacao = class;
  TPes_ClassificacaoClass = class of TPes_Classificacao;

  TPes_ClassificacaoList = class;
  TPes_ClassificacaoListClass = class of TPes_ClassificacaoList;

  TPes_Classificacao = class(TcCollectionItem)
  private
    fCd_Tipoclas: Real;
    fCd_Classificacao: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Classificacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Classificacao : String read fDs_Classificacao write fDs_Classificacao;
  end;

  TPes_ClassificacaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Classificacao;
    procedure SetItem(Index: Integer; Value: TPes_Classificacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Classificacao;
    property Items[Index: Integer]: TPes_Classificacao read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Classificacao }

constructor TPes_Classificacao.Create;
begin

end;

destructor TPes_Classificacao.Destroy;
begin

  inherited;
end;

{ TPes_ClassificacaoList }

constructor TPes_ClassificacaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Classificacao);
end;

function TPes_ClassificacaoList.Add: TPes_Classificacao;
begin
  Result := TPes_Classificacao(inherited Add);
  Result.create;
end;

function TPes_ClassificacaoList.GetItem(Index: Integer): TPes_Classificacao;
begin
  Result := TPes_Classificacao(inherited GetItem(Index));
end;

procedure TPes_ClassificacaoList.SetItem(Index: Integer; Value: TPes_Classificacao);
begin
  inherited SetItem(Index, Value);
end;

end.