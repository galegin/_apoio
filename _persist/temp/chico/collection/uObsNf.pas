unit uObsNf;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TObs_Nf = class;
  TObs_NfClass = class of TObs_Nf;

  TObs_NfList = class;
  TObs_NfListClass = class of TObs_NfList;

  TObs_Nf = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fNr_Linha: String;
    fU_Version: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Observacao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write SetNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write SetDt_Fatura;
    property Nr_Linha : String read fNr_Linha write SetNr_Linha;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Empfat : String read fCd_Empfat write SetCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Observacao : String read fDs_Observacao write SetDs_Observacao;
  end;

  TObs_NfList = class(TmCollection)
  private
    function GetItem(Index: Integer): TObs_Nf;
    procedure SetItem(Index: Integer; Value: TObs_Nf);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TObs_Nf;
    property Items[Index: Integer]: TObs_Nf read GetItem write SetItem; default;
  end;

implementation

{ TObs_Nf }

constructor TObs_Nf.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TObs_Nf.Destroy;
begin

  inherited;
end;

{ TObs_NfList }

constructor TObs_NfList.Create(AOwner: TPersistentCollection);
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