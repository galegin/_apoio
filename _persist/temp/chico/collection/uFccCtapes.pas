unit uFccCtapes;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFcc_Ctapes = class;
  TFcc_CtapesClass = class of TFcc_Ctapes;

  TFcc_CtapesList = class;
  TFcc_CtapesListClass = class of TFcc_CtapesList;

  TFcc_Ctapes = class(TmCollectionItem)
  private
    fNr_Ctapes: String;
    fU_Version: String;
    fIn_Natureza: String;
    fNr_Situacao: String;
    fCd_Empresa: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Dgcta: String;
    fIn_Ativo: String;
    fTp_Conta: String;
    fTp_Manutencao: String;
    fCd_Moeda: String;
    fNr_Banco: String;
    fNr_Agencia: String;
    fPr_Taxajuros: String;
    fNr_Modfinc: String;
    fCd_Emppagto: String;
    fCd_Pessoa: String;
    fCd_Opercaixa: String;
    fDt_Limitevenc: String;
    fDt_Abertura: String;
    fVl_Limite: String;
    fDs_Conta: String;
    fDs_Titular: String;
    fTp_Arqeletronico: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Nr_Ctapes : String read fNr_Ctapes write SetNr_Ctapes;
    property U_Version : String read fU_Version write SetU_Version;
    property In_Natureza : String read fIn_Natureza write SetIn_Natureza;
    property Nr_Situacao : String read fNr_Situacao write SetNr_Situacao;
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Dgcta : String read fDs_Dgcta write SetDs_Dgcta;
    property In_Ativo : String read fIn_Ativo write SetIn_Ativo;
    property Tp_Conta : String read fTp_Conta write SetTp_Conta;
    property Tp_Manutencao : String read fTp_Manutencao write SetTp_Manutencao;
    property Cd_Moeda : String read fCd_Moeda write SetCd_Moeda;
    property Nr_Banco : String read fNr_Banco write SetNr_Banco;
    property Nr_Agencia : String read fNr_Agencia write SetNr_Agencia;
    property Pr_Taxajuros : String read fPr_Taxajuros write SetPr_Taxajuros;
    property Nr_Modfinc : String read fNr_Modfinc write SetNr_Modfinc;
    property Cd_Emppagto : String read fCd_Emppagto write SetCd_Emppagto;
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Cd_Opercaixa : String read fCd_Opercaixa write SetCd_Opercaixa;
    property Dt_Limitevenc : String read fDt_Limitevenc write SetDt_Limitevenc;
    property Dt_Abertura : String read fDt_Abertura write SetDt_Abertura;
    property Vl_Limite : String read fVl_Limite write SetVl_Limite;
    property Ds_Conta : String read fDs_Conta write SetDs_Conta;
    property Ds_Titular : String read fDs_Titular write SetDs_Titular;
    property Tp_Arqeletronico : String read fTp_Arqeletronico write SetTp_Arqeletronico;
  end;

  TFcc_CtapesList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFcc_Ctapes;
    procedure SetItem(Index: Integer; Value: TFcc_Ctapes);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFcc_Ctapes;
    property Items[Index: Integer]: TFcc_Ctapes read GetItem write SetItem; default;
  end;

implementation

{ TFcc_Ctapes }

constructor TFcc_Ctapes.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFcc_Ctapes.Destroy;
begin

  inherited;
end;

{ TFcc_CtapesList }

constructor TFcc_CtapesList.Create(AOwner: TPersistentCollection);
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