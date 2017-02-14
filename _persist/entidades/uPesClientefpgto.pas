unit uPesClientefpgto;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Clientefpgto = class;
  TPes_ClientefpgtoClass = class of TPes_Clientefpgto;

  TPes_ClientefpgtoList = class;
  TPes_ClientefpgtoListClass = class of TPes_ClientefpgtoList;

  TPes_Clientefpgto = class(TcCollectionItem)
  private
    fCd_Cliente: Real;
    fTp_Documento: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPes_ClientefpgtoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Clientefpgto;
    procedure SetItem(Index: Integer; Value: TPes_Clientefpgto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Clientefpgto;
    property Items[Index: Integer]: TPes_Clientefpgto read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Clientefpgto }

constructor TPes_Clientefpgto.Create;
begin

end;

destructor TPes_Clientefpgto.Destroy;
begin

  inherited;
end;

{ TPes_ClientefpgtoList }

constructor TPes_ClientefpgtoList.Create(AOwner: TPersistent);
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