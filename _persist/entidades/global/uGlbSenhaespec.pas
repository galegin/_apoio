unit uGlbSenhaespec;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Senhaespec = class;
  TGlb_SenhaespecClass = class of TGlb_Senhaespec;

  TGlb_SenhaespecList = class;
  TGlb_SenhaespecListClass = class of TGlb_SenhaespecList;

  TGlb_Senhaespec = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fDt_Anomes: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Senha: String;
    fCd_Contrasenha: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property Dt_Anomes : TDateTime read fDt_Anomes write fDt_Anomes;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Senha : String read fCd_Senha write fCd_Senha;
    property Cd_Contrasenha : String read fCd_Contrasenha write fCd_Contrasenha;
  end;

  TGlb_SenhaespecList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Senhaespec;
    procedure SetItem(Index: Integer; Value: TGlb_Senhaespec);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Senhaespec;
    property Items[Index: Integer]: TGlb_Senhaespec read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Senhaespec }

constructor TGlb_Senhaespec.Create;
begin

end;

destructor TGlb_Senhaespec.Destroy;
begin

  inherited;
end;

{ TGlb_SenhaespecList }

constructor TGlb_SenhaespecList.Create(AOwner: TPersistent);
begin
  inherited Create(TGlb_Senhaespec);
end;

function TGlb_SenhaespecList.Add: TGlb_Senhaespec;
begin
  Result := TGlb_Senhaespec(inherited Add);
  Result.create;
end;

function TGlb_SenhaespecList.GetItem(Index: Integer): TGlb_Senhaespec;
begin
  Result := TGlb_Senhaespec(inherited GetItem(Index));
end;

procedure TGlb_SenhaespecList.SetItem(Index: Integer; Value: TGlb_Senhaespec);
begin
  inherited SetItem(Index, Value);
end;

end.