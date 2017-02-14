unit uFisNfvencto;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfvencto = class;
  TFis_NfvenctoClass = class of TFis_Nfvencto;

  TFis_NfvenctoList = class;
  TFis_NfvenctoListClass = class of TFis_NfvenctoList;

  TFis_Nfvencto = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fNr_Parcela: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Parcela: Real;
    fDt_Vencimento: TDateTime;
    fDt_Baixa: TDateTime;
    fTp_Formapgto: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Parcela : Real read fVl_Parcela write fVl_Parcela;
    property Dt_Vencimento : TDateTime read fDt_Vencimento write fDt_Vencimento;
    property Dt_Baixa : TDateTime read fDt_Baixa write fDt_Baixa;
    property Tp_Formapgto : Real read fTp_Formapgto write fTp_Formapgto;
  end;

  TFis_NfvenctoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfvencto;
    procedure SetItem(Index: Integer; Value: TFis_Nfvencto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfvencto;
    property Items[Index: Integer]: TFis_Nfvencto read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfvencto }

constructor TFis_Nfvencto.Create;
begin

end;

destructor TFis_Nfvencto.Destroy;
begin

  inherited;
end;

{ TFis_NfvenctoList }

constructor TFis_NfvenctoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfvencto);
end;

function TFis_NfvenctoList.Add: TFis_Nfvencto;
begin
  Result := TFis_Nfvencto(inherited Add);
  Result.create;
end;

function TFis_NfvenctoList.GetItem(Index: Integer): TFis_Nfvencto;
begin
  Result := TFis_Nfvencto(inherited GetItem(Index));
end;

procedure TFis_NfvenctoList.SetItem(Index: Integer; Value: TFis_Nfvencto);
begin
  inherited SetItem(Index, Value);
end;

end.