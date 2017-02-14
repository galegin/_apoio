unit uGerClassificacao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Classificacao = class;
  TGer_ClassificacaoClass = class of TGer_Classificacao;

  TGer_ClassificacaoList = class;
  TGer_ClassificacaoListClass = class of TGer_ClassificacaoList;

  TGer_Classificacao = class(TcCollectionItem)
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

  TGer_ClassificacaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Classificacao;
    procedure SetItem(Index: Integer; Value: TGer_Classificacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Classificacao;
    property Items[Index: Integer]: TGer_Classificacao read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Classificacao }

constructor TGer_Classificacao.Create;
begin

end;

destructor TGer_Classificacao.Destroy;
begin

  inherited;
end;

{ TGer_ClassificacaoList }

constructor TGer_ClassificacaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Classificacao);
end;

function TGer_ClassificacaoList.Add: TGer_Classificacao;
begin
  Result := TGer_Classificacao(inherited Add);
  Result.create;
end;

function TGer_ClassificacaoList.GetItem(Index: Integer): TGer_Classificacao;
begin
  Result := TGer_Classificacao(inherited GetItem(Index));
end;

procedure TGer_ClassificacaoList.SetItem(Index: Integer; Value: TGer_Classificacao);
begin
  inherited SetItem(Index, Value);
end;

end.