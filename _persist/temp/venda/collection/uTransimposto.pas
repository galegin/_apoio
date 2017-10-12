unit uTransimposto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTransimposto = class;
  TTransimpostoClass = class of TTransimposto;

  TTransimpostoList = class;
  TTransimpostoListClass = class of TTransimpostoList;

  TTransimposto = class(TmCollectionItem)
  private
    fId_Transacao: String;
    fNr_Item: Integer;
    fCd_Imposto: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fPr_Aliquota: String;
    fVl_Basecalculo: String;
    fPr_Basecalculo: String;
    fPr_Redbasecalculo: String;
    fVl_Imposto: String;
    fVl_Outro: String;
    fVl_Isento: String;
    fCd_Cst: String;
    fCd_Csosn: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property Nr_Item : Integer read fNr_Item write SetNr_Item;
    property Cd_Imposto : Integer read fCd_Imposto write SetCd_Imposto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write SetPr_Aliquota;
    property Vl_Basecalculo : String read fVl_Basecalculo write SetVl_Basecalculo;
    property Pr_Basecalculo : String read fPr_Basecalculo write SetPr_Basecalculo;
    property Pr_Redbasecalculo : String read fPr_Redbasecalculo write SetPr_Redbasecalculo;
    property Vl_Imposto : String read fVl_Imposto write SetVl_Imposto;
    property Vl_Outro : String read fVl_Outro write SetVl_Outro;
    property Vl_Isento : String read fVl_Isento write SetVl_Isento;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property Cd_Csosn : String read fCd_Csosn write SetCd_Csosn;
  end;

  TTransimpostoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransimposto;
    procedure SetItem(Index: Integer; Value: TTransimposto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTransimposto;
    property Items[Index: Integer]: TTransimposto read GetItem write SetItem; default;
  end;

implementation

{ TTransimposto }

constructor TTransimposto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTransimposto.Destroy;
begin

  inherited;
end;

{ TTransimpostoList }

constructor TTransimpostoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTransimposto);
end;

function TTransimpostoList.Add: TTransimposto;
begin
  Result := TTransimposto(inherited Add);
  Result.create;
end;

function TTransimpostoList.GetItem(Index: Integer): TTransimposto;
begin
  Result := TTransimposto(inherited GetItem(Index));
end;

procedure TTransimpostoList.SetItem(Index: Integer; Value: TTransimposto);
begin
  inherited SetItem(Index, Value);
end;

end.