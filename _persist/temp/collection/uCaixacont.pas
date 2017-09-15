unit uCaixacont;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TCaixacont = class;
  TCaixacontClass = class of TCaixacont;

  TCaixacontList = class;
  TCaixacontListClass = class of TCaixacontList;

  TCaixacont = class(TmCollectionItem)
  private
    fId_Caixa: Integer;
    fId_Histrel: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fVl_Contado: String;
    fVl_Sistema: String;
    fVl_Retirada: String;
    fVl_Suprimento: String;
    fVl_Diferenca: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Caixa : Integer read fId_Caixa write SetId_Caixa;
    property Id_Histrel : Integer read fId_Histrel write SetId_Histrel;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Vl_Contado : String read fVl_Contado write SetVl_Contado;
    property Vl_Sistema : String read fVl_Sistema write SetVl_Sistema;
    property Vl_Retirada : String read fVl_Retirada write SetVl_Retirada;
    property Vl_Suprimento : String read fVl_Suprimento write SetVl_Suprimento;
    property Vl_Diferenca : String read fVl_Diferenca write SetVl_Diferenca;
  end;

  TCaixacontList = class(TmCollection)
  private
    function GetItem(Index: Integer): TCaixacont;
    procedure SetItem(Index: Integer; Value: TCaixacont);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TCaixacont;
    property Items[Index: Integer]: TCaixacont read GetItem write SetItem; default;
  end;

implementation

{ TCaixacont }

constructor TCaixacont.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TCaixacont.Destroy;
begin

  inherited;
end;

{ TCaixacontList }

constructor TCaixacontList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TCaixacont);
end;

function TCaixacontList.Add: TCaixacont;
begin
  Result := TCaixacont(inherited Add);
  Result.create;
end;

function TCaixacontList.GetItem(Index: Integer): TCaixacont;
begin
  Result := TCaixacont(inherited GetItem(Index));
end;

procedure TCaixacontList.SetItem(Index: Integer; Value: TCaixacont);
begin
  inherited SetItem(Index, Value);
end;

end.