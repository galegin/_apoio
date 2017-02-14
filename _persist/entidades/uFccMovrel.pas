unit uFccMovrel;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcc_Movrel = class;
  TFcc_MovrelClass = class of TFcc_Movrel;

  TFcc_MovrelList = class;
  TFcc_MovrelListClass = class of TFcc_MovrelList;

  TFcc_Movrel = class(TcCollectionItem)
  private
    fCd_Empmov: Real;
    fDt_Mov: TDateTime;
    fNr_Seqmov: Real;
    fNr_Ctapesfcc: Real;
    fDt_Movimfcc: TDateTime;
    fNr_Seqmovfcc: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Operacao: String;
    fTp_Origem: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empmov : Real read fCd_Empmov write fCd_Empmov;
    property Dt_Mov : TDateTime read fDt_Mov write fDt_Mov;
    property Nr_Seqmov : Real read fNr_Seqmov write fNr_Seqmov;
    property Nr_Ctapesfcc : Real read fNr_Ctapesfcc write fNr_Ctapesfcc;
    property Dt_Movimfcc : TDateTime read fDt_Movimfcc write fDt_Movimfcc;
    property Nr_Seqmovfcc : Real read fNr_Seqmovfcc write fNr_Seqmovfcc;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Tp_Origem : Real read fTp_Origem write fTp_Origem;
  end;

  TFcc_MovrelList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcc_Movrel;
    procedure SetItem(Index: Integer; Value: TFcc_Movrel);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcc_Movrel;
    property Items[Index: Integer]: TFcc_Movrel read GetItem write SetItem; default;
  end;
  
implementation

{ TFcc_Movrel }

constructor TFcc_Movrel.Create;
begin

end;

destructor TFcc_Movrel.Destroy;
begin

  inherited;
end;

{ TFcc_MovrelList }

constructor TFcc_MovrelList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcc_Movrel);
end;

function TFcc_MovrelList.Add: TFcc_Movrel;
begin
  Result := TFcc_Movrel(inherited Add);
  Result.create;
end;

function TFcc_MovrelList.GetItem(Index: Integer): TFcc_Movrel;
begin
  Result := TFcc_Movrel(inherited GetItem(Index));
end;

procedure TFcc_MovrelList.SetItem(Index: Integer; Value: TFcc_Movrel);
begin
  inherited SetItem(Index, Value);
end;

end.