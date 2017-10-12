unit uPesClientefpgto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Clientefpgto = class;
  TPes_ClientefpgtoClass = class of TPes_Clientefpgto;

  TPes_ClientefpgtoList = class;
  TPes_ClientefpgtoListClass = class of TPes_ClientefpgtoList;

  TPes_Clientefpgto = class(TmCollectionItem)
  private
    fCd_Cliente: String;
    fTp_Documento: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Cliente : String read fCd_Cliente write SetCd_Cliente;
    property Tp_Documento : String read fTp_Documento write SetTp_Documento;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TPes_ClientefpgtoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Clientefpgto;
    procedure SetItem(Index: Integer; Value: TPes_Clientefpgto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Clientefpgto;
    property Items[Index: Integer]: TPes_Clientefpgto read GetItem write SetItem; default;
  end;

implementation

{ TPes_Clientefpgto }

constructor TPes_Clientefpgto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Clientefpgto.Destroy;
begin

  inherited;
end;

{ TPes_ClientefpgtoList }

constructor TPes_ClientefpgtoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Clientefpgto);
end;

function TPes_ClientefpgtoList.Add: TPes_Clientefpgto;
begin
  Result := TPes_Clientefpgto(inherited Add);
  Result.create;
end;

function TPes_ClientefpgtoList.GetItem(Index: Integer): TPes_Clientefpgto;
begin
  Result := TPes_Clientefpgto(inherited GetItem(Index));
end;

procedure TPes_ClientefpgtoList.SetItem(Index: Integer; Value: TPes_Clientefpgto);
begin
  inherited SetItem(Index, Value);
end;

end.