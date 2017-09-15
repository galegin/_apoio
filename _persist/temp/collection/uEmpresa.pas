unit uEmpresa;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TEmpresa = class;
  TEmpresaClass = class of TEmpresa;

  TEmpresaList = class;
  TEmpresaListClass = class of TEmpresaList;

  TEmpresa = class(TmCollectionItem)
  private
    fId_Empresa: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fId_Pessoa: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Empresa : Integer read fId_Empresa write SetId_Empresa;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Id_Pessoa : String read fId_Pessoa write SetId_Pessoa;
  end;

  TEmpresaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TEmpresa;
    procedure SetItem(Index: Integer; Value: TEmpresa);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TEmpresa;
    property Items[Index: Integer]: TEmpresa read GetItem write SetItem; default;
  end;

implementation

{ TEmpresa }

constructor TEmpresa.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TEmpresa.Destroy;
begin

  inherited;
end;

{ TEmpresaList }

constructor TEmpresaList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TEmpresa);
end;

function TEmpresaList.Add: TEmpresa;
begin
  Result := TEmpresa(inherited Add);
  Result.create;
end;

function TEmpresaList.GetItem(Index: Integer): TEmpresa;
begin
  Result := TEmpresa(inherited GetItem(Index));
end;

procedure TEmpresaList.SetItem(Index: Integer; Value: TEmpresa);
begin
  inherited SetItem(Index, Value);
end;

end.