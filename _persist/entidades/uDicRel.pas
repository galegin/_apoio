unit uDicRel;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TDic_Rel = class;
  TDic_RelClass = class of TDic_Rel;

  TDic_RelList = class;
  TDic_RelListClass = class of TDic_RelList;

  TDic_Rel = class(TcCollectionItem)
  private
    fCd_Relatorio: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Relatorio: String;
    fTp_Relatorio: String;
    fDs_Job: String;
    fCd_Gruporel: String;
    fTp_Permissao: String;
    fDs_Versao: String;
    fIn_Impcabeca: String;
    fIn_Improdape: String;
    fIn_Docaltpag: String;
    fQt_Linha: Real;
    fQt_Coluna: Real;
    fTp_Situacao: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Relatorio : String read fCd_Relatorio write fCd_Relatorio;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Relatorio : String read fDs_Relatorio write fDs_Relatorio;
    property Tp_Relatorio : String read fTp_Relatorio write fTp_Relatorio;
    property Ds_Job : String read fDs_Job write fDs_Job;
    property Cd_Gruporel : String read fCd_Gruporel write fCd_Gruporel;
    property Tp_Permissao : String read fTp_Permissao write fTp_Permissao;
    property Ds_Versao : String read fDs_Versao write fDs_Versao;
    property In_Impcabeca : String read fIn_Impcabeca write fIn_Impcabeca;
    property In_Improdape : String read fIn_Improdape write fIn_Improdape;
    property In_Docaltpag : String read fIn_Docaltpag write fIn_Docaltpag;
    property Qt_Linha : Real read fQt_Linha write fQt_Linha;
    property Qt_Coluna : Real read fQt_Coluna write fQt_Coluna;
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
  end;

  TDic_RelList = class(TcCollection)
  private
    function GetItem(Index: Integer): TDic_Rel;
    procedure SetItem(Index: Integer; Value: TDic_Rel);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TDic_Rel;
    property Items[Index: Integer]: TDic_Rel read GetItem write SetItem; default;
  end;
  
implementation

{ TDic_Rel }

constructor TDic_Rel.Create;
begin

end;

destructor TDic_Rel.Destroy;
begin

  inherited;
end;

{ TDic_RelList }

constructor TDic_RelList.Create(AOwner: TPersistent);
begin
  inherited Create(TDic_Rel);
end;

function TDic_RelList.Add: TDic_Rel;
begin
  Result := TDic_Rel(inherited Add);
  Result.create;
end;

function TDic_RelList.GetItem(Index: Integer): TDic_Rel;
begin
  Result := TDic_Rel(inherited GetItem(Index));
end;

procedure TDic_RelList.SetItem(Index: Integer; Value: TDic_Rel);
begin
  inherited SetItem(Index, Value);
end;

end.