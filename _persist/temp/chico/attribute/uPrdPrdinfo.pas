unit uPrdPrdinfo;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_PRDINFO')]
  TPrd_Prdinfo = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_PRODUTO', tfKey)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('IN_PRODPROPRIA', tfNul)]
    property In_Prodpropria : String read fIn_Prodpropria write fIn_Prodpropria;
    [Campo('IN_FRACIONADO', tfNul)]
    property In_Fracionado : String read fIn_Fracionado write fIn_Fracionado;
    [Campo('IN_COFINS', tfNul)]
    property In_Cofins : String read fIn_Cofins write fIn_Cofins;
    [Campo('IN_PIS', tfNul)]
    property In_Pis : String read fIn_Pis write fIn_Pis;
    [Campo('IN_INATIVO', tfNul)]
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    [Campo('IN_PRODACABADO', tfNul)]
    property In_Prodacabado : String read fIn_Prodacabado write fIn_Prodacabado;
    [Campo('IN_MATPRIMA', tfNul)]
    property In_Matprima : String read fIn_Matprima write fIn_Matprima;
    [Campo('CD_DESCONTO', tfNul)]
    property Cd_Desconto : String read fCd_Desconto write fCd_Desconto;
    [Campo('QT_ESTOQUEMIN', tfNul)]
    property Qt_Estoquemin : String read fQt_Estoquemin write fQt_Estoquemin;
    [Campo('QT_ESTOQUEMAX', tfNul)]
    property Qt_Estoquemax : String read fQt_Estoquemax write fQt_Estoquemax;
    [Campo('DT_COMERCIOINI', tfNul)]
    property Dt_Comercioini : String read fDt_Comercioini write fDt_Comercioini;
    [Campo('DT_COMERCIOFIM', tfNul)]
    property Dt_Comerciofim : String read fDt_Comerciofim write fDt_Comerciofim;
    [Campo('QT_ESTOQUEREG', tfNul)]
    property Qt_Estoquereg : String read fQt_Estoquereg write fQt_Estoquereg;
    [Campo('IN_MATCONSUMO', tfNul)]
    property In_Matconsumo : String read fIn_Matconsumo write fIn_Matconsumo;
    [Campo('TP_LOTE', tfNul)]
    property Tp_Lote : String read fTp_Lote write fTp_Lote;
    [Campo('TP_INSPECAO', tfNul)]
    property Tp_Inspecao : String read fTp_Inspecao write fTp_Inspecao;
    [Campo('TP_SITUACAO', tfNul)]
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    [Campo('IN_PATRIMONIO', tfNul)]
    property In_Patrimonio : String read fIn_Patrimonio write fIn_Patrimonio;
    [Campo('TP_PATRIMONIO', tfNul)]
    property Tp_Patrimonio : String read fTp_Patrimonio write fTp_Patrimonio;
    [Campo('TP_PRODUTO', tfNul)]
    property Tp_Produto : String read fTp_Produto write fTp_Produto;
    [Campo('IN_SERIAL', tfNul)]
    property In_Serial : String read fIn_Serial write fIn_Serial;
    [Campo('TP_SERIAL', tfNul)]
    property Tp_Serial : String read fTp_Serial write fTp_Serial;
    [Campo('IN_EQUIPAMENTO', tfNul)]
    property In_Equipamento : String read fIn_Equipamento write fIn_Equipamento;
    [Campo('TP_EQUIPAMENTO', tfNul)]
    property Tp_Equipamento : String read fTp_Equipamento write fTp_Equipamento;
    [Campo('IN_TERCEIRO', tfNul)]
    property In_Terceiro : String read fIn_Terceiro write fIn_Terceiro;
    [Campo('TP_TERCEIRO', tfNul)]
    property Tp_Terceiro : String read fTp_Terceiro write fTp_Terceiro;
    [Campo('IN_SERVICO', tfNul)]
    property In_Servico : String read fIn_Servico write fIn_Servico;
    [Campo('TP_SERVICO', tfNul)]
    property Tp_Servico : String read fTp_Servico write fTp_Servico;
    [Campo('NR_DIASEGURANCA', tfNul)]
    property Nr_Diaseguranca : String read fNr_Diaseguranca write fNr_Diaseguranca;
    [Campo('NR_DIARESSUPRI', tfNul)]
    property Nr_Diaressupri : String read fNr_Diaressupri write fNr_Diaressupri;
    [Campo('TP_COR', tfNul)]
    property Tp_Cor : String read fTp_Cor write fTp_Cor;
    [Campo('QT_MINVENDA', tfNul)]
    property Qt_Minvenda : String read fQt_Minvenda write fQt_Minvenda;
    [Campo('QT_MAXVENDA', tfNul)]
    property Qt_Maxvenda : String read fQt_Maxvenda write fQt_Maxvenda;
    [Campo('PR_DESCMAX', tfNul)]
    property Pr_Descmax : String read fPr_Descmax write fPr_Descmax;
    [Campo('NR_PARCELAMAX', tfNul)]
    property Nr_Parcelamax : String read fNr_Parcelamax write fNr_Parcelamax;
    [Campo('IN_RETIMPOSTO', tfNul)]
    property In_Retimposto : String read fIn_Retimposto write fIn_Retimposto;
  end;

  TPrd_Prdinfos = class(TList<Prd_Prdinfo>);

implementation

{ TPrd_Prdinfo }

constructor TPrd_Prdinfo.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Prdinfo.Destroy;
begin

  inherited;
end;

end.