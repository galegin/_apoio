unit uGerOperadic;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Operadic = class;
  TGer_OperadicClass = class of TGer_Operadic;

  TGer_OperadicList = class;
  TGer_OperadicListClass = class of TGer_OperadicList;

  TGer_Operadic = class(TmCollectionItem)
  private
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Calccustocontabil: String;
    fTp_Validasaldo: String;
    fTp_Contabilizacao: String;
    fIn_Inativo: String;
    fTp_Validasaldoneg: String;
    fTp_Moddctonf: String;
    fIn_Esttransito: String;
    fTp_Finalidadenfe: String;
    fTp_Indpres: String;
    fTp_Impdanfe: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Calccustocontabil : String read fTp_Calccustocontabil write SetTp_Calccustocontabil;
    property Tp_Validasaldo : String read fTp_Validasaldo write SetTp_Validasaldo;
    property Tp_Contabilizacao : String read fTp_Contabilizacao write SetTp_Contabilizacao;
    property In_Inativo : String read fIn_Inativo write SetIn_Inativo;
    property Tp_Validasaldoneg : String read fTp_Validasaldoneg write SetTp_Validasaldoneg;
    property Tp_Moddctonf : String read fTp_Moddctonf write SetTp_Moddctonf;
    property In_Esttransito : String read fIn_Esttransito write SetIn_Esttransito;
    property Tp_Finalidadenfe : String read fTp_Finalidadenfe write SetTp_Finalidadenfe;
    property Tp_Indpres : String read fTp_Indpres write SetTp_Indpres;
    property Tp_Impdanfe : String read fTp_Impdanfe write SetTp_Impdanfe;
  end;

  TGer_OperadicList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Operadic;
    procedure SetItem(Index: Integer; Value: TGer_Operadic);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Operadic;
    property Items[Index: Integer]: TGer_Operadic read GetItem write SetItem; default;
  end;

implementation

{ TGer_Operadic }

constructor TGer_Operadic.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Operadic.Destroy;
begin

  inherited;
end;

{ TGer_OperadicList }

constructor TGer_OperadicList.Create(AOwner: TPersistentCollection);
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