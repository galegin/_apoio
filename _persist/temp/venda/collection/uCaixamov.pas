unit uCaixamov;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TCaixamov = class;
  TCaixamovClass = class of TCaixamov;

  TCaixamovList = class;
  TCaixamovListClass = class of TCaixamovList;

  TCaixamov = class(TmCollectionItem)
  private
    fId_Caixa: Integer;
    fNr_Seq: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fTp_Lancto: Integer;
    fVl_Lancto: String;
    fNr_Doc: Integer;
    fDs_Aux: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Caixa : Integer read fId_Caixa write SetId_Caixa;
    property Nr_Seq : Integer read fNr_Seq write SetNr_Seq;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Lancto : Integer read fTp_Lancto write SetTp_Lancto;
    property Vl_Lancto : String read fVl_Lancto write SetVl_Lancto;
    property Nr_Doc : Integer read fNr_Doc write SetNr_Doc;
    property Ds_Aux : String read fDs_Aux write SetDs_Aux;
  end;

  TCaixamovList = class(TmCollection)
  private
    function GetItem(Index: Integer): TCaixamov;
    procedure SetItem(Index: Integer; Value: TCaixamov);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TCaixamov;
    property Items[Index: Integer]: TCaixamov read GetItem write SetItem; default;
  end;

implementation

{ TCaixamov }

constructor TCaixamov.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TCaixamov.Destroy;
begin

  inherited;
end;

{ TCaixamovList }

constructor TCaixamovList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TCaixamov);
end;

function TCaixamovList.Add: TCaixamov;
begin
  Result := TCaixamov(inherited Add);
  Result.create;
end;

function TCaixamovList.GetItem(Index: Integer): TCaixamov;
begin
  Result := TCaixamov(inherited GetItem(Index));
end;

procedure TCaixamovList.SetItem(Index: Integer; Value: TCaixamov);
begin
  inherited SetItem(Index, Value);
end;

end.