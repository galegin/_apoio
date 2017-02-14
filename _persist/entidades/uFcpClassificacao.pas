unit uFcpClassificacao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcp_Classificacao = class;
  TFcp_ClassificacaoClass = class of TFcp_Classificacao;

  TFcp_ClassificacaoList = class;
  TFcp_ClassificacaoListClass = class of TFcp_ClassificacaoList;

  TFcp_Classificacao = class(TcCollectionItem)
  private
    fCd_Tipoclass: Real;
    fCd_Class: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Classificacao: Real;
    fPr_Default: Real;
    fDs_Classificacao: String;
    fDs_Reduzida: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipoclass : Real read fCd_Tipoclass write fCd_Tipoclass;
    property Cd_Class : Real read fCd_Class write fCd_Class;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Classificacao : Real read fTp_Classificacao write fTp_Classificacao;
    property Pr_Default : Real read fPr_Default write fPr_Default;
    property Ds_Classificacao : String read fDs_Classificacao write fDs_Classificacao;
    property Ds_Reduzida : String read fDs_Reduzida write fDs_Reduzida;
  end;

  TFcp_ClassificacaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcp_Classificacao;
    procedure SetItem(Index: Integer; Value: TFcp_Classificacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcp_Classificacao;
    property Items[Index: Integer]: TFcp_Classificacao read GetItem write SetItem; default;
  end;
  
implementation

{ TFcp_Classificacao }

constructor TFcp_Classificacao.Create;
begin

end;

destructor TFcp_Classificacao.Destroy;
begin

  inherited;
end;

{ TFcp_ClassificacaoList }

constructor TFcp_ClassificacaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcp_Classificacao);
end;

function TFcp_ClassificacaoList.Add: TFcp_Classificacao;
begin
  Result := TFcp_Classificacao(inherited Add);
  Result.create;
end;

function TFcp_ClassificacaoList.GetItem(Index: Integer): TFcp_Classificacao;
begin
  Result := TFcp_Classificacao(inherited GetItem(Index));
end;

procedure TFcp_ClassificacaoList.SetItem(Index: Integer; Value: TFcp_Classificacao);
begin
  inherited SetItem(Index, Value);
end;

end.