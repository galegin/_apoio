unit uFisDanfeimg;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Danfeimg = class;
  TFis_DanfeimgClass = class of TFis_Danfeimg;

  TFis_DanfeimgList = class;
  TFis_DanfeimgListClass = class of TFis_DanfeimgList;

  TFis_Danfeimg = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Imagem: Boolean;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Imagem : Boolean read fDs_Imagem write fDs_Imagem;
  end;

  TFis_DanfeimgList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Danfeimg;
    procedure SetItem(Index: Integer; Value: TFis_Danfeimg);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Danfeimg;
    property Items[Index: Integer]: TFis_Danfeimg read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Danfeimg }

constructor TFis_Danfeimg.Create;
begin

end;

destructor TFis_Danfeimg.Destroy;
begin

  inherited;
end;

{ TFis_DanfeimgList }

constructor TFis_DanfeimgList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Danfeimg);
end;

function TFis_DanfeimgList.Add: TFis_Danfeimg;
begin
  Result := TFis_Danfeimg(inherited Add);
  Result.create;
end;

function TFis_DanfeimgList.GetItem(Index: Integer): TFis_Danfeimg;
begin
  Result := TFis_Danfeimg(inherited GetItem(Index));
end;

procedure TFis_DanfeimgList.SetItem(Index: Integer; Value: TFis_Danfeimg);
begin
  inherited SetItem(Index, Value);
end;

end.