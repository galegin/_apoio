unit uGerOperclas;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Operclas = class;
  TGer_OperclasClass = class of TGer_Operclas;

  TGer_OperclasList = class;
  TGer_OperclasListClass = class of TGer_OperclasList;

  TGer_Operclas = class(TcCollectionItem)
  private
    fCd_Operacao: Real;
    fCd_Tipoclas: Real;
    fCd_Classificacao: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TGer_OperclasList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Operclas;
    procedure SetItem(Index: Integer; Value: TGer_Operclas);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Operclas;
    property Items[Index: Integer]: TGer_Operclas read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Operclas }

constructor TGer_Operclas.Create;
begin

end;

destructor TGer_Operclas.Destroy;
begin

  inherited;
end;

{ TGer_OperclasList }

constructor TGer_OperclasList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Operclas);
end;

function TGer_OperclasList.Add: TGer_Operclas;
begin
  Result := TGer_Operclas(inherited Add);
  Result.create;
end;

function TGer_OperclasList.GetItem(Index: Integer): TGer_Operclas;
begin
  Result := TGer_Operclas(inherited GetItem(Index));
end;

procedure TGer_OperclasList.SetItem(Index: Integer; Value: TGer_Operclas);
begin
  inherited SetItem(Index, Value);
end;

end.