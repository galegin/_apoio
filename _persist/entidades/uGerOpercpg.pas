unit uGerOpercpg;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Opercpg = class;
  TGer_OpercpgClass = class of TGer_Opercpg;

  TGer_OpercpgList = class;
  TGer_OpercpgListClass = class of TGer_OpercpgList;

  TGer_Opercpg = class(TcCollectionItem)
  private
    fCd_Operacao: Real;
    fCd_Condpgto: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property Cd_Condpgto : Real read fCd_Condpgto write fCd_Condpgto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TGer_OpercpgList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Opercpg;
    procedure SetItem(Index: Integer; Value: TGer_Opercpg);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Opercpg;
    property Items[Index: Integer]: TGer_Opercpg read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Opercpg }

constructor TGer_Opercpg.Create;
begin

end;

destructor TGer_Opercpg.Destroy;
begin

  inherited;
end;

{ TGer_OpercpgList }

constructor TGer_OpercpgList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Opercpg);
end;

function TGer_OpercpgList.Add: TGer_Opercpg;
begin
  Result := TGer_Opercpg(inherited Add);
  Result.create;
end;

function TGer_OpercpgList.GetItem(Index: Integer): TGer_Opercpg;
begin
  Result := TGer_Opercpg(inherited GetItem(Index));
end;

procedure TGer_OpercpgList.SetItem(Index: Integer; Value: TGer_Opercpg);
begin
  inherited SetItem(Index, Value);
end;

end.