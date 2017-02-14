unit uAdmRestricaousu;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Restricaousu = class;
  TAdm_RestricaousuClass = class of TAdm_Restricaousu;

  TAdm_RestricaousuList = class;
  TAdm_RestricaousuListClass = class of TAdm_RestricaousuList;

  TAdm_Restricaousu = class(TcCollectionItem)
  private
    fCd_Componente: String;
    fDs_Campo: String;
    fCd_Empresa: Real;
    fCd_Usuario: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Inicio: Real;
    fVl_Fim: Real;
    fIn_Semrestricao: String;
    fIn_Pedesenha: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Ds_Campo : String read fDs_Campo write fDs_Campo;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Inicio : Real read fVl_Inicio write fVl_Inicio;
    property Vl_Fim : Real read fVl_Fim write fVl_Fim;
    property In_Semrestricao : String read fIn_Semrestricao write fIn_Semrestricao;
    property In_Pedesenha : String read fIn_Pedesenha write fIn_Pedesenha;
  end;

  TAdm_RestricaousuList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Restricaousu;
    procedure SetItem(Index: Integer; Value: TAdm_Restricaousu);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Restricaousu;
    property Items[Index: Integer]: TAdm_Restricaousu read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Restricaousu }

constructor TAdm_Restricaousu.Create;
begin

end;

destructor TAdm_Restricaousu.Destroy;
begin

  inherited;
end;

{ TAdm_RestricaousuList }

constructor TAdm_RestricaousuList.Create(AOwner: TPersistent);
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