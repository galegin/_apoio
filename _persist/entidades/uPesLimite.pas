unit uPesLimite;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Limite = class;
  TPes_LimiteClass = class of TPes_Limite;

  TPes_LimiteList = class;
  TPes_LimiteListClass = class of TPes_LimiteList;

  TPes_Limite = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fNr_Sequencial: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Empresa: Real;
    fCd_Sitantes: String;
    fVl_Limantes: Real;
    fVl_Salantes: Real;
    fTp_Operacao: Real;
    fDs_Operacao: String;
    fCd_Empoper: Real;
    fVl_Operacao: Real;
    fCd_Sitapos: String;
    fVl_Limapos: Real;
    fVl_Salapos: Real;
    fCd_Autorizador: Real;
    fCd_Componente: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Nr_Sequencial : Real read fNr_Sequencial write fNr_Sequencial;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Sitantes : String read fCd_Sitantes write fCd_Sitantes;
    property Vl_Limantes : Real read fVl_Limantes write fVl_Limantes;
    property Vl_Salantes : Real read fVl_Salantes write fVl_Salantes;
    property Tp_Operacao : Real read fTp_Operacao write fTp_Operacao;
    property Ds_Operacao : String read fDs_Operacao write fDs_Operacao;
    property Cd_Empoper : Real read fCd_Empoper write fCd_Empoper;
    property Vl_Operacao : Real read fVl_Operacao write fVl_Operacao;
    property Cd_Sitapos : String read fCd_Sitapos write fCd_Sitapos;
    property Vl_Limapos : Real read fVl_Limapos write fVl_Limapos;
    property Vl_Salapos : Real read fVl_Salapos write fVl_Salapos;
    property Cd_Autorizador : Real read fCd_Autorizador write fCd_Autorizador;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
  end;

  TPes_LimiteList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Limite;
    procedure SetItem(Index: Integer; Value: TPes_Limite);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Limite;
    property Items[Index: Integer]: TPes_Limite read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Limite }

constructor TPes_Limite.Create;
begin

end;

destructor TPes_Limite.Destroy;
begin

  inherited;
end;

{ TPes_LimiteList }

constructor TPes_LimiteList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Limite);
end;

function TPes_LimiteList.Add: TPes_Limite;
begin
  Result := TPes_Limite(inherited Add);
  Result.create;
end;

function TPes_LimiteList.GetItem(Index: Integer): TPes_Limite;
begin
  Result := TPes_Limite(inherited GetItem(Index));
end;

procedure TPes_LimiteList.SetItem(Index: Integer; Value: TPes_Limite);
begin
  inherited SetItem(Index, Value);
end;

end.