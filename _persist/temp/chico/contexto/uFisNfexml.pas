unit uFisNfexml;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Nfexml = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Ambiente: String;
    fTp_Emissao: String;
    fDs_Envioxml: String;
    fDs_Retornoxml: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write fDt_Fatura;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Ambiente : String read fTp_Ambiente write fTp_Ambiente;
    property Tp_Emissao : String read fTp_Emissao write fTp_Emissao;
    property Ds_Envioxml : String read fDs_Envioxml write fDs_Envioxml;
    property Ds_Retornoxml : String read fDs_Retornoxml write fDs_Retornoxml;
  end;

  TFis_Nfexmls = class(TList)
  public
    function Add: TFis_Nfexml; overload;
  end;

implementation

{ TFis_Nfexml }

constructor TFis_Nfexml.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Nfexml.Destroy;
begin

  inherited;
end;

//--

function TFis_Nfexml.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_NFEXML';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Fatura', 'NR_FATURA', tfKey);
    Add('Dt_Fatura', 'DT_FATURA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Tp_Ambiente', 'TP_AMBIENTE', tfReq);
    Add('Tp_Emissao', 'TP_EMISSAO', tfReq);
    Add('Ds_Envioxml', 'DS_ENVIOXML', tfReq);
    Add('Ds_Retornoxml', 'DS_RETORNOXML', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Nfexmls }

function TFis_Nfexmls.Add: TFis_Nfexml;
begin
  Result := TFis_Nfexml.Create(nil);
  Self.Add(Result);
end;

end.