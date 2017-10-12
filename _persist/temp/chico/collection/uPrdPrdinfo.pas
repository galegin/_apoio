unit uPrdPrdinfo;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Prdinfo = class;
  TPrd_PrdinfoClass = class of TPrd_Prdinfo;

  TPrd_PrdinfoList = class;
  TPrd_PrdinfoListClass = class of TPrd_PrdinfoList;

  TPrd_Prdinfo = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Produto: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Grupoempresa: String;
    fIn_Prodpropria: String;
    fIn_Fracionado: String;
    fIn_Cofins: String;
    fIn_Pis: String;
    fIn_Inativo: String;
    fIn_Prodacabado: String;
    fIn_Matprima: String;
    fCd_Desconto: String;
    fQt_Estoquemin: String;
    fQt_Estoquemax: String;
    fDt_Comercioini: String;
    fDt_Comerciofim: String;
    fQt_Estoquereg: String;
    fIn_Matconsumo: String;
    fTp_Lote: String;
    fTp_Inspecao: String;
    fTp_Situacao: String;
    fIn_Patrimonio: String;
    fTp_Patrimonio: String;
    fTp_Produto: String;
    fIn_Serial: String;
    fTp_Serial: String;
    fIn_Equipamento: String;
    fTp_Equipamento: String;
    fIn_Terceiro: String;
    fTp_Terceiro: String;
    fIn_Servico: String;
    fTp_Servico: String;
    fNr_Diaseguranca: String;
    fNr_Diaressupri: String;
    fTp_Cor: String;
    fQt_Minvenda: String;
    fQt_Maxvenda: String;
    fPr_Descmax: String;
    fNr_Parcelamax: String;
    fIn_Retimposto: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property In_Prodpropria : String read fIn_Prodpropria write SetIn_Prodpropria;
    property In_Fracionado : String read fIn_Fracionado write SetIn_Fracionado;
    property In_Cofins : String read fIn_Cofins write SetIn_Cofins;
    property In_Pis : String read fIn_Pis write SetIn_Pis;
    property In_Inativo : String read fIn_Inativo write SetIn_Inativo;
    property In_Prodacabado : String read fIn_Prodacabado write SetIn_Prodacabado;
    property In_Matprima : String read fIn_Matprima write SetIn_Matprima;
    property Cd_Desconto : String read fCd_Desconto write SetCd_Desconto;
    property Qt_Estoquemin : String read fQt_Estoquemin write SetQt_Estoquemin;
    property Qt_Estoquemax : String read fQt_Estoquemax write SetQt_Estoquemax;
    property Dt_Comercioini : String read fDt_Comercioini write SetDt_Comercioini;
    property Dt_Comerciofim : String read fDt_Comerciofim write SetDt_Comerciofim;
    property Qt_Estoquereg : String read fQt_Estoquereg write SetQt_Estoquereg;
    property In_Matconsumo : String read fIn_Matconsumo write SetIn_Matconsumo;
    property Tp_Lote : String read fTp_Lote write SetTp_Lote;
    property Tp_Inspecao : String read fTp_Inspecao write SetTp_Inspecao;
    property Tp_Situacao : String read fTp_Situacao write SetTp_Situacao;
    property In_Patrimonio : String read fIn_Patrimonio write SetIn_Patrimonio;
    property Tp_Patrimonio : String read fTp_Patrimonio write SetTp_Patrimonio;
    property Tp_Produto : String read fTp_Produto write SetTp_Produto;
    property In_Serial : String read fIn_Serial write SetIn_Serial;
    property Tp_Serial : String read fTp_Serial write SetTp_Serial;
    property In_Equipamento : String read fIn_Equipamento write SetIn_Equipamento;
    property Tp_Equipamento : String read fTp_Equipamento write SetTp_Equipamento;
    property In_Terceiro : String read fIn_Terceiro write SetIn_Terceiro;
    property Tp_Terceiro : String read fTp_Terceiro write SetTp_Terceiro;
    property In_Servico : String read fIn_Servico write SetIn_Servico;
    property Tp_Servico : String read fTp_Servico write SetTp_Servico;
    property Nr_Diaseguranca : String read fNr_Diaseguranca write SetNr_Diaseguranca;
    property Nr_Diaressupri : String read fNr_Diaressupri write SetNr_Diaressupri;
    property Tp_Cor : String read fTp_Cor write SetTp_Cor;
    property Qt_Minvenda : String read fQt_Minvenda write SetQt_Minvenda;
    property Qt_Maxvenda : String read fQt_Maxvenda write SetQt_Maxvenda;
    property Pr_Descmax : String read fPr_Descmax write SetPr_Descmax;
    property Nr_Parcelamax : String read fNr_Parcelamax write SetNr_Parcelamax;
    property In_Retimposto : String read fIn_Retimposto write SetIn_Retimposto;
  end;

  TPrd_PrdinfoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdinfo;
    procedure SetItem(Index: Integer; Value: TPrd_Prdinfo);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Prdinfo;
    property Items[Index: Integer]: TPrd_Prdinfo read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Prdinfo }

constructor TPrd_Prdinfo.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Prdinfo.Destroy;
begin

  inherited;
end;

{ TPrd_PrdinfoList }

constructor TPrd_PrdinfoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Prdinfo);
end;

function TPrd_PrdinfoList.Add: TPrd_Prdinfo;
begin
  Result := TPrd_Prdinfo(inherited Add);
  Result.create;
end;

function TPrd_PrdinfoList.GetItem(Index: Integer): TPrd_Prdinfo;
begin
  Result := TPrd_Prdinfo(inherited GetItem(Index));
end;

procedure TPrd_PrdinfoList.SetItem(Index: Integer; Value: TPrd_Prdinfo);
begin
  inherited SetItem(Index, Value);
end;

end.