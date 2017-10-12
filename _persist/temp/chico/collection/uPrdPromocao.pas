unit uPrdPromocao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Promocao = class;
  TPrd_PromocaoClass = class of TPrd_Promocao;

  TPrd_PromocaoList = class;
  TPrd_PromocaoListClass = class of TPrd_PromocaoList;

  TPrd_Promocao = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Promocao: String;
    fU_Version: String;
    fDs_Promocao: String;
    fTp_Situacao: String;
    fTp_Valor: String;
    fCd_Valor: String;
    fDt_Inicio: String;
    fDt_Final: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Prazomedio: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Promocao : String read fCd_Promocao write SetCd_Promocao;
    property U_Version : String read fU_Version write SetU_Version;
    property Ds_Promocao : String read fDs_Promocao write SetDs_Promocao;
    property Tp_Situacao : String read fTp_Situacao write SetTp_Situacao;
    property Tp_Valor : String read fTp_Valor write SetTp_Valor;
    property Cd_Valor : String read fCd_Valor write SetCd_Valor;
    property Dt_Inicio : String read fDt_Inicio write SetDt_Inicio;
    property Dt_Final : String read fDt_Final write SetDt_Final;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nr_Prazomedio : String read fNr_Prazomedio write SetNr_Prazomedio;
  end;

  TPrd_PromocaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Promocao;
    procedure SetItem(Index: Integer; Value: TPrd_Promocao);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Promocao;
    property Items[Index: Integer]: TPrd_Promocao read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Promocao }

constructor TPrd_Promocao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Promocao.Destroy;
begin

  inherited;
end;

{ TPrd_PromocaoList }

constructor TPrd_PromocaoList.Create(AOwner: TPersistentCollection);
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