unit uTransdfe;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTransdfe = class;
  TTransdfeClass = class of TTransdfe;

  TTransdfeList = class;
  TTransdfeListClass = class of TTransdfeList;

  TTransdfe = class(TmCollectionItem)
  private
    fId_Transacao: String;
    fNr_Sequencia: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fTp_Evento: Integer;
    fTp_Ambiente: Integer;
    fTp_Emissao: Integer;
    fDs_Envioxml: String;
    fDs_Retornoxml: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property Nr_Sequencia : Integer read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Evento : Integer read fTp_Evento write SetTp_Evento;
    property Tp_Ambiente : Integer read fTp_Ambiente write SetTp_Ambiente;
    property Tp_Emissao : Integer read fTp_Emissao write SetTp_Emissao;
    property Ds_Envioxml : String read fDs_Envioxml write SetDs_Envioxml;
    property Ds_Retornoxml : String read fDs_Retornoxml write SetDs_Retornoxml;
  end;

  TTransdfeList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransdfe;
    procedure SetItem(Index: Integer; Value: TTransdfe);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTransdfe;
    property Items[Index: Integer]: TTransdfe read GetItem write SetItem; default;
  end;

implementation

{ TTransdfe }

constructor TTransdfe.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTransdfe.Destroy;
begin

  inherited;
end;

{ TTransdfeList }

constructor TTransdfeList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTransdfe);
end;

function TTransdfeList.Add: TTransdfe;
begin
  Result := TTransdfe(inherited Add);
  Result.create;
end;

function TTransdfeList.GetItem(Index: Integer): TTransdfe;
begin
  Result := TTransdfe(inherited GetItem(Index));
end;

procedure TTransdfeList.SetItem(Index: Integer; Value: TTransdfe);
begin
  inherited SetItem(Index, Value);
end;

end.