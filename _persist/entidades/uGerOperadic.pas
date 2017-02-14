unit uGerOperadic;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Operadic = class;
  TGer_OperadicClass = class of TGer_Operadic;

  TGer_OperadicList = class;
  TGer_OperadicListClass = class of TGer_OperadicList;

  TGer_Operadic = class(TcCollectionItem)
  private
    fCd_Operacao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Calccustocontabil: Real;
    fTp_Validasaldo: Real;
    fTp_Contabilizacao: Real;
    fIn_Inativo: String;
    fTp_Validasaldoneg: Real;
    fTp_Moddctonf: Real;
    fIn_Esttransito: String;
    fTp_Finalidadenfe: Real;
    fTp_Indpres: Real;
    fTp_Impdanfe: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Calccustocontabil : Real read fTp_Calccustocontabil write fTp_Calccustocontabil;
    property Tp_Validasaldo : Real read fTp_Validasaldo write fTp_Validasaldo;
    property Tp_Contabilizacao : Real read fTp_Contabilizacao write fTp_Contabilizacao;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property Tp_Validasaldoneg : Real read fTp_Validasaldoneg write fTp_Validasaldoneg;
    property Tp_Moddctonf : Real read fTp_Moddctonf write fTp_Moddctonf;
    property In_Esttransito : String read fIn_Esttransito write fIn_Esttransito;
    property Tp_Finalidadenfe : Real read fTp_Finalidadenfe write fTp_Finalidadenfe;
    property Tp_Indpres : Real read fTp_Indpres write fTp_Indpres;
    property Tp_Impdanfe : Real read fTp_Impdanfe write fTp_Impdanfe;
  end;

  TGer_OperadicList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Operadic;
    procedure SetItem(Index: Integer; Value: TGer_Operadic);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Operadic;
    property Items[Index: Integer]: TGer_Operadic read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Operadic }

constructor TGer_Operadic.Create;
begin

end;

destructor TGer_Operadic.Destroy;
begin

  inherited;
end;

{ TGer_OperadicList }

constructor TGer_OperadicList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Operadic);
end;

function TGer_OperadicList.Add: TGer_Operadic;
begin
  Result := TGer_Operadic(inherited Add);
  Result.create;
end;

function TGer_OperadicList.GetItem(Index: Integer): TGer_Operadic;
begin
  Result := TGer_Operadic(inherited GetItem(Index));
end;

procedure TGer_OperadicList.SetItem(Index: Integer; Value: TGer_Operadic);
begin
  inherited SetItem(Index, Value);
end;

end.