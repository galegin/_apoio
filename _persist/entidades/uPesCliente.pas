unit uPesCliente;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Cliente = class;
  TPes_ClienteClass = class of TPes_Cliente;

  TPes_ClienteList = class;
  TPes_ClienteListClass = class of TPes_ClienteList;

  TPes_Cliente = class(TcCollectionItem)
  private
    fCd_Cliente: Real;
    fU_Version: String;
    fTp_Formapgto: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Bloqueado: String;
    fIn_Cnsrfinal: String;
    fIn_Inativo: String;
    fNr_Suframa: Real;
    fNr_Codigofiscal: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Formapgto : Real read fTp_Formapgto write fTp_Formapgto;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Bloqueado : String read fIn_Bloqueado write fIn_Bloqueado;
    property In_Cnsrfinal : String read fIn_Cnsrfinal write fIn_Cnsrfinal;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property Nr_Suframa : Real read fNr_Suframa write fNr_Suframa;
    property Nr_Codigofiscal : String read fNr_Codigofiscal write fNr_Codigofiscal;
  end;

  TPes_ClienteList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Cliente;
    procedure SetItem(Index: Integer; Value: TPes_Cliente);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Cliente;
    property Items[Index: Integer]: TPes_Cliente read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Cliente }

constructor TPes_Cliente.Create;
begin

end;

destructor TPes_Cliente.Destroy;
begin

  inherited;
end;

{ TPes_ClienteList }

constructor TPes_ClienteList.Create(AOwner: TPersistent);
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