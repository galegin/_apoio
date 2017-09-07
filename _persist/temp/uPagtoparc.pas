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
    fDt_Cadastro: String;
    fVl_Parcela: String;
    fTp_Docto: Integer;
    fNr_Docto: Integer;
    fDt_Vencto: String;
    fDs_Adicional: String;
    fCd_Dnabaixa: String;
    procedure SetCd_Dnapagto(const Value : String);
    procedure SetNr_Parcela(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetVl_Parcela(const Value : String);
    procedure SetTp_Docto(const Value : Integer);
    procedure SetNr_Docto(const Value : Integer);
    procedure SetDt_Vencto(const Value : String);
    procedure SetDs_Adicional(const Value : String);
    procedure SetCd_Dnabaixa(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Dnapagto : String read fCd_Dnapagto write SetCd_Dnapagto;
    property Nr_Parcela : Integer read fNr_Parcela write SetNr_Parcela;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Vl_Parcela : String read fVl_Parcela write SetVl_Parcela;
    property Tp_Docto : Integer read fTp_Docto write SetTp_Docto;
    property Nr_Docto : Integer read fNr_Docto write SetNr_Docto;
    property Dt_Vencto : String read fDt_Vencto write SetDt_Vencto;
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

function TPagtoparc.GetTabela: TmTabela;
begin
  Result.Nome := 'PAGTOPARC';
end;

function TPagtoparc.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Dnapagto|CD_DNAPAGTO',
    'Nr_Parcela|NR_PARCELA']);
end;

function TPagtoparc.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Dnapagto|CD_DNAPAGTO',
    'Nr_Parcela|NR_PARCELA',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Vl_Parcela|VL_PARCELA',
    'Tp_Docto|TP_DOCTO',
    'Nr_Docto|NR_DOCTO',
    'Dt_Vencto|DT_VENCTO',
    'Ds_Adicional|DS_ADICIONAL',
    'Cd_Dnabaixa|CD_DNABAIXA']);
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

procedure TPagtoparc.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TPagtoparc.SetVl_Parcela(const Value : String);
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

procedure TPagtoparc.SetDt_Vencto(const Value : String);
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