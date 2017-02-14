unit uObsFati;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TObs_Fati = class;
  TObs_FatiClass = class of TObs_Fati;

  TObs_FatiList = class;
  TObs_FatiListClass = class of TObs_FatiList;

  TObs_Fati = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Cliente: Real;
    fNr_Fat: Real;
    fNr_Parcela: Real;
    fNr_Linha: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Manutencao: String;
    fCd_Componente: String;
    fDs_Observacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property Nr_Fat : Real read fNr_Fat write fNr_Fat;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property Nr_Linha : Real read fNr_Linha write fNr_Linha;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Manutencao : String read fIn_Manutencao write fIn_Manutencao;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TObs_FatiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TObs_Fati;
    procedure SetItem(Index: Integer; Value: TObs_Fati);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TObs_Fati;
    property Items[Index: Integer]: TObs_Fati read GetItem write SetItem; default;
  end;
  
implementation

{ TObs_Fati }

constructor TObs_Fati.Create;
begin

end;

destructor TObs_Fati.Destroy;
begin

  inherited;
end;

{ TObs_FatiList }

constructor TObs_FatiList.Create(AOwner: TPersistent);
begin
  inherited Create(TObs_Fati);
end;

function TObs_FatiList.Add: TObs_Fati;
begin
  Result := TObs_Fati(inherited Add);
  Result.create;
end;

function TObs_FatiList.GetItem(Index: Integer): TObs_Fati;
begin
  Result := TObs_Fati(inherited GetItem(Index));
end;

procedure TObs_FatiList.SetItem(Index: Integer; Value: TObs_Fati);
begin
  inherited SetItem(Index, Value);
end;

end.