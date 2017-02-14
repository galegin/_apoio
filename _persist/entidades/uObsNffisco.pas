unit uObsNffisco;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TObs_Nffisco = class;
  TObs_NffiscoClass = class of TObs_Nffisco;

  TObs_NffiscoList = class;
  TObs_NffiscoListClass = class of TObs_NffiscoList;

  TObs_Nffisco = class(TcCollectionItem)
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

  TObs_NffiscoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TObs_Nffisco;
    procedure SetItem(Index: Integer; Value: TObs_Nffisco);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TObs_Nffisco;
    property Items[Index: Integer]: TObs_Nffisco read GetItem write SetItem; default;
  end;
  
implementation

{ TObs_Nffisco }

constructor TObs_Nffisco.Create;
begin

end;

destructor TObs_Nffisco.Destroy;
begin

  inherited;
end;

{ TObs_NffiscoList }

constructor TObs_NffiscoList.Create(AOwner: TPersistent);
begin
  inherited Create(TObs_Nffisco);
end;

function TObs_NffiscoList.Add: TObs_Nffisco;
begin
  Result := TObs_Nffisco(inherited Add);
  Result.create;
end;

function TObs_NffiscoList.GetItem(Index: Integer): TObs_Nffisco;
begin
  Result := TObs_Nffisco(inherited GetItem(Index));
end;

procedure TObs_NffiscoList.SetItem(Index: Integer; Value: TObs_Nffisco);
begin
  inherited SetItem(Index, Value);
end;

end.