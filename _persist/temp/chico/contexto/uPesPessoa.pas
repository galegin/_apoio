unit uPesPessoa;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Pessoa = class(TmMapping)
  private
    fCd_Pessoa: String;
    fU_Version: String;
    fTp_Pessoa: String;
    fCd_Empresacad: String;
    fCd_Operadorcad: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDt_Inclusao: String;
    fNm_Pessoa: String;
    fNr_Cpfcnpj: String;
    fIn_Contribuinte: String;
    fIn_Inativo: String;
    fIn_Privado: String;
    fCd_Coligador: String;
    fNr_Seqemail: String;
    fNr_Seqend: String;
    fNr_Seqfone: String;
    fNr_Endres: String;
    fNr_Endcob: String;
    fNr_Endcom: String;
    fNr_Endent: String;
    fNr_Endcor: String;
    fDs_Homepage: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Pessoa : String read fTp_Pessoa write fTp_Pessoa;
    property Cd_Empresacad : String read fCd_Empresacad write fCd_Empresacad;
    property Cd_Operadorcad : String read fCd_Operadorcad write fCd_Operadorcad;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Dt_Inclusao : String read fDt_Inclusao write fDt_Inclusao;
    property Nm_Pessoa : String read fNm_Pessoa write fNm_Pessoa;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    property In_Contribuinte : String read fIn_Contribuinte write fIn_Contribuinte;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property In_Privado : String read fIn_Privado write fIn_Privado;
    property Cd_Coligador : String read fCd_Coligador write fCd_Coligador;
    property Nr_Seqemail : String read fNr_Seqemail write fNr_Seqemail;
    property Nr_Seqend : String read fNr_Seqend write fNr_Seqend;
    property Nr_Seqfone : String read fNr_Seqfone write fNr_Seqfone;
    property Nr_Endres : String read fNr_Endres write fNr_Endres;
    property Nr_Endcob : String read fNr_Endcob write fNr_Endcob;
    property Nr_Endcom : String read fNr_Endcom write fNr_Endcom;
    property Nr_Endent : String read fNr_Endent write fNr_Endent;
    property Nr_Endcor : String read fNr_Endcor write fNr_Endcor;
    property Ds_Homepage : String read fDs_Homepage write fDs_Homepage;
  end;

  TPes_Pessoas = class(TList)
  public
    function Add: TPes_Pessoa; overload;
  end;

implementation

{ TPes_Pessoa }

constructor TPes_Pessoa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Pessoa.Destroy;
begin

  inherited;
end;

//--

function TPes_Pessoa.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_PESSOA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Tp_Pessoa', 'TP_PESSOA', tfNul);
    Add('Cd_Empresacad', 'CD_EMPRESACAD', tfReq);
    Add('Cd_Operadorcad', 'CD_OPERADORCAD', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Dt_Inclusao', 'DT_INCLUSAO', tfReq);
    Add('Nm_Pessoa', 'NM_PESSOA', tfReq);
    Add('Nr_Cpfcnpj', 'NR_CPFCNPJ', tfNul);
    Add('In_Contribuinte', 'IN_CONTRIBUINTE', tfNul);
    Add('In_Inativo', 'IN_INATIVO', tfNul);
    Add('In_Privado', 'IN_PRIVADO', tfNul);
    Add('Cd_Coligador', 'CD_COLIGADOR', tfNul);
    Add('Nr_Seqemail', 'NR_SEQEMAIL', tfNul);
    Add('Nr_Seqend', 'NR_SEQEND', tfNul);
    Add('Nr_Seqfone', 'NR_SEQFONE', tfNul);
    Add('Nr_Endres', 'NR_ENDRES', tfNul);
    Add('Nr_Endcob', 'NR_ENDCOB', tfNul);
    Add('Nr_Endcom', 'NR_ENDCOM', tfNul);
    Add('Nr_Endent', 'NR_ENDENT', tfNul);
    Add('Nr_Endcor', 'NR_ENDCOR', tfNul);
    Add('Ds_Homepage', 'DS_HOMEPAGE', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Pessoas }

function TPes_Pessoas.Add: TPes_Pessoa;
begin
  Result := TPes_Pessoa.Create(nil);
  Self.Add(Result);
end;

end.