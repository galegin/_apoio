unit uFisNfecont;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Nfecont = class;
  TFis_NfecontClass = class of TFis_Nfecont;

  TFis_NfecontList = class;
  TFis_NfecontListClass = class of TFis_NfecontList;

  TFis_Nfecont = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Situacao: String;
    fCd_Terminal: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write SetNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write SetDt_Fatura;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Situacao : String read fTp_Situacao write SetTp_Situacao;
    property Cd_Terminal : String read fCd_Terminal write SetCd_Terminal;
  end;

  TFis_NfecontList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Nfecont;
    procedure SetItem(Index: Integer; Value: TFis_Nfecont);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Nfecont;
    property Items[Index: Integer]: TFis_Nfecont read GetItem write SetItem; default;
  end;

implementation

{ TFis_Nfecont }

constructor TFis_Nfecont.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Nfecont.Destroy;
begin

  inherited;
end;

{ TFis_NfecontList }

constructor TFis_NfecontList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFis_Nfecont);
end;

function TFis_NfecontList.Add: TFis_Nfecont;
begin
  Result := TFis_Nfecont(inherited Add);
  Result.create;
end;

function TFis_NfecontList.GetItem(Index: Integer): TFis_Nfecont;
begin
  Result := TFis_Nfecont(inherited GetItem(Index));
end;

procedure TFis_NfecontList.SetItem(Index: Integer; Value: TFis_Nfecont);
begin
  inherited SetItem(Index, Value);
end;

end.