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
    fDt_Cadastro: String;
    fPr_Aliquota: String;
    fVl_Basecalculo: String;
    fPr_Basecalculo: String;
    fPr_Redbasecalculo: String;
    fVl_Imposto: String;
    fVl_Outro: String;
    fVl_Isento: String;
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
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write fPr_Aliquota;
    property Vl_Basecalculo : String read fVl_Basecalculo write fVl_Basecalculo;
    property Pr_Basecalculo : String read fPr_Basecalculo write fPr_Basecalculo;
    property Pr_Redbasecalculo : String read fPr_Redbasecalculo write fPr_Redbasecalculo;
    property Vl_Imposto : String read fVl_Imposto write fVl_Imposto;
    property Vl_Outro : String read fVl_Outro write fVl_Outro;
    property Vl_Isento : String read fVl_Isento write fVl_Isento;
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
    Add('Id_Transacao', 'ID_TRANSACAO', tfKey);
    Add('Nr_Item', 'NR_ITEM', tfKey);
    Add('Cd_Imposto', 'CD_IMPOSTO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Pr_Aliquota', 'PR_ALIQUOTA', tfReq);
    Add('Vl_Basecalculo', 'VL_BASECALCULO', tfReq);
    Add('Pr_Basecalculo', 'PR_BASECALCULO', tfReq);
    Add('Pr_Redbasecalculo', 'PR_REDBASECALCULO', tfReq);
    Add('Vl_Imposto', 'VL_IMPOSTO', tfReq);
    Add('Vl_Outro', 'VL_OUTRO', tfReq);
    Add('Vl_Isento', 'VL_ISENTO', tfReq);
    Add('Cd_Cst', 'CD_CST', tfReq);
    Add('Cd_Csosn', 'CD_CSOSN', tfNul);
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