unit uPesCliente;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Cliente = class;
  TPes_ClienteClass = class of TPes_Cliente;

  TPes_ClienteList = class;
  TPes_ClienteListClass = class of TPes_ClienteList;

  TPes_Cliente = class(TmCollectionItem)
  private
    fCd_Cliente: String;
    fU_Version: String;
    fTp_Formapgto: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Bloqueado: String;
    fIn_Cnsrfinal: String;
    fIn_Inativo: String;
    fNr_Suframa: String;
    fNr_Codigofiscal: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Cliente : String read fCd_Cliente write SetCd_Cliente;
    property U_Version : String read fU_Version write SetU_Version;
    property Tp_Formapgto : String read fTp_Formapgto write SetTp_Formapgto;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Bloqueado : String read fIn_Bloqueado write SetIn_Bloqueado;
    property In_Cnsrfinal : String read fIn_Cnsrfinal write SetIn_Cnsrfinal;
    property In_Inativo : String read fIn_Inativo write SetIn_Inativo;
    property Nr_Suframa : String read fNr_Suframa write SetNr_Suframa;
    property Nr_Codigofiscal : String read fNr_Codigofiscal write SetNr_Codigofiscal;
  end;

  TPes_ClienteList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Cliente;
    procedure SetItem(Index: Integer; Value: TPes_Cliente);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Cliente;
    property Items[Index: Integer]: TPes_Cliente read GetItem write SetItem; default;
  end;

implementation

{ TPes_Cliente }

constructor TPes_Cliente.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Cliente.Destroy;
begin

  inherited;
end;

{ TPes_ClienteList }

constructor TPes_ClienteList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Cliente);
end;

function TPes_ClienteList.Add: TPes_Cliente;
begin
  Result := TPes_Cliente(inherited Add);
  Result.create;
end;

function TPes_ClienteList.GetItem(Index: Integer): TPes_Cliente;
begin
  Result := TPes_Cliente(inherited GetItem(Index));
end;

procedure TPes_ClienteList.SetItem(Index: Integer; Value: TPes_Cliente);
begin
  inherited SetItem(Index, Value);
end;

end.