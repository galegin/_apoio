unit uTefResposta;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Resposta = class;
  TTef_RespostaClass = class of TTef_Resposta;

  TTef_RespostaList = class;
  TTef_RespostaListClass = class of TTef_RespostaList;

  TTef_Resposta = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Lancamento: Real;
    fNr_Identificacao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Finalizacao: String;
    fDs_Mensagem: String;
    fDs_Cupom: String;
    fNr_Linhas: Real;
    fCd_Arquivo: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Lancamento : Real read fCd_Lancamento write fCd_Lancamento;
    property Nr_Identificacao : Real read fNr_Identificacao write fNr_Identificacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Finalizacao : String read fDs_Finalizacao write fDs_Finalizacao;
    property Ds_Mensagem : String read fDs_Mensagem write fDs_Mensagem;
    property Ds_Cupom : String read fDs_Cupom write fDs_Cupom;
    property Nr_Linhas : Real read fNr_Linhas write fNr_Linhas;
    property Cd_Arquivo : String read fCd_Arquivo write fCd_Arquivo;
  end;

  TTef_RespostaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Resposta;
    procedure SetItem(Index: Integer; Value: TTef_Resposta);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Resposta;
    property Items[Index: Integer]: TTef_Resposta read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Resposta }

constructor TTef_Resposta.Create;
begin

end;

destructor TTef_Resposta.Destroy;
begin

  inherited;
end;

{ TTef_RespostaList }

constructor TTef_RespostaList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Resposta);
end;

function TTef_RespostaList.Add: TTef_Resposta;
begin
  Result := TTef_Resposta(inherited Add);
  Result.create;
end;

function TTef_RespostaList.GetItem(Index: Integer): TTef_Resposta;
begin
  Result := TTef_Resposta(inherited GetItem(Index));
end;

procedure TTef_RespostaList.SetItem(Index: Integer; Value: TTef_Resposta);
begin
  inherited SetItem(Index, Value);
end;

end.