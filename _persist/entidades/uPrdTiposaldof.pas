unit uPrdTiposaldof;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Tiposaldof = class;
  TPrd_TiposaldofClass = class of TPrd_Tiposaldof;

  TPrd_TiposaldofList = class;
  TPrd_TiposaldofListClass = class of TPrd_TiposaldofList;

  TPrd_Tiposaldof = class(TcCollectionItem)
  private
    fCd_Saldo: Real;
    fNr_Seq: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Saldof: Real;
    fTp_Operacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Saldo : Real read fCd_Saldo write fCd_Saldo;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Saldof : Real read fCd_Saldof write fCd_Saldof;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
  end;

  TPrd_TiposaldofList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Tiposaldof;
    procedure SetItem(Index: Integer; Value: TPrd_Tiposaldof);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Tiposaldof;
    property Items[Index: Integer]: TPrd_Tiposaldof read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Tiposaldof }

constructor TPrd_Tiposaldof.Create;
begin

end;

destructor TPrd_Tiposaldof.Destroy;
begin

  inherited;
end;

{ TPrd_TiposaldofList }

constructor TPrd_TiposaldofList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Tiposaldof);
end;

function TPrd_TiposaldofList.Add: TPrd_Tiposaldof;
begin
  Result := TPrd_Tiposaldof(inherited Add);
  Result.create;
end;

function TPrd_TiposaldofList.GetItem(Index: Integer): TPrd_Tiposaldof;
begin
  Result := TPrd_Tiposaldof(inherited GetItem(Index));
end;

procedure TPrd_TiposaldofList.SetItem(Index: Integer; Value: TPrd_Tiposaldof);
begin
  inherited SetItem(Index, Value);
end;

end.