unit ufrmPersistent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TF_Persistent = class(TForm)
    BtnTestar: TButton;
    BtnGerar: TButton;
    MemoFiltro: TMemo;
    procedure BtnTestarClick(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
  private
  public
  end;

var
  F_Persistent: TF_Persistent;

implementation

{$R *.dfm}

uses
  uclsPersistent, mContexto, mMapping,
  uPessoa;

procedure TF_Persistent.BtnTestarClick(Sender: TObject);
var
  vContexto : TmContexto;
  vPessoas : TPessoas;
  vPessoa : TPessoa;
  I : Integer;
begin
  vPessoas := TPessoas.Create;

  for I := 1 to 10 do
    with vPessoas.Add do begin
      Nr_Cpfcnpj := IntToStr(I);
      Nm_Pessoa := 'Pessoa ' + IntToStr(I);
    end;

  for I := 0 to vPessoas.Count - 1 do begin
    vPessoa := vPessoas[I];
    vPessoa.Nm_Pessoa := vPessoa.Nm_Pessoa + ' aletrado';
    vPessoa.Nm_Pessoa := vPessoa.Nm_Pessoa;
  end;

  vContexto := TmContexto.Create(nil);

  vPessoas := vContexto.GetLista(TPessoa, 'Cd_Pessoa = 1', TPessoas) as TPessoas;
  vContexto.RemLista(vPessoas);
  vContexto.SetLista(vPessoas);

  vPessoa := vContexto.GetObjeto(TPessoa, 'Cd_Pessoa = 1') as TPessoa;
  vContexto.RemObjeto(vPessoa);
  vContexto.SetObjeto(vPessoa);

  vPessoa.Free;

  vContexto.Free;

  ShowMessage('Testado com sucesso!');
end;

procedure TF_Persistent.BtnGerarClick(Sender: TObject);
begin
  TC_Persistent.gerar(MemoFiltro.Text);

  ShowMessage('Geracao efetuada com sucesso!');
end;

end.
