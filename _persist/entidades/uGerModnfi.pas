unit uGerModnfi;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Modnfi = class;
  TGer_ModnfiClass = class of TGer_Modnfi;

  TGer_ModnfiList = class;
  TGer_ModnfiListClass = class of TGer_ModnfiList;

  TGer_Modnfi = class(TcCollectionItem)
  private
    fCd_Modelonf: Real;
    fNr_Sequencia: Real;
    fU_Version: String;
    fNr_Linha: Real;
    fNr_Coluna: Real;
    fCd_Campo: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Tamanho: Real;
    fTp_Campo: String;
    fDs_Dados: String;
    fNr_Indice: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Modelonf : Real read fCd_Modelonf write fCd_Modelonf;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Nr_Linha : Real read fNr_Linha write fNr_Linha;
    property Nr_Coluna : Real read fNr_Coluna write fNr_Coluna;
    property Cd_Campo : Real read fCd_Campo write fCd_Campo;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Tamanho : Real read fNr_Tamanho write fNr_Tamanho;
    property Tp_Campo : String read fTp_Campo write fTp_Campo;
    property Ds_Dados : String read fDs_Dados write fDs_Dados;
    property Nr_Indice : Real read fNr_Indice write fNr_Indice;
  end;

  TGer_ModnfiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Modnfi;
    procedure SetItem(Index: Integer; Value: TGer_Modnfi);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Modnfi;
    property Items[Index: Integer]: TGer_Modnfi read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Modnfi }

constructor TGer_Modnfi.Create;
begin

end;

destructor TGer_Modnfi.Destroy;
begin

  inherited;
end;

{ TGer_ModnfiList }

constructor TGer_ModnfiList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Modnfi);
end;

function TGer_ModnfiList.Add: TGer_Modnfi;
begin
  Result := TGer_Modnfi(inherited Add);
  Result.create;
end;

function TGer_ModnfiList.GetItem(Index: Integer): TGer_Modnfi;
begin
  Result := TGer_Modnfi(inherited GetItem(Index));
end;

procedure TGer_ModnfiList.SetItem(Index: Integer; Value: TGer_Modnfi);
begin
  inherited SetItem(Index, Value);
end;

end.