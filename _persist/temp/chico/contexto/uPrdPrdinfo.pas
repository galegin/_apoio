unit uPrdPrdinfo;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Prdinfo = class(TmMapping)
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property In_Prodpropria : String read fIn_Prodpropria write fIn_Prodpropria;
    property In_Fracionado : String read fIn_Fracionado write fIn_Fracionado;
    property In_Cofins : String read fIn_Cofins write fIn_Cofins;
    property In_Pis : String read fIn_Pis write fIn_Pis;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property In_Prodacabado : String read fIn_Prodacabado write fIn_Prodacabado;
    property In_Matprima : String read fIn_Matprima write fIn_Matprima;
    property Cd_Desconto : String read fCd_Desconto write fCd_Desconto;
    property Qt_Estoquemin : String read fQt_Estoquemin write fQt_Estoquemin;
    property Qt_Estoquemax : String read fQt_Estoquemax write fQt_Estoquemax;
    property Dt_Comercioini : String read fDt_Comercioini write fDt_Comercioini;
    property Dt_Comerciofim : String read fDt_Comerciofim write fDt_Comerciofim;
    property Qt_Estoquereg : String read fQt_Estoquereg write fQt_Estoquereg;
    property In_Matconsumo : String read fIn_Matconsumo write fIn_Matconsumo;
    property Tp_Lote : String read fTp_Lote write fTp_Lote;
    property Tp_Inspecao : String read fTp_Inspecao write fTp_Inspecao;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property In_Patrimonio : String read fIn_Patrimonio write fIn_Patrimonio;
    property Tp_Patrimonio : String read fTp_Patrimonio write fTp_Patrimonio;
    property Tp_Produto : String read fTp_Produto write fTp_Produto;
    property In_Serial : String read fIn_Serial write fIn_Serial;
    property Tp_Serial : String read fTp_Serial write fTp_Serial;
    property In_Equipamento : String read fIn_Equipamento write fIn_Equipamento;
    property Tp_Equipamento : String read fTp_Equipamento write fTp_Equipamento;
    property In_Terceiro : String read fIn_Terceiro write fIn_Terceiro;
    property Tp_Terceiro : String read fTp_Terceiro write fTp_Terceiro;
    property In_Servico : String read fIn_Servico write fIn_Servico;
    property Tp_Servico : String read fTp_Servico write fTp_Servico;
    property Nr_Diaseguranca : String read fNr_Diaseguranca write fNr_Diaseguranca;
    property Nr_Diaressupri : String read fNr_Diaressupri write fNr_Diaressupri;
    property Tp_Cor : String read fTp_Cor write fTp_Cor;
    property Qt_Minvenda : String read fQt_Minvenda write fQt_Minvenda;
    property Qt_Maxvenda : String read fQt_Maxvenda write fQt_Maxvenda;
    property Pr_Descmax : String read fPr_Descmax write fPr_Descmax;
    property Nr_Parcelamax : String read fNr_Parcelamax write fNr_Parcelamax;
    property In_Retimposto : String read fIn_Retimposto write fIn_Retimposto;
  end;

  TPrd_Prdinfos = class(TList)
  public
    function Add: TPrd_Prdinfo; overload;
  end;

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

//--

function TPrd_Prdinfo.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_PRDINFO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Produto', 'CD_PRODUTO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('In_Prodpropria', 'IN_PRODPROPRIA', tfNul);
    Add('In_Fracionado', 'IN_FRACIONADO', tfNul);
    Add('In_Cofins', 'IN_COFINS', tfNul);
    Add('In_Pis', 'IN_PIS', tfNul);
    Add('In_Inativo', 'IN_INATIVO', tfNul);
    Add('In_Prodacabado', 'IN_PRODACABADO', tfNul);
    Add('In_Matprima', 'IN_MATPRIMA', tfNul);
    Add('Cd_Desconto', 'CD_DESCONTO', tfNul);
    Add('Qt_Estoquemin', 'QT_ESTOQUEMIN', tfNul);
    Add('Qt_Estoquemax', 'QT_ESTOQUEMAX', tfNul);
    Add('Dt_Comercioini', 'DT_COMERCIOINI', tfNul);
    Add('Dt_Comerciofim', 'DT_COMERCIOFIM', tfNul);
    Add('Qt_Estoquereg', 'QT_ESTOQUEREG', tfNul);
    Add('In_Matconsumo', 'IN_MATCONSUMO', tfNul);
    Add('Tp_Lote', 'TP_LOTE', tfNul);
    Add('Tp_Inspecao', 'TP_INSPECAO', tfNul);
    Add('Tp_Situacao', 'TP_SITUACAO', tfNul);
    Add('In_Patrimonio', 'IN_PATRIMONIO', tfNul);
    Add('Tp_Patrimonio', 'TP_PATRIMONIO', tfNul);
    Add('Tp_Produto', 'TP_PRODUTO', tfNul);
    Add('In_Serial', 'IN_SERIAL', tfNul);
    Add('Tp_Serial', 'TP_SERIAL', tfNul);
    Add('In_Equipamento', 'IN_EQUIPAMENTO', tfNul);
    Add('Tp_Equipamento', 'TP_EQUIPAMENTO', tfNul);
    Add('In_Terceiro', 'IN_TERCEIRO', tfNul);
    Add('Tp_Terceiro', 'TP_TERCEIRO', tfNul);
    Add('In_Servico', 'IN_SERVICO', tfNul);
    Add('Tp_Servico', 'TP_SERVICO', tfNul);
    Add('Nr_Diaseguranca', 'NR_DIASEGURANCA', tfNul);
    Add('Nr_Diaressupri', 'NR_DIARESSUPRI', tfNul);
    Add('Tp_Cor', 'TP_COR', tfNul);
    Add('Qt_Minvenda', 'QT_MINVENDA', tfNul);
    Add('Qt_Maxvenda', 'QT_MAXVENDA', tfNul);
    Add('Pr_Descmax', 'PR_DESCMAX', tfNul);
    Add('Nr_Parcelamax', 'NR_PARCELAMAX', tfNul);
    Add('In_Retimposto', 'IN_RETIMPOSTO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Prdinfos }

function TPrd_Prdinfos.Add: TPrd_Prdinfo;
begin
  Result := TPrd_Prdinfo.Create(nil);
  Self.Add(Result);
end;

end.