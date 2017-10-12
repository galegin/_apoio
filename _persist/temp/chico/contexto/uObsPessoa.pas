unit uObsPessoa;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TObs_Pessoa = class(TmMapping)
  private
    fCd_Pessoa: String;
    fNr_Linha: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Manutencao: String;
    fCd_Componente: String;
    fDs_Observacao: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Nr_Linha : String read fNr_Linha write fNr_Linha;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property In_Manutencao : String read fIn_Manutencao write fIn_Manutencao;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TObs_Pessoas = class(TList)
  public
    function Add: TObs_Pessoa; overload;
  end;

implementation

{ TObs_Pessoa }

constructor TObs_Pessoa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TObs_Pessoa.Destroy;
begin

  inherited;
end;

//--

function TObs_Pessoa.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'OBS_PESSOA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('Nr_Linha', 'NR_LINHA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('In_Manutencao', 'IN_MANUTENCAO', tfNul);
    Add('Cd_Componente', 'CD_COMPONENTE', tfNul);
    Add('Ds_Observacao', 'DS_OBSERVACAO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TObs_Pessoas }

function TObs_Pessoas.Add: TObs_Pessoa;
begin
  Result := TObs_Pessoa.Create(nil);
  Self.Add(Result);
end;

end.