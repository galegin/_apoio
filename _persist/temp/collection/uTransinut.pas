unit uTransinut;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTransinut = class;
  TTransinutClass = class of TTransinut;

  TTransinutList = class;
  TTransinutListClass = class of TTransinutList;

  TTransinut = class(TmCollectionItem)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDt_Emissao: String;
    fTp_Modelonf: Integer;
    fCd_Serie: String;
    fNr_Nf: Integer;
    fDt_Recebimento: String;
    fNr_Recibo: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Dt_Emissao : String read fDt_Emissao write SetDt_Emissao;
    property Tp_Modelonf : Integer read fTp_Modelonf write SetTp_Modelonf;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Nr_Nf : Integer read fNr_Nf write SetNr_Nf;
    property Dt_Recebimento : String read fDt_Recebimento write SetDt_Recebimento;
    property Nr_Recibo : String read fNr_Recibo write SetNr_Recibo;
  end;

  TTransinutList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransinut;
    procedure SetItem(Index: Integer; Value: TTransinut);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTransinut;
    property Items[Index: Integer]: TTransinut read GetItem write SetItem; default;
  end;

implementation

{ TTransinut }

constructor TTransinut.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTransinut.Destroy;
begin

  inherited;
end;

{ TTransinutList }

constructor TTransinutList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTransinut);
end;

function TTransinutList.Add: TTransinut;
begin
  Result := TTransinut(inherited Add);
  Result.create;
end;

function TTransinutList.GetItem(Index: Integer): TTransinut;
begin
  Result := TTransinut(inherited GetItem(Index));
end;

procedure TTransinutList.SetItem(Index: Integer; Value: TTransinut);
begin
  inherited SetItem(Index, Value);
end;

end.