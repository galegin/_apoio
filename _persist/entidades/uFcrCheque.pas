unit uFcrCheque;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcr_Cheque = class;
  TFcr_ChequeClass = class of TFcr_Cheque;

  TFcr_ChequeList = class;
  TFcr_ChequeListClass = class of TFcr_ChequeList;

  TFcr_Cheque = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Cliente: Real;
    fNr_Fat: Real;
    fNr_Parcela: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Compensado: String;
    fCd_Motdevchq: Real;
    fCd_Motdevchq2: Real;
    fNr_Banco: Real;
    fNr_Agencia: Real;
    fNr_Cheque: Real;
    fDt_Devolucao1: TDateTime;
    fDt_Devolucao2: TDateTime;
    fDs_Documento: String;
    fDs_Telefone: String;
    fDs_Conta: String;
    fDs_Banda: String;
    fIn_Reapresenta: String;
    fIn_Terceiro: String;
    fNr_Ctapesdev1: Real;
    fNr_Ctapesdev2: Real;
    fDt_Baixa1: TDateTime;
    fDt_Baixa2: TDateTime;
    fNr_Ctapesbx1: Real;
    fNr_Ctapesbx2: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property Nr_Fat : Real read fNr_Fat write fNr_Fat;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Compensado : String read fIn_Compensado write fIn_Compensado;
    property Cd_Motdevchq : Real read fCd_Motdevchq write fCd_Motdevchq;
    property Cd_Motdevchq2 : Real read fCd_Motdevchq2 write fCd_Motdevchq2;
    property Nr_Banco : Real read fNr_Banco write fNr_Banco;
    property Nr_Agencia : Real read fNr_Agencia write fNr_Agencia;
    property Nr_Cheque : Real read fNr_Cheque write fNr_Cheque;
    property Dt_Devolucao1 : TDateTime read fDt_Devolucao1 write fDt_Devolucao1;
    property Dt_Devolucao2 : TDateTime read fDt_Devolucao2 write fDt_Devolucao2;
    property Ds_Documento : String read fDs_Documento write fDs_Documento;
    property Ds_Telefone : String read fDs_Telefone write fDs_Telefone;
    property Ds_Conta : String read fDs_Conta write fDs_Conta;
    property Ds_Banda : String read fDs_Banda write fDs_Banda;
    property In_Reapresenta : String read fIn_Reapresenta write fIn_Reapresenta;
    property In_Terceiro : String read fIn_Terceiro write fIn_Terceiro;
    property Nr_Ctapesdev1 : Real read fNr_Ctapesdev1 write fNr_Ctapesdev1;
    property Nr_Ctapesdev2 : Real read fNr_Ctapesdev2 write fNr_Ctapesdev2;
    property Dt_Baixa1 : TDateTime read fDt_Baixa1 write fDt_Baixa1;
    property Dt_Baixa2 : TDateTime read fDt_Baixa2 write fDt_Baixa2;
    property Nr_Ctapesbx1 : Real read fNr_Ctapesbx1 write fNr_Ctapesbx1;
    property Nr_Ctapesbx2 : Real read fNr_Ctapesbx2 write fNr_Ctapesbx2;
  end;

  TFcr_ChequeList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcr_Cheque;
    procedure SetItem(Index: Integer; Value: TFcr_Cheque);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcr_Cheque;
    property Items[Index: Integer]: TFcr_Cheque read GetItem write SetItem; default;
  end;
  
implementation

{ TFcr_Cheque }

constructor TFcr_Cheque.Create;
begin

end;

destructor TFcr_Cheque.Destroy;
begin

  inherited;
end;

{ TFcr_ChequeList }

constructor TFcr_ChequeList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcr_Cheque);
end;

function TFcr_ChequeList.Add: TFcr_Cheque;
begin
  Result := TFcr_Cheque(inherited Add);
  Result.create;
end;

function TFcr_ChequeList.GetItem(Index: Integer): TFcr_Cheque;
begin
  Result := TFcr_Cheque(inherited GetItem(Index));
end;

procedure TFcr_ChequeList.SetItem(Index: Integer; Value: TFcr_Cheque);
begin
  inherited SetItem(Index, Value);
end;

end.