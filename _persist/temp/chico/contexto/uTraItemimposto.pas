unit uTraItemimposto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Itemimposto = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fNr_Item: String;
    fCd_Imposto: String;
    fU_Version: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fPr_Aliquota: String;
    fPr_Basecalc: String;
    fPr_Redubase: String;
    fVl_Basecalc: String;
    fVl_Isento: String;
    fVl_Outro: String;
    fVl_Imposto: String;
    fCd_Cst: String;
    fVl_Basecalcc: String;
    fVl_Isentoc: String;
    fVl_Outroc: String;
    fVl_Impostoc: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property Nr_Item : String read fNr_Item write fNr_Item;
    property Cd_Imposto : String read fCd_Imposto write fCd_Imposto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write fPr_Aliquota;
    property Pr_Basecalc : String read fPr_Basecalc write fPr_Basecalc;
    property Pr_Redubase : String read fPr_Redubase write fPr_Redubase;
    property Vl_Basecalc : String read fVl_Basecalc write fVl_Basecalc;
    property Vl_Isento : String read fVl_Isento write fVl_Isento;
    property Vl_Outro : String read fVl_Outro write fVl_Outro;
    property Vl_Imposto : String read fVl_Imposto write fVl_Imposto;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Vl_Basecalcc : String read fVl_Basecalcc write fVl_Basecalcc;
    property Vl_Isentoc : String read fVl_Isentoc write fVl_Isentoc;
    property Vl_Outroc : String read fVl_Outroc write fVl_Outroc;
    property Vl_Impostoc : String read fVl_Impostoc write fVl_Impostoc;
  end;

  TTra_Itemimpostos = class(TList)
  public
    function Add: TTra_Itemimposto; overload;
  end;

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

//--

function TTra_Itemimposto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_ITEMIMPOSTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('Nr_Item', 'NR_ITEM', tfKey);
    Add('Cd_Imposto', 'CD_IMPOSTO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Empfat', 'CD_EMPFAT', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Pr_Aliquota', 'PR_ALIQUOTA', tfNul);
    Add('Pr_Basecalc', 'PR_BASECALC', tfNul);
    Add('Pr_Redubase', 'PR_REDUBASE', tfNul);
    Add('Vl_Basecalc', 'VL_BASECALC', tfNul);
    Add('Vl_Isento', 'VL_ISENTO', tfNul);
    Add('Vl_Outro', 'VL_OUTRO', tfNul);
    Add('Vl_Imposto', 'VL_IMPOSTO', tfNul);
    Add('Cd_Cst', 'CD_CST', tfNul);
    Add('Vl_Basecalcc', 'VL_BASECALCC', tfNul);
    Add('Vl_Isentoc', 'VL_ISENTOC', tfNul);
    Add('Vl_Outroc', 'VL_OUTROC', tfNul);
    Add('Vl_Impostoc', 'VL_IMPOSTOC', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Itemimpostos }

function TTra_Itemimpostos.Add: TTra_Itemimposto;
begin
  Result := TTra_Itemimposto.Create(nil);
  Self.Add(Result);
end;

end.