unit uPrdGradec;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Gradec = class(TmMapping)
  private
    fCd_Grade: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Grade: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Grade : String read fCd_Grade write fCd_Grade;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Grade : String read fDs_Grade write fDs_Grade;
  end;

  TPrd_Gradecs = class(TList)
  public
    function Add: TPrd_Gradec; overload;
  end;

implementation

{ TPrd_Gradec }

constructor TPrd_Gradec.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Gradec.Destroy;
begin

  inherited;
end;

//--

function TPrd_Gradec.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_GRADEC';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Grade', 'CD_GRADE', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Grade', 'DS_GRADE', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Gradecs }

function TPrd_Gradecs.Add: TPrd_Gradec;
begin
  Result := TPrd_Gradec.Create(nil);
  Self.Add(Result);
end;

end.