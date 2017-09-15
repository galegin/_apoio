unit uTransimposto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransimposto = class(TmMapping)
  private
    fId_Transacao: String;
    fNr_Item: Integer;
    fCd_Imposto: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
    fVl_Basecalculo: Real;
    fPr_Basecalculo: Real;
    fPr_Redbasecalculo: Real;
    fVl_Imposto: Real;
    fVl_Outro: Real;
    fVl_Isento: Real;
    fCd_Cst: String;
    fCd_Csosn: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    property Nr_Item : Integer read fNr_Item write fNr_Item;
    property Cd_Imposto : Integer read fCd_Imposto write fCd_Imposto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota : Real read fPr_Aliquota write fPr_Aliquota;
    property Vl_Basecalculo : Real read fVl_Basecalculo write fVl_Basecalculo;
    property Pr_Basecalculo : Real read fPr_Basecalculo write fPr_Basecalculo;
    property Pr_Redbasecalculo : Real read fPr_Redbasecalculo write fPr_Redbasecalculo;
    property Vl_Imposto : Real read fVl_Imposto write fVl_Imposto;
    property Vl_Outro : Real read fVl_Outro write fVl_Outro;
    property Vl_Isento : Real read fVl_Isento write fVl_Isento;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Cd_Csosn : String read fCd_Csosn write fCd_Csosn;
  end;

  TTransimpostos = class(TList)
  public
    function Add: TTransimposto; overload;
  end;

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

//--

function TTransimposto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSIMPOSTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO', ftKey);
    Add('Nr_Item', 'NR_ITEM', ftKey);
    Add('Cd_Imposto', 'CD_IMPOSTO', ftKey);
    Add('U_Version', 'U_VERSION', ftNul);
    Add('Cd_Operador', 'CD_OPERADOR', ftReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', ftReq);
    Add('Pr_Aliquota', 'PR_ALIQUOTA', ftReq);
    Add('Vl_Basecalculo', 'VL_BASECALCULO', ftReq);
    Add('Pr_Basecalculo', 'PR_BASECALCULO', ftReq);
    Add('Pr_Redbasecalculo', 'PR_REDBASECALCULO', ftReq);
    Add('Vl_Imposto', 'VL_IMPOSTO', ftReq);
    Add('Vl_Outro', 'VL_OUTRO', ftReq);
    Add('Vl_Isento', 'VL_ISENTO', ftReq);
    Add('Cd_Cst', 'CD_CST', ftReq);
    Add('Cd_Csosn', 'CD_CSOSN', ftNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTransimpostos }

function TTransimpostos.Add: TTransimposto;
begin
  Result := TTransimposto.Create(nil);
  Self.Add(Result);
end;

end.