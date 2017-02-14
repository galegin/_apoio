unit uPrdPrdinfo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Prdinfo = class;
  TPrd_PrdinfoClass = class of TPrd_Prdinfo;

  TPrd_PrdinfoList = class;
  TPrd_PrdinfoListClass = class of TPrd_PrdinfoList;

  TPrd_Prdinfo = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Produto: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Grupoempresa: Real;
    fIn_Prodpropria: String;
    fIn_Fracionado: String;
    fIn_Cofins: String;
    fIn_Pis: String;
    fIn_Inativo: String;
    fIn_Prodacabado: String;
    fIn_Matprima: String;
    fCd_Desconto: String;
    fQt_Estoquemin: Real;
    fQt_Estoquemax: Real;
    fDt_Comercioini: TDateTime;
    fDt_Comerciofim: TDateTime;
    fQt_Estoquereg: Real;
    fIn_Matconsumo: String;
    fTp_Lote: Real;
    fTp_Inspecao: Real;
    fTp_Situacao: Real;
    fIn_Patrimonio: String;
    fTp_Patrimonio: Real;
    fTp_Produto: Real;
    fIn_Serial: String;
    fTp_Serial: Real;
    fIn_Equipamento: String;
    fTp_Equipamento: Real;
    fIn_Terceiro: String;
    fTp_Terceiro: Real;
    fIn_Servico: String;
    fTp_Servico: Real;
    fNr_Diaseguranca: Real;
    fNr_Diaressupri: Real;
    fTp_Cor: String;
    fQt_Minvenda: Real;
    fQt_Maxvenda: Real;
    fPr_Descmax: Real;
    fNr_Parcelamax: Real;
    fIn_Retimposto: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property In_Prodpropria : String read fIn_Prodpropria write fIn_Prodpropria;
    property In_Fracionado : String read fIn_Fracionado write fIn_Fracionado;
    property In_Cofins : String read fIn_Cofins write fIn_Cofins;
    property In_Pis : String read fIn_Pis write fIn_Pis;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property In_Prodacabado : String read fIn_Prodacabado write fIn_Prodacabado;
    property In_Matprima : String read fIn_Matprima write fIn_Matprima;
    property Cd_Desconto : String read fCd_Desconto write fCd_Desconto;
    property Qt_Estoquemin : Real read fQt_Estoquemin write fQt_Estoquemin;
    property Qt_Estoquemax : Real read fQt_Estoquemax write fQt_Estoquemax;
    property Dt_Comercioini : TDateTime read fDt_Comercioini write fDt_Comercioini;
    property Dt_Comerciofim : TDateTime read fDt_Comerciofim write fDt_Comerciofim;
    property Qt_Estoquereg : Real read fQt_Estoquereg write fQt_Estoquereg;
    property In_Matconsumo : String read fIn_Matconsumo write fIn_Matconsumo;
    property Tp_Lote : Real read fTp_Lote write fTp_Lote;
    property Tp_Inspecao : Real read fTp_Inspecao write fTp_Inspecao;
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
    property In_Patrimonio : String read fIn_Patrimonio write fIn_Patrimonio;
    property Tp_Patrimonio : Real read fTp_Patrimonio write fTp_Patrimonio;
    property Tp_Produto : Real read fTp_Produto write fTp_Produto;
    property In_Serial : String read fIn_Serial write fIn_Serial;
    property Tp_Serial : Real read fTp_Serial write fTp_Serial;
    property In_Equipamento : String read fIn_Equipamento write fIn_Equipamento;
    property Tp_Equipamento : Real read fTp_Equipamento write fTp_Equipamento;
    property In_Terceiro : String read fIn_Terceiro write fIn_Terceiro;
    property Tp_Terceiro : Real read fTp_Terceiro write fTp_Terceiro;
    property In_Servico : String read fIn_Servico write fIn_Servico;
    property Tp_Servico : Real read fTp_Servico write fTp_Servico;
    property Nr_Diaseguranca : Real read fNr_Diaseguranca write fNr_Diaseguranca;
    property Nr_Diaressupri : Real read fNr_Diaressupri write fNr_Diaressupri;
    property Tp_Cor : String read fTp_Cor write fTp_Cor;
    property Qt_Minvenda : Real read fQt_Minvenda write fQt_Minvenda;
    property Qt_Maxvenda : Real read fQt_Maxvenda write fQt_Maxvenda;
    property Pr_Descmax : Real read fPr_Descmax write fPr_Descmax;
    property Nr_Parcelamax : Real read fNr_Parcelamax write fNr_Parcelamax;
    property In_Retimposto : String read fIn_Retimposto write fIn_Retimposto;
  end;

  TPrd_PrdinfoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdinfo;
    procedure SetItem(Index: Integer; Value: TPrd_Prdinfo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Prdinfo;
    property Items[Index: Integer]: TPrd_Prdinfo read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Prdinfo }

constructor TPrd_Prdinfo.Create;
begin

end;

destructor TPrd_Prdinfo.Destroy;
begin

  inherited;
end;

{ TPrd_PrdinfoList }

constructor TPrd_PrdinfoList.Create(AOwner: TPersistent);
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