unit ufrmProcessando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TF_Processando = class(TForm)
    LabelProcessando: TLabel;
    ProgressBar: TProgressBar;
  private
  public
    procedure Inciar(pTotal : Integer);
    procedure Posicionar(pPosicao : Integer);
  end;

  function Instance : TF_Processando;
  procedure Destroy;

implementation

{$R *.dfm}

var
  _instance: TF_Processando;

  function Instance : TF_Processando;
  begin
    if not Assigned(_instance) then
      _instance := TF_Processando.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

//  Application.CreateForm(TF_Processando, F_Processando);

{ TF_Processando }

procedure TF_Processando.Inciar(pTotal: Integer);
begin
  ProgressBar.Position := 0;
  ProgressBar.Max := pTotal;
  Show;
end;

procedure TF_Processando.Posicionar(pPosicao: Integer);
begin
  ProgressBar.Position := pPosicao;
  Show;
  Refresh;
end;

end.
