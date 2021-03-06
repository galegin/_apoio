unit uNcm;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem, mMapping;

type
  [Tabela('NCM')]
  TNcm = class(TmCollectionItem)
  private
    fCd_Ncm: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Ncm: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    [Campo('CD_NCM', tfKey)]
    property Cd_Ncm : String read fCd_Ncm write fCd_Ncm;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_NCM', tfReq)]
    property Ds_Ncm : String read fDs_Ncm write fDs_Ncm;
  end;

  TNcms = class(TmCollection)
  private
    function GetItem(Index: Integer): TNcm;
    procedure SetItem(Index: Integer; Value: TNcm);
  public
    constructor Create(AItemClass: TCollectionItemClass); override;
    function Add: TNcm;
    property Items[Index: Integer]: TNcm read GetItem write SetItem; default;
  end;

implementation

{ TNcm }

constructor TNcm.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TNcm.Destroy;
begin

  inherited;
end;

{ TNcms }

constructor TNcms.Create(AItemClass: TCollectionItemClass);
begin
  inherited Create(TNcm);
end;

function TNcms.Add: TNcm;
begin
  Result := TNcm(inherited Add);
end;

function TNcms.GetItem(Index: Integer): TNcm;
begin
  Result := TNcm(inherited GetItem(Index));
end;

procedure TNcms.SetItem(Index: Integer; Value: TNcm);
begin
  inherited SetItem(Index, Value);
end;

end.