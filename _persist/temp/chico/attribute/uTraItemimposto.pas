unit uTraItemimposto;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_ITEMIMPOSTO')]
  TTra_Itemimposto = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NR_TRANSACAO', tfKey)]
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    [Campo('DT_TRANSACAO', tfKey)]
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    [Campo('NR_ITEM', tfKey)]
    property Nr_Item : String read fNr_Item write fNr_Item;
    [Campo('CD_IMPOSTO', tfKey)]
    property Cd_Imposto : String read fCd_Imposto write fCd_Imposto;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_EMPFAT', tfReq)]
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('PR_ALIQUOTA', tfNul)]
    property Pr_Aliquota : String read fPr_Aliquota write fPr_Aliquota;
    [Campo('PR_BASECALC', tfNul)]
    property Pr_Basecalc : String read fPr_Basecalc write fPr_Basecalc;
    [Campo('PR_REDUBASE', tfNul)]
    property Pr_Redubase : String read fPr_Redubase write fPr_Redubase;
    [Campo('VL_BASECALC', tfNul)]
    property Vl_Basecalc : String read fVl_Basecalc write fVl_Basecalc;
    [Campo('VL_ISENTO', tfNul)]
    property Vl_Isento : String read fVl_Isento write fVl_Isento;
    [Campo('VL_OUTRO', tfNul)]
    property Vl_Outro : String read fVl_Outro write fVl_Outro;
    [Campo('VL_IMPOSTO', tfNul)]
    property Vl_Imposto : String read fVl_Imposto write fVl_Imposto;
    [Campo('CD_CST', tfNul)]
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    [Campo('VL_BASECALCC', tfNul)]
    property Vl_Basecalcc : String read fVl_Basecalcc write fVl_Basecalcc;
    [Campo('VL_ISENTOC', tfNul)]
    property Vl_Isentoc : String read fVl_Isentoc write fVl_Isentoc;
    [Campo('VL_OUTROC', tfNul)]
    property Vl_Outroc : String read fVl_Outroc write fVl_Outroc;
    [Campo('VL_IMPOSTOC', tfNul)]
    property Vl_Impostoc : String read fVl_Impostoc write fVl_Impostoc;
  end;

  TTra_Itemimpostos = class(TList<Tra_Itemimposto>);

implementation

{ TTra_Itemimposto }

constructor TTra_Itemimposto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Itemimposto.Destroy;
begin

  inherited;
end;

end.