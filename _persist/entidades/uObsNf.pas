unit uObsNf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TObs_Nf = class;
  TObs_NfClass = class of TObs_Nf;

  TObs_NfList = class;
  TObs_NfListClass = class of TObs_NfList;

  TObs_Nf = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fNr_Linha: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Observacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Nr_Linha : Real read fNr_Linha write fNr_Linha;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TObs_NfList = class(TcCollection)
  private
    function GetItem(Index: Integer): TObs_Nf;
    procedure SetItem(Index: Integer; Value: TObs_Nf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TObs_Nf;
    property Items[Index: Integer]: TObs_Nf read GetItem write SetItem; default;
  end;
  
implementation

{ TObs_Nf }

constructor TObs_Nf.Create;
begin

end;

destructor TObs_Nf.Destroy;
begin

  inherited;
end;

{ TObs_NfList }

constructor TObs_NfList.Create(AOwner: TPersistent);
begin
  inherited Create(TObs_Nf);
end;

function TObs_NfList.Add: TObs_Nf;
begin
  Result := TObs_Nf(inherited Add);
  Result.create;
end;

function TObs_NfList.GetItem(Index: Integer): TObs_Nf;
begin
  Result := TObs_Nf(inherited GetItem(Index));
end;

procedure TObs_NfList.SetItem(Index: Integer; Value: TObs_Nf);
begin
  inherited SetItem(Index, Value);
end;

end.