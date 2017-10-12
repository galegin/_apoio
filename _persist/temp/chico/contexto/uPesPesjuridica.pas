unit uPesPesjuridica;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Pesjuridica = class(TmMapping)
  private
    fCd_Pessoa: String;
    fU_Version: String;
    fNm_Fantasia: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Inativo: String;
    fCd_Atividade: String;
    fQt_Funcionario: String;
    fNr_Cnpj: String;
    fVl_Fatmensal: String;
    fNr_Inscestl: String;
    fDt_Fundacao: String;
    fTp_Regimetrib: String;
    fVl_Capitalsocial: String;
    fDs_Uf: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Nm_Fantasia : String read fNm_Fantasia write fNm_Fantasia;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property Cd_Atividade : String read fCd_Atividade write fCd_Atividade;
    property Qt_Funcionario : String read fQt_Funcionario write fQt_Funcionario;
    property Nr_Cnpj : String read fNr_Cnpj write fNr_Cnpj;
    property Vl_Fatmensal : String read fVl_Fatmensal write fVl_Fatmensal;
    property Nr_Inscestl : String read fNr_Inscestl write fNr_Inscestl;
    property Dt_Fundacao : String read fDt_Fundacao write fDt_Fundacao;
    property Tp_Regimetrib : String read fTp_Regimetrib write fTp_Regimetrib;
    property Vl_Capitalsocial : String read fVl_Capitalsocial write fVl_Capitalsocial;
    property Ds_Uf : String read fDs_Uf write fDs_Uf;
  end;

  TPes_Pesjuridicas = class(TList)
  public
    function Add: TPes_Pesjuridica; overload;
  end;

implementation

{ TPes_Pesjuridica }

constructor TPes_Pesjuridica.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Pesjuridica.Destroy;
begin

  inherited;
end;

//--

function TPes_Pesjuridica.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_PESJURIDICA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Nm_Fantasia', 'NM_FANTASIA', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('In_Inativo', 'IN_INATIVO', tfNul);
    Add('Cd_Atividade', 'CD_ATIVIDADE', tfNul);
    Add('Qt_Funcionario', 'QT_FUNCIONARIO', tfNul);
    Add('Nr_Cnpj', 'NR_CNPJ', tfNul);
    Add('Vl_Fatmensal', 'VL_FATMENSAL', tfNul);
    Add('Nr_Inscestl', 'NR_INSCESTL', tfNul);
    Add('Dt_Fundacao', 'DT_FUNDACAO', tfNul);
    Add('Tp_Regimetrib', 'TP_REGIMETRIB', tfNul);
    Add('Vl_Capitalsocial', 'VL_CAPITALSOCIAL', tfNul);
    Add('Ds_Uf', 'DS_UF', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Pesjuridicas }

function TPes_Pesjuridicas.Add: TPes_Pesjuridica;
begin
  Result := TPes_Pesjuridica.Create(nil);
  Self.Add(Result);
end;

end.