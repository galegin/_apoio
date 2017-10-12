unit uTranscont;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTranscont = class;
  TTranscontClass = class of TTranscont;

  TTranscontList = class;
  TTranscontListClass = class of TTranscontList;

  TTranscont = class(TmCollectionItem)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fTp_Situacao: Integer;
    fCd_Terminal: Integer;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Situacao : Integer read fTp_Situacao write SetTp_Situacao;
    property Cd_Terminal : Integer read fCd_Terminal write SetCd_Terminal;
  end;

  TTranscontList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTranscont;
    procedure SetItem(Index: Integer; Value: TTranscont);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTranscont;
    property Items[Index: Integer]: TTranscont read GetItem write SetItem; default;
  end;

implementation

{ TTranscont }

constructor TTranscont.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTranscont.Destroy;
begin

  inherited;
end;

{ TTranscontList }

constructor TTranscontList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTranscont);
end;

function TTranscontList.Add: TTranscont;
begin
  Result := TTranscont(inherited Add);
  Result.create;
end;

function TTranscontList.GetItem(Index: Integer): TTranscont;
begin
  Result := TTranscont(inherited GetItem(Index));
end;

procedure TTranscontList.SetItem(Index: Integer; Value: TTranscont);
begin
  inherited SetItem(Index, Value);
end;

end.