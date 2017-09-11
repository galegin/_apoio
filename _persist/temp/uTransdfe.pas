unit uTransdfe;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransdfe = class(TmMapping)
  private
    fId_Transacao: String;
    fNr_Sequencia: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Evento: Integer;
    fTp_Ambiente: Integer;
    fTp_Emissao: Integer;
    fDs_Envioxml: String;
    fDs_Retornoxml: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    property Nr_Sequencia : Integer read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Evento : Integer read fTp_Evento write fTp_Evento;
    property Tp_Ambiente : Integer read fTp_Ambiente write fTp_Ambiente;
    property Tp_Emissao : Integer read fTp_Emissao write fTp_Emissao;
    property Ds_Envioxml : String read fDs_Envioxml write fDs_Envioxml;
    property Ds_Retornoxml : String read fDs_Retornoxml write fDs_Retornoxml;
  end;

  TTransdfes = class(TList)
  public
    function Add: TTransdfe; overload;
  end;

implementation

{ TTransdfe }

constructor TTransdfe.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransdfe.Destroy;
begin

  inherited;
end;

//--

function TTransdfe.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSDFE';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO', ftKey);
    Add('Nr_Sequencia', 'NR_SEQUENCIA', ftKey);
    Add('U_Version', 'U_VERSION', ftNul);
    Add('Cd_Operador', 'CD_OPERADOR', ftReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', ftReq);
    Add('Tp_Evento', 'TP_EVENTO', ftReq);
    Add('Tp_Ambiente', 'TP_AMBIENTE', ftReq);
    Add('Tp_Emissao', 'TP_EMISSAO', ftReq);
    Add('Ds_Envioxml', 'DS_ENVIOXML', ftReq);
    Add('Ds_Retornoxml', 'DS_RETORNOXML', ftNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTransdfes }

function TTransdfes.Add: TTransdfe;
begin
  Result := TTransdfe.Create(nil);
  Self.Add(Result);
end;

end.