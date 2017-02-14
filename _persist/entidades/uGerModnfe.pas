unit uGerModnfe;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Modnfe = class;
  TGer_ModnfeClass = class of TGer_Modnfe;

  TGer_ModnfeList = class;
  TGer_ModnfeListClass = class of TGer_ModnfeList;

  TGer_Modnfe = class(TcCollectionItem)
  private
    fCd_Modelonf: Real;
    fTp_Campo: String;
    fNr_Item: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Campo: Real;
    fDs_Dados: String;
    fNr_Tamanho: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Modelonf : Real read fCd_Modelonf write fCd_Modelonf;
    property Tp_Campo : String read fTp_Campo write fTp_Campo;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Campo : Real read fCd_Campo write fCd_Campo;
    property Ds_Dados : String read fDs_Dados write fDs_Dados;
    property Nr_Tamanho : Real read fNr_Tamanho write fNr_Tamanho;
  end;

  TGer_ModnfeList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Modnfe;
    procedure SetItem(Index: Integer; Value: TGer_Modnfe);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Modnfe;
    property Items[Index: Integer]: TGer_Modnfe read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Modnfe }

constructor TGer_Modnfe.Create;
begin

end;

destructor TGer_Modnfe.Destroy;
begin

  inherited;
end;

{ TGer_ModnfeList }

constructor TGer_ModnfeList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Modnfe);
end;

function TGer_ModnfeList.Add: TGer_Modnfe;
begin
  Result := TGer_Modnfe(inherited Add);
  Result.create;
end;

function TGer_ModnfeList.GetItem(Index: Integer): TGer_Modnfe;
begin
  Result := TGer_Modnfe(inherited GetItem(Index));
end;

procedure TGer_ModnfeList.SetItem(Index: Integer; Value: TGer_Modnfe);
begin
  inherited SetItem(Index, Value);
end;

end.