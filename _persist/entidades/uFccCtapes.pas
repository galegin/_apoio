unit uFccCtapes;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcc_Ctapes = class;
  TFcc_CtapesClass = class of TFcc_Ctapes;

  TFcc_CtapesList = class;
  TFcc_CtapesListClass = class of TFcc_CtapesList;

  TFcc_Ctapes = class(TcCollectionItem)
  private
    fNr_Ctapes: Real;
    fU_Version: String;
    fIn_Natureza: String;
    fNr_Situacao: Real;
    fCd_Empresa: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Dgcta: String;
    fIn_Ativo: String;
    fTp_Conta: Real;
    fTp_Manutencao: Real;
    fCd_Moeda: Real;
    fNr_Banco: Real;
    fNr_Agencia: Real;
    fPr_Taxajuros: Real;
    fNr_Modfinc: Real;
    fCd_Emppagto: Real;
    fCd_Pessoa: Real;
    fCd_Opercaixa: Real;
    fDt_Limitevenc: TDateTime;
    fDt_Abertura: TDateTime;
    fVl_Limite: Real;
    fDs_Conta: String;
    fDs_Titular: String;
    fTp_Arqeletronico: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property U_Version : String read fU_Version write fU_Version;
    property In_Natureza : String read fIn_Natureza write fIn_Natureza;
    property Nr_Situacao : Real read fNr_Situacao write fNr_Situacao;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Dgcta : String read fDs_Dgcta write fDs_Dgcta;
    property In_Ativo : String read fIn_Ativo write fIn_Ativo;
    property Tp_Conta : Real read fTp_Conta write fTp_Conta;
    property Tp_Manutencao : Real read fTp_Manutencao write fTp_Manutencao;
    property Cd_Moeda : Real read fCd_Moeda write fCd_Moeda;
    property Nr_Banco : Real read fNr_Banco write fNr_Banco;
    property Nr_Agencia : Real read fNr_Agencia write fNr_Agencia;
    property Pr_Taxajuros : Real read fPr_Taxajuros write fPr_Taxajuros;
    property Nr_Modfinc : Real read fNr_Modfinc write fNr_Modfinc;
    property Cd_Emppagto : Real read fCd_Emppagto write fCd_Emppagto;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Cd_Opercaixa : Real read fCd_Opercaixa write fCd_Opercaixa;
    property Dt_Limitevenc : TDateTime read fDt_Limitevenc write fDt_Limitevenc;
    property Dt_Abertura : TDateTime read fDt_Abertura write fDt_Abertura;
    property Vl_Limite : Real read fVl_Limite write fVl_Limite;
    property Ds_Conta : String read fDs_Conta write fDs_Conta;
    property Ds_Titular : String read fDs_Titular write fDs_Titular;
    property Tp_Arqeletronico : Real read fTp_Arqeletronico write fTp_Arqeletronico;
  end;

  TFcc_CtapesList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcc_Ctapes;
    procedure SetItem(Index: Integer; Value: TFcc_Ctapes);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcc_Ctapes;
    property Items[Index: Integer]: TFcc_Ctapes read GetItem write SetItem; default;
  end;
  
implementation

{ TFcc_Ctapes }

constructor TFcc_Ctapes.Create;
begin

end;

destructor TFcc_Ctapes.Destroy;
begin

  inherited;
end;

{ TFcc_CtapesList }

constructor TFcc_CtapesList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcc_Ctapes);
end;

function TFcc_CtapesList.Add: TFcc_Ctapes;
begin
  Result := TFcc_Ctapes(inherited Add);
  Result.create;
end;

function TFcc_CtapesList.GetItem(Index: Integer): TFcc_Ctapes;
begin
  Result := TFcc_Ctapes(inherited GetItem(Index));
end;

procedure TFcc_CtapesList.SetItem(Index: Integer; Value: TFcc_Ctapes);
begin
  inherited SetItem(Index, Value);
end;

end.