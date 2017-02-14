unit uFisNfimposto;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfimposto = class;
  TFis_NfimpostoClass = class of TFis_Nfimposto;

  TFis_NfimpostoList = class;
  TFis_NfimpostoListClass = class of TFis_NfimpostoList;

  TFis_Nfimposto = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fCd_Imposto: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
    fPr_Basecalc: Real;
    fPr_Redubase: Real;
    fVl_Basecalc: Real;
    fVl_Isento: Real;
    fVl_Outro: Real;
    fVl_Imposto: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Cd_Imposto : Real read fCd_Imposto write fCd_Imposto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota : Real read fPr_Aliquota write fPr_Aliquota;
    property Pr_Basecalc : Real read fPr_Basecalc write fPr_Basecalc;
    property Pr_Redubase : Real read fPr_Redubase write fPr_Redubase;
    property Vl_Basecalc : Real read fVl_Basecalc write fVl_Basecalc;
    property Vl_Isento : Real read fVl_Isento write fVl_Isento;
    property Vl_Outro : Real read fVl_Outro write fVl_Outro;
    property Vl_Imposto : Real read fVl_Imposto write fVl_Imposto;
  end;

  TFis_NfimpostoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfimposto;
    procedure SetItem(Index: Integer; Value: TFis_Nfimposto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfimposto;
    property Items[Index: Integer]: TFis_Nfimposto read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfimposto }

constructor TFis_Nfimposto.Create;
begin

end;

destructor TFis_Nfimposto.Destroy;
begin

  inherited;
end;

{ TFis_NfimpostoList }

constructor TFis_NfimpostoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfimposto);
end;

function TFis_NfimpostoList.Add: TFis_Nfimposto;
begin
  Result := TFis_Nfimposto(inherited Add);
  Result.create;
end;

function TFis_NfimpostoList.GetItem(Index: Integer): TFis_Nfimposto;
begin
  Result := TFis_Nfimposto(inherited GetItem(Index));
end;

procedure TFis_NfimpostoList.SetItem(Index: Integer; Value: TFis_Nfimposto);
begin
  inherited SetItem(Index, Value);
end;

end.