unit uOperacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TOperacao = class;
  TOperacaoClass = class of TOperacao;

  TOperacaoList = class;
  TOperacaoListClass = class of TOperacaoList;

  TOperacao = class(TmCollectionItem)
  private
    fId_Operacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDs_Operacao: String;
    fTp_Modelonf: Integer;
    fTp_Modalidade: Integer;
    fTp_Operacao: Integer;
    fCd_Serie: String;
    fCd_Cfop: Integer;
    fId_Regrafiscal: Integer;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Operacao : String read fId_Operacao write SetId_Operacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Operacao : String read fDs_Operacao write SetDs_Operacao;
    property Tp_Modelonf : Integer read fTp_Modelonf write SetTp_Modelonf;
    property Tp_Modalidade : Integer read fTp_Modalidade write SetTp_Modalidade;
    property Tp_Operacao : Integer read fTp_Operacao write SetTp_Operacao;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Cd_Cfop : Integer read fCd_Cfop write SetCd_Cfop;
    property Id_Regrafiscal : Integer read fId_Regrafiscal write SetId_Regrafiscal;
  end;

  TOperacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TOperacao;
    procedure SetItem(Index: Integer; Value: TOperacao);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TOperacao;
    property Items[Index: Integer]: TOperacao read GetItem write SetItem; default;
  end;

implementation

{ TOperacao }

constructor TOperacao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TOperacao.Destroy;
begin

  inherited;
end;

{ TOperacaoList }

constructor TOperacaoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TOperacao);
end;

function TOperacaoList.Add: TOperacao;
begin
  Result := TOperacao(inherited Add);
  Result.create;
end;

function TOperacaoList.GetItem(Index: Integer): TOperacao;
begin
  Result := TOperacao(inherited GetItem(Index));
end;

procedure TOperacaoList.SetItem(Index: Integer; Value: TOperacao);
begin
  inherited SetItem(Index, Value);
end;

end.