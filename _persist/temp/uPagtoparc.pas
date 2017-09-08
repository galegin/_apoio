unit uPagtoparc;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPagtoparc = class(TmMapping)
  private
    fCd_Dnapagto: String;
    fNr_Parcela: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fVl_Parcela: Real;
    fTp_Docto: Integer;
    fNr_Docto: Integer;
    fDt_Vencto: TDateTime;
    fDs_Adicional: String;
    fCd_Dnabaixa: String;
    procedure SetCd_Dnapagto(const Value : String);
    procedure SetNr_Parcela(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetVl_Parcela(const Value : Real);
    procedure SetTp_Docto(const Value : Integer);
    procedure SetNr_Docto(const Value : Integer);
    procedure SetDt_Vencto(const Value : TDateTime);
    procedure SetDs_Adicional(const Value : String);
    procedure SetCd_Dnabaixa(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnapagto : String read fCd_Dnapagto write SetCd_Dnapagto;
    property Nr_Parcela : Integer read fNr_Parcela write SetNr_Parcela;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Vl_Parcela : Real read fVl_Parcela write SetVl_Parcela;
    property Tp_Docto : Integer read fTp_Docto write SetTp_Docto;
    property Nr_Docto : Integer read fNr_Docto write SetNr_Docto;
    property Dt_Vencto : TDateTime read fDt_Vencto write SetDt_Vencto;
    property Ds_Adicional : String read fDs_Adicional write SetDs_Adicional;
    property Cd_Dnabaixa : String read fCd_Dnabaixa write SetCd_Dnabaixa;
  end;

  TPagtoparcs = class(TList)
  public
    function Add: TPagtoparc; overload;
  end;

implementation

{ TPagtoparc }

constructor TPagtoparc.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPagtoparc.Destroy;
begin

  inherited;
end;

//--

function TPagtoparc.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PAGTOPARC';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnapagto', 'CD_DNAPAGTO');
    Add('Nr_Parcela', 'NR_PARCELA');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnapagto', 'CD_DNAPAGTO');
    Add('Nr_Parcela', 'NR_PARCELA');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Vl_Parcela', 'VL_PARCELA');
    Add('Tp_Docto', 'TP_DOCTO');
    Add('Nr_Docto', 'NR_DOCTO');
    Add('Dt_Vencto', 'DT_VENCTO');
    Add('Ds_Adicional', 'DS_ADICIONAL');
    Add('Cd_Dnabaixa', 'CD_DNABAIXA');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TPagtoparc.SetCd_Dnapagto(const Value : String);
begin
  fCd_Dnapagto := Value;
end;

procedure TPagtoparc.SetNr_Parcela(const Value : Integer);
begin
  fNr_Parcela := Value;
end;

procedure TPagtoparc.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TPagtoparc.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TPagtoparc.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TPagtoparc.SetVl_Parcela(const Value : Real);
begin
  fVl_Parcela := Value;
end;

procedure TPagtoparc.SetTp_Docto(const Value : Integer);
begin
  fTp_Docto := Value;
end;

procedure TPagtoparc.SetNr_Docto(const Value : Integer);
begin
  fNr_Docto := Value;
end;

procedure TPagtoparc.SetDt_Vencto(const Value : TDateTime);
begin
  fDt_Vencto := Value;
end;

procedure TPagtoparc.SetDs_Adicional(const Value : String);
begin
  fDs_Adicional := Value;
end;

procedure TPagtoparc.SetCd_Dnabaixa(const Value : String);
begin
  fCd_Dnabaixa := Value;
end;

{ TPagtoparcs }

function TPagtoparcs.Add: TPagtoparc;
begin
  Result := TPagtoparc.Create(nil);
  Self.Add(Result);
end;

end.