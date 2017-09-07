unit uHistrel;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  THistrel = class(TmMapping)
  private
    fCd_Dnahistrel: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Equip: String;
    fNr_Histrel: Integer;
    fDs_Histrel: String;
    fNr_Parcela: Integer;
    fQt_Parcela: Integer;
    procedure SetCd_Dnahistrel(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetCd_Equip(const Value : String);
    procedure SetNr_Histrel(const Value : Integer);
    procedure SetDs_Histrel(const Value : String);
    procedure SetNr_Parcela(const Value : Integer);
    procedure SetQt_Parcela(const Value : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Dnahistrel : String read fCd_Dnahistrel write SetCd_Dnahistrel;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Equip : String read fCd_Equip write SetCd_Equip;
    property Nr_Histrel : Integer read fNr_Histrel write SetNr_Histrel;
    property Ds_Histrel : String read fDs_Histrel write SetDs_Histrel;
    property Nr_Parcela : Integer read fNr_Parcela write SetNr_Parcela;
    property Qt_Parcela : Integer read fQt_Parcela write SetQt_Parcela;
  end;

  THistrels = class(TList)
  public
    function Add: THistrel; overload;
  end;

implementation

{ THistrel }

constructor THistrel.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor THistrel.Destroy;
begin

  inherited;
end;

//--

function THistrel.GetTabela: TmTabela;
begin
  Result.Nome := 'HISTREL';
end;

function THistrel.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Dnahistrel|CD_DNAHISTREL']);
end;

function THistrel.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Dnahistrel|CD_DNAHISTREL',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Cd_Equip|CD_EQUIP',
    'Nr_Histrel|NR_HISTREL',
    'Ds_Histrel|DS_HISTREL',
    'Nr_Parcela|NR_PARCELA',
    'Qt_Parcela|QT_PARCELA']);
end;

//--

procedure THistrel.SetCd_Dnahistrel(const Value : String);
begin
  fCd_Dnahistrel := Value;
end;

procedure THistrel.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure THistrel.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure THistrel.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure THistrel.SetCd_Equip(const Value : String);
begin
  fCd_Equip := Value;
end;

procedure THistrel.SetNr_Histrel(const Value : Integer);
begin
  fNr_Histrel := Value;
end;

procedure THistrel.SetDs_Histrel(const Value : String);
begin
  fDs_Histrel := Value;
end;

procedure THistrel.SetNr_Parcela(const Value : Integer);
begin
  fNr_Parcela := Value;
end;

procedure THistrel.SetQt_Parcela(const Value : Integer);
begin
  fQt_Parcela := Value;
end;

{ THistrels }

function THistrels.Add: THistrel;
begin
  Result := THistrel.Create(nil);
  Self.Add(Result);
end;

end.