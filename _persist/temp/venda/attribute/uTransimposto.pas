unit uTransimposto;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRANSIMPOSTO')]
  TTransimposto = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_TRANSACAO', tfKey)]
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    [Campo('NR_ITEM', tfKey)]
    property Nr_Item : Integer read fNr_Item write fNr_Item;
    [Campo('CD_IMPOSTO', tfKey)]
    property Cd_Imposto : Integer read fCd_Imposto write fCd_Imposto;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('PR_ALIQUOTA', tfReq)]
    property Pr_Aliquota : String read fPr_Aliquota write fPr_Aliquota;
    [Campo('VL_BASECALCULO', tfReq)]
    property Vl_Basecalculo : String read fVl_Basecalculo write fVl_Basecalculo;
    [Campo('PR_BASECALCULO', tfReq)]
    property Pr_Basecalculo : String read fPr_Basecalculo write fPr_Basecalculo;
    [Campo('PR_REDBASECALCULO', tfReq)]
    property Pr_Redbasecalculo : String read fPr_Redbasecalculo write fPr_Redbasecalculo;
    [Campo('VL_IMPOSTO', tfReq)]
    property Vl_Imposto : String read fVl_Imposto write fVl_Imposto;
    [Campo('VL_OUTRO', tfReq)]
    property Vl_Outro : String read fVl_Outro write fVl_Outro;
    [Campo('VL_ISENTO', tfReq)]
    property Vl_Isento : String read fVl_Isento write fVl_Isento;
    [Campo('CD_CST', tfReq)]
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    [Campo('CD_CSOSN', tfNul)]
    property Cd_Csosn : String read fCd_Csosn write fCd_Csosn;
  end;

  TTransimpostos = class(TList<Transimposto>);

implementation

{ TTransimposto }

constructor TTransimposto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransimposto.Destroy;
begin

  inherited;
end;

end.