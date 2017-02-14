unit uTefArquivo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Arquivo = class;
  TTef_ArquivoClass = class of TTef_Arquivo;

  TTef_ArquivoList = class;
  TTef_ArquivoListClass = class of TTef_ArquivoList;

  TTef_Arquivo = class(TcCollectionItem)
  private
    fTp_Tef: Real;
    fCd_Arquivo: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Arquivo: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Tef : Real read fTp_Tef write fTp_Tef;
    property Cd_Arquivo : String read fCd_Arquivo write fCd_Arquivo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Arquivo : String read fNm_Arquivo write fNm_Arquivo;
  end;

  TTef_ArquivoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Arquivo;
    procedure SetItem(Index: Integer; Value: TTef_Arquivo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Arquivo;
    property Items[Index: Integer]: TTef_Arquivo read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Arquivo }

constructor TTef_Arquivo.Create;
begin

end;

destructor TTef_Arquivo.Destroy;
begin

  inherited;
end;

{ TTef_ArquivoList }

constructor TTef_ArquivoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Arquivo);
end;

function TTef_ArquivoList.Add: TTef_Arquivo;
begin
  Result := TTef_Arquivo(inherited Add);
  Result.create;
end;

function TTef_ArquivoList.GetItem(Index: Integer): TTef_Arquivo;
begin
  Result := TTef_Arquivo(inherited GetItem(Index));
end;

procedure TTef_ArquivoList.SetItem(Index: Integer; Value: TTef_Arquivo);
begin
  inherited SetItem(Index, Value);
end;

end.