unit uAdmRestricaousu;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TAdm_Restricaousu = class;
  TAdm_RestricaousuClass = class of TAdm_Restricaousu;

  TAdm_RestricaousuList = class;
  TAdm_RestricaousuListClass = class of TAdm_RestricaousuList;

  TAdm_Restricaousu = class(TmCollectionItem)
  private
    fCd_Componente: String;
    fDs_Campo: String;
    fCd_Empresa: String;
    fCd_Usuario: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fVl_Inicio: String;
    fVl_Fim: String;
    fIn_Semrestricao: String;
    fIn_Pedesenha: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Componente : String read fCd_Componente write SetCd_Componente;
    property Ds_Campo : String read fDs_Campo write SetDs_Campo;
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Usuario : String read fCd_Usuario write SetCd_Usuario;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Vl_Inicio : String read fVl_Inicio write SetVl_Inicio;
    property Vl_Fim : String read fVl_Fim write SetVl_Fim;
    property In_Semrestricao : String read fIn_Semrestricao write SetIn_Semrestricao;
    property In_Pedesenha : String read fIn_Pedesenha write SetIn_Pedesenha;
  end;

  TAdm_RestricaousuList = class(TmCollection)
  private
    function GetItem(Index: Integer): TAdm_Restricaousu;
    procedure SetItem(Index: Integer; Value: TAdm_Restricaousu);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TAdm_Restricaousu;
    property Items[Index: Integer]: TAdm_Restricaousu read GetItem write SetItem; default;
  end;

implementation

{ TAdm_Restricaousu }

constructor TAdm_Restricaousu.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TAdm_Restricaousu.Destroy;
begin

  inherited;
end;

{ TAdm_RestricaousuList }

constructor TAdm_RestricaousuList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TAdm_Restricaousu);
end;

function TAdm_RestricaousuList.Add: TAdm_Restricaousu;
begin
  Result := TAdm_Restricaousu(inherited Add);
  Result.create;
end;

function TAdm_RestricaousuList.GetItem(Index: Integer): TAdm_Restricaousu;
begin
  Result := TAdm_Restricaousu(inherited GetItem(Index));
end;

procedure TAdm_RestricaousuList.SetItem(Index: Integer; Value: TAdm_Restricaousu);
begin
  inherited SetItem(Index, Value);
end;

end.