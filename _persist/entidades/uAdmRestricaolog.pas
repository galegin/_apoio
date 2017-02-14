unit uAdmRestricaolog;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Restricaolog = class;
  TAdm_RestricaologClass = class of TAdm_Restricaolog;

  TAdm_RestricaologList = class;
  TAdm_RestricaologListClass = class of TAdm_RestricaologList;

  TAdm_Restricaolog = class(TcCollectionItem)
  private
    fDt_Restricao: TDateTime;
    fHr_Restricao: TDateTime;
    fCd_Componente: String;
    fDs_Campo: String;
    fCd_Empresa: Real;
    fCd_Usuario: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Restricaolog: Real;
    fCd_Usuariolib: Real;
    fVl_Iniciooriginal: Real;
    fVl_Fimoriginal: Real;
    fVl_Atual: Real;
    fVl_Novo: Real;
    fVl_Diferenca: Real;
    fDs_Aux: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Dt_Restricao : TDateTime read fDt_Restricao write fDt_Restricao;
    property Hr_Restricao : TDateTime read fHr_Restricao write fHr_Restricao;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Ds_Campo : String read fDs_Campo write fDs_Campo;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Restricaolog : Real read fTp_Restricaolog write fTp_Restricaolog;
    property Cd_Usuariolib : Real read fCd_Usuariolib write fCd_Usuariolib;
    property Vl_Iniciooriginal : Real read fVl_Iniciooriginal write fVl_Iniciooriginal;
    property Vl_Fimoriginal : Real read fVl_Fimoriginal write fVl_Fimoriginal;
    property Vl_Atual : Real read fVl_Atual write fVl_Atual;
    property Vl_Novo : Real read fVl_Novo write fVl_Novo;
    property Vl_Diferenca : Real read fVl_Diferenca write fVl_Diferenca;
    property Ds_Aux : String read fDs_Aux write fDs_Aux;
  end;

  TAdm_RestricaologList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Restricaolog;
    procedure SetItem(Index: Integer; Value: TAdm_Restricaolog);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Restricaolog;
    property Items[Index: Integer]: TAdm_Restricaolog read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Restricaolog }

constructor TAdm_Restricaolog.Create;
begin

end;

destructor TAdm_Restricaolog.Destroy;
begin

  inherited;
end;

{ TAdm_RestricaologList }

constructor TAdm_RestricaologList.Create(AOwner: TPersistent);
begin
  inherited Create(TAdm_Restricaolog);
end;

function TAdm_RestricaologList.Add: TAdm_Restricaolog;
begin
  Result := TAdm_Restricaolog(inherited Add);
  Result.create;
end;

function TAdm_RestricaologList.GetItem(Index: Integer): TAdm_Restricaolog;
begin
  Result := TAdm_Restricaolog(inherited GetItem(Index));
end;

procedure TAdm_RestricaologList.SetItem(Index: Integer; Value: TAdm_Restricaolog);
begin
  inherited SetItem(Index, Value);
end;

end.