unit uTraTransatmp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transatmp = class;
  TTra_TransatmpClass = class of TTra_Transatmp;

  TTra_TransatmpList = class;
  TTra_TransatmpListClass = class of TTra_TransatmpList;

  TTra_Transatmp = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fU_Version: String;
    fCd_Empecf: Real;
    fNr_Ecf: Real;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Situacao: String;
    fNr_Cupom: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empecf : Real read fCd_Empecf write fCd_Empecf;
    property Nr_Ecf : Real read fNr_Ecf write fNr_Ecf;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Nr_Cupom : Real read fNr_Cupom write fNr_Cupom;
  end;

  TTra_TransatmpList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transatmp;
    procedure SetItem(Index: Integer; Value: TTra_Transatmp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transatmp;
    property Items[Index: Integer]: TTra_Transatmp read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transatmp }

constructor TTra_Transatmp.Create;
begin

end;

destructor TTra_Transatmp.Destroy;
begin

  inherited;
end;

{ TTra_TransatmpList }

constructor TTra_TransatmpList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transatmp);
end;

function TTra_TransatmpList.Add: TTra_Transatmp;
begin
  Result := TTra_Transatmp(inherited Add);
  Result.create;
end;

function TTra_TransatmpList.GetItem(Index: Integer): TTra_Transatmp;
begin
  Result := TTra_Transatmp(inherited GetItem(Index));
end;

procedure TTra_TransatmpList.SetItem(Index: Integer; Value: TTra_Transatmp);
begin
  inherited SetItem(Index, Value);
end;

end.