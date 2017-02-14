unit uTefCampoarq;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Campoarq = class;
  TTef_CampoarqClass = class of TTef_Campoarq;

  TTef_CampoarqList = class;
  TTef_CampoarqListClass = class of TTef_CampoarqList;

  TTef_Campoarq = class(TcCollectionItem)
  private
    fTp_Tef: Real;
    fCd_Arquivo: String;
    fNr_Campo: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Obrigatorio: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Tef : Real read fTp_Tef write fTp_Tef;
    property Cd_Arquivo : String read fCd_Arquivo write fCd_Arquivo;
    property Nr_Campo : String read fNr_Campo write fNr_Campo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Obrigatorio : String read fIn_Obrigatorio write fIn_Obrigatorio;
  end;

  TTef_CampoarqList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Campoarq;
    procedure SetItem(Index: Integer; Value: TTef_Campoarq);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Campoarq;
    property Items[Index: Integer]: TTef_Campoarq read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Campoarq }

constructor TTef_Campoarq.Create;
begin

end;

destructor TTef_Campoarq.Destroy;
begin

  inherited;
end;

{ TTef_CampoarqList }

constructor TTef_CampoarqList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Campoarq);
end;

function TTef_CampoarqList.Add: TTef_Campoarq;
begin
  Result := TTef_Campoarq(inherited Add);
  Result.create;
end;

function TTef_CampoarqList.GetItem(Index: Integer): TTef_Campoarq;
begin
  Result := TTef_Campoarq(inherited GetItem(Index));
end;

procedure TTef_CampoarqList.SetItem(Index: Integer; Value: TTef_Campoarq);
begin
  inherited SetItem(Index, Value);
end;

end.