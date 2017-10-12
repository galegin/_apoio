unit uTefReltransacao;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTef_Reltransacao = class(TmMapping)
  private
    fCd_Emptef: String;
    fDt_Movimento: String;
    fNr_Seq: String;
    fCd_Emptra: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Emptef : String read fCd_Emptef write fCd_Emptef;
    property Dt_Movimento : String read fDt_Movimento write fDt_Movimento;
    property Nr_Seq : String read fNr_Seq write fNr_Seq;
    property Cd_Emptra : String read fCd_Emptra write fCd_Emptra;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TTef_Reltransacaos = class(TList)
  public
    function Add: TTef_Reltransacao; overload;
  end;

implementation

{ TTef_Reltransacao }

constructor TTef_Reltransacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTef_Reltransacao.Destroy;
begin

  inherited;
end;

//--

function TTef_Reltransacao.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TEF_RELTRANSACAO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Emptef', 'CD_EMPTEF', tfKey);
    Add('Dt_Movimento', 'DT_MOVIMENTO', tfKey);
    Add('Nr_Seq', 'NR_SEQ', tfKey);
    Add('Cd_Emptra', 'CD_EMPTRA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTef_Reltransacaos }

function TTef_Reltransacaos.Add: TTef_Reltransacao;
begin
  Result := TTef_Reltransacao.Create(nil);
  Self.Add(Result);
end;

end.