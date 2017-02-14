unit uTraTransclas;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transclas = class;
  TTra_TransclasClass = class of TTra_Transclas;

  TTra_TransclasList = class;
  TTra_TransclasListClass = class of TTra_TransclasList;

  TTra_Transclas = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Tipoclas: Real;
    fCd_Classificacao: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TTra_TransclasList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transclas;
    procedure SetItem(Index: Integer; Value: TTra_Transclas);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transclas;
    property Items[Index: Integer]: TTra_Transclas read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transclas }

constructor TTra_Transclas.Create;
begin

end;

destructor TTra_Transclas.Destroy;
begin

  inherited;
end;

{ TTra_TransclasList }

constructor TTra_TransclasList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transclas);
end;

function TTra_TransclasList.Add: TTra_Transclas;
begin
  Result := TTra_Transclas(inherited Add);
  Result.create;
end;

function TTra_TransclasList.GetItem(Index: Integer): TTra_Transclas;
begin
  Result := TTra_Transclas(inherited GetItem(Index));
end;

procedure TTra_TransclasList.SetItem(Index: Integer; Value: TTra_Transclas);
begin
  inherited SetItem(Index, Value);
end;

end.