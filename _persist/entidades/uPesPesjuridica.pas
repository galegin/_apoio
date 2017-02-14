unit uPesPesjuridica;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Pesjuridica = class;
  TPes_PesjuridicaClass = class of TPes_Pesjuridica;

  TPes_PesjuridicaList = class;
  TPes_PesjuridicaListClass = class of TPes_PesjuridicaList;

  TPes_Pesjuridica = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fU_Version: String;
    fNm_Fantasia: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Inativo: String;
    fCd_Atividade: Real;
    fQt_Funcionario: Real;
    fNr_Cnpj: String;
    fVl_Fatmensal: Real;
    fNr_Inscestl: String;
    fDt_Fundacao: TDateTime;
    fTp_Regimetrib: String;
    fVl_Capitalsocial: Real;
    fDs_Uf: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Nm_Fantasia : String read fNm_Fantasia write fNm_Fantasia;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property Cd_Atividade : Real read fCd_Atividade write fCd_Atividade;
    property Qt_Funcionario : Real read fQt_Funcionario write fQt_Funcionario;
    property Nr_Cnpj : String read fNr_Cnpj write fNr_Cnpj;
    property Vl_Fatmensal : Real read fVl_Fatmensal write fVl_Fatmensal;
    property Nr_Inscestl : String read fNr_Inscestl write fNr_Inscestl;
    property Dt_Fundacao : TDateTime read fDt_Fundacao write fDt_Fundacao;
    property Tp_Regimetrib : String read fTp_Regimetrib write fTp_Regimetrib;
    property Vl_Capitalsocial : Real read fVl_Capitalsocial write fVl_Capitalsocial;
    property Ds_Uf : String read fDs_Uf write fDs_Uf;
  end;

  TPes_PesjuridicaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Pesjuridica;
    procedure SetItem(Index: Integer; Value: TPes_Pesjuridica);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Pesjuridica;
    property Items[Index: Integer]: TPes_Pesjuridica read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Pesjuridica }

constructor TPes_Pesjuridica.Create;
begin

end;

destructor TPes_Pesjuridica.Destroy;
begin

  inherited;
end;

{ TPes_PesjuridicaList }

constructor TPes_PesjuridicaList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Pesjuridica);
end;

function TPes_PesjuridicaList.Add: TPes_Pesjuridica;
begin
  Result := TPes_Pesjuridica(inherited Add);
  Result.create;
end;

function TPes_PesjuridicaList.GetItem(Index: Integer): TPes_Pesjuridica;
begin
  Result := TPes_Pesjuridica(inherited GetItem(Index));
end;

procedure TPes_PesjuridicaList.SetItem(Index: Integer; Value: TPes_Pesjuridica);
begin
  inherited SetItem(Index, Value);
end;

end.