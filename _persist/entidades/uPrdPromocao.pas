unit uPrdPromocao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Promocao = class;
  TPrd_PromocaoClass = class of TPrd_Promocao;

  TPrd_PromocaoList = class;
  TPrd_PromocaoListClass = class of TPrd_PromocaoList;

  TPrd_Promocao = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Promocao: Real;
    fU_Version: String;
    fDs_Promocao: String;
    fTp_Situacao: String;
    fTp_Valor: String;
    fCd_Valor: Real;
    fDt_Inicio: TDateTime;
    fDt_Final: TDateTime;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Prazomedio: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Promocao : Real read fCd_Promocao write fCd_Promocao;
    property U_Version : String read fU_Version write fU_Version;
    property Ds_Promocao : String read fDs_Promocao write fDs_Promocao;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    property Cd_Valor : Real read fCd_Valor write fCd_Valor;
    property Dt_Inicio : TDateTime read fDt_Inicio write fDt_Inicio;
    property Dt_Final : TDateTime read fDt_Final write fDt_Final;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Prazomedio : Real read fNr_Prazomedio write fNr_Prazomedio;
  end;

  TPrd_PromocaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Promocao;
    procedure SetItem(Index: Integer; Value: TPrd_Promocao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Promocao;
    property Items[Index: Integer]: TPrd_Promocao read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Promocao }

constructor TPrd_Promocao.Create;
begin

end;

destructor TPrd_Promocao.Destroy;
begin

  inherited;
end;

{ TPrd_PromocaoList }

constructor TPrd_PromocaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Promocao);
end;

function TPrd_PromocaoList.Add: TPrd_Promocao;
begin
  Result := TPrd_Promocao(inherited Add);
  Result.create;
end;

function TPrd_PromocaoList.GetItem(Index: Integer): TPrd_Promocao;
begin
  Result := TPrd_Promocao(inherited GetItem(Index));
end;

procedure TPrd_PromocaoList.SetItem(Index: Integer; Value: TPrd_Promocao);
begin
  inherited SetItem(Index, Value);
end;

end.