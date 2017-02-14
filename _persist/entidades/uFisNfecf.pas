unit uFisNfecf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfecf = class;
  TFis_NfecfClass = class of TFis_Nfecf;

  TFis_NfecfList = class;
  TFis_NfecfListClass = class of TFis_NfecfList;

  TFis_Nfecf = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fU_Version: String;
    fCd_Empecf: Real;
    fNr_Ecf: Real;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Situacao: String;
    fNr_Cupom: Real;
    fCd_Seriefab: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empecf : Real read fCd_Empecf write fCd_Empecf;
    property Nr_Ecf : Real read fNr_Ecf write fNr_Ecf;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Nr_Cupom : Real read fNr_Cupom write fNr_Cupom;
    property Cd_Seriefab : String read fCd_Seriefab write fCd_Seriefab;
  end;

  TFis_NfecfList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfecf;
    procedure SetItem(Index: Integer; Value: TFis_Nfecf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfecf;
    property Items[Index: Integer]: TFis_Nfecf read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfecf }

constructor TFis_Nfecf.Create;
begin

end;

destructor TFis_Nfecf.Destroy;
begin

  inherited;
end;

{ TFis_NfecfList }

constructor TFis_NfecfList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfecf);
end;

function TFis_NfecfList.Add: TFis_Nfecf;
begin
  Result := TFis_Nfecf(inherited Add);
  Result.create;
end;

function TFis_NfecfList.GetItem(Index: Integer): TFis_Nfecf;
begin
  Result := TFis_Nfecf(inherited GetItem(Index));
end;

procedure TFis_NfecfList.SetItem(Index: Integer; Value: TFis_Nfecf);
begin
  inherited SetItem(Index, Value);
end;

end.