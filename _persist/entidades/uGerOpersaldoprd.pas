unit uGerOpersaldoprd;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Opersaldoprd = class;
  TGer_OpersaldoprdClass = class of TGer_Opersaldoprd;

  TGer_OpersaldoprdList = class;
  TGer_OpersaldoprdListClass = class of TGer_OpersaldoprdList;

  TGer_Opersaldoprd = class(TcCollectionItem)
  private
    fCd_Operacao: Real;
    fCd_Saldo: Real;
    fU_Version: String;
    fTp_Operacao: String;
    fTp_Mvto: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Historico: Real;
    fIn_Gerakardex: String;
    fIn_Estorno: String;
    fIn_Padrao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property Cd_Saldo : Real read fCd_Saldo write fCd_Saldo;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Tp_Mvto : String read fTp_Mvto write fTp_Mvto;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Historico : Real read fCd_Historico write fCd_Historico;
    property In_Gerakardex : String read fIn_Gerakardex write fIn_Gerakardex;
    property In_Estorno : String read fIn_Estorno write fIn_Estorno;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
  end;

  TGer_OpersaldoprdList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Opersaldoprd;
    procedure SetItem(Index: Integer; Value: TGer_Opersaldoprd);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Opersaldoprd;
    property Items[Index: Integer]: TGer_Opersaldoprd read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Opersaldoprd }

constructor TGer_Opersaldoprd.Create;
begin

end;

destructor TGer_Opersaldoprd.Destroy;
begin

  inherited;
end;

{ TGer_OpersaldoprdList }

constructor TGer_OpersaldoprdList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Opersaldoprd);
end;

function TGer_OpersaldoprdList.Add: TGer_Opersaldoprd;
begin
  Result := TGer_Opersaldoprd(inherited Add);
  Result.create;
end;

function TGer_OpersaldoprdList.GetItem(Index: Integer): TGer_Opersaldoprd;
begin
  Result := TGer_Opersaldoprd(inherited GetItem(Index));
end;

procedure TGer_OpersaldoprdList.SetItem(Index: Integer; Value: TGer_Opersaldoprd);
begin
  inherited SetItem(Index, Value);
end;

end.