unit ufrmLibrary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmLibrary = class(TForm)
    cbDelphi: TComboBox;
    LabelDelphi: TLabel;
    ButtonGravar: TButton;
    cbVariable: TComboBox;
    LabelVariavel: TLabel;
    lbLibrary: TListBox;
    LabelLibrary: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ButtonGravarClick(Sender: TObject);
  private
  public
  end;

  TcDelphi = class
  public
    Cod : String;
    Des : String;
    Xml : String;
  end;

  TcVariable = class
  public
    Cod : String;
    Val : String;
  end;

  TcLibrary = class
  public
    Cod : String;
    Val : String;
  end;

var
  FrmLibrary: TFrmLibrary;

implementation

{$R *.dfm}

uses
  cRegister, cArquivo, cFuncao, cXml, fDialog, StrUtils;

var
  gDelphi : TcDelphi;
  gVariable : TcVariable;
  gLibrary : TcLibrary;

procedure TFrmLibrary.FormShow(Sender: TObject);
var
  vLstXml,
  vLstDelphi, vDelphi,
  vLstVariable, vVariable,
  vLstLibrary, vLibrary : String;
begin
  vLstXml := TcArquivo.carregarBin('library.xml');

  //-- delphi

  cbDelphi.Items.Clear;

  vLstDelphi := itemXml('delphis', vLstXml);

  while (vLstDelphi <> '') do begin
    vDelphi := getitemXml(vLstDelphi, 'delphi');
    if vDelphi = '' then Break;
    delitemXml(vLstDelphi, 'delphi');

    gDelphi := TcDelphi.Create;
    gDelphi.Cod := itemAtr('cod', vDelphi);
    gDelphi.Des := itemAtr('des', vDelphi);
    gDelphi.Xml := vDelphi;

    cbDelphi.Items.AddObject(gDelphi.Des, gDelphi);
  end;

  cbDelphi.ItemIndex := 0;

  //-- variable

  cbVariable.Items.Clear;

  vLstVariable := itemXml('variables', vLstXml);

  while (vLstVariable <> '') do begin
    vVariable := getitemXml(vLstVariable, 'variable');
    if vVariable = '' then Break;
    delitemXml(vLstVariable, 'variable');

    gVariable := TcVariable.Create;
    gVariable.Cod := itemAtr('cod', vVariable);
    gVariable.Val := itemAtr('val', vVariable);

    cbVariable.Items.AddObject(gVariable.Cod, gVariable);
  end;

  cbVariable.ItemIndex := 0;

  //-- library

  lbLibrary.Items.Clear;

  vLstLibrary := itemXml('librarys', vLstXml);
  vLstLibrary := AnsiReplaceStr(vLstLibrary, sLineBreak, '');
  while Pos(' ', vLstLibrary) > 0 do
    vLstLibrary := AnsiReplaceStr(vLstLibrary, ' ', '');

  while (vLstLibrary <> '') do begin
    vLibrary := getitem(vLstLibrary);
    if vLibrary = '' then Break;
    delitem(vLstLibrary);

    gLibrary := TcLibrary.Create;
    gLibrary.Cod := vLibrary;
    gLibrary.Val := vLibrary;

    lbLibrary.Items.AddObject(gLibrary.Cod, gLibrary);
  end;
end;

procedure TFrmLibrary.ButtonGravarClick(Sender: TObject);
var
  vEnvironmentVariables, vRegVariable,
  vRegLibrary, vKeyLibrary, vLibrary,
  vLstLibraryNov, 
  vLstLibraryDef, vLibraryDef,
  vLstLibraryAnt, vLibraryAnt : String;
  I : Integer;

  procedure AddLibrary(var pLstLibrary : String; pLibrary : String);
  begin
    if (Pos(pLibrary, pLstLibrary) = 0) then
      pLstLibrary := pLstLibrary + IfThen(pLstLibrary <> '', ';', '') + pLibrary;
  end;

begin
  if Pergunta(cCONFIRM_GRAVACAO) = False then
    Exit;

  //-- Environment Variables

  gDelphi := TcDelphi(cbDelphi.Items.Objects[cbDelphi.ItemIndex]);
  vEnvironmentVariables := getitemXml(gDelphi.Xml, 'environment_variables');
  vRegVariable := itemAtr('reg', vEnvironmentVariables);

  for I := 0 to cbVariable.Items.Count - 1 do begin
    gVariable := TcVariable(cbVariable.Items.Objects[I]);
    TcRegister.WriteRegistry(vRegVariable, gVariable.Cod, gVariable.Val);
  end;

  //-- Library

  vLibrary := getitemXml(gDelphi.Xml, 'library');
  vRegLibrary := itemAtr('reg', vLibrary);
  vKeyLibrary := itemAtr('key', vLibrary);
  vLstLibraryDef := itemAtr('def', vLibrary);

  vLstLibraryNov := '';

  //-- manter anterior

  vLstLibraryAnt := TcRegister.ReadRegistry(vRegLibrary, vKeyLibrary);

  while (vLstLibraryAnt <> '') do begin
    vLibraryAnt := getitem(vLstLibraryAnt);
    if (vLibraryAnt = '') then Break;
    delitem(vLstLibraryAnt);

    if (Pos('$(LIB_', vLibraryAnt) = 0) then
      AddLibrary(vLstLibraryNov, vLibraryAnt);
  end;

  //-- inserir default

  while (vLstLibraryDef <> '') do begin
    vLibraryDef := getitem(vLstLibraryDef);
    if (vLibraryDef = '') then Break;
    delitem(vLstLibraryDef);

    AddLibrary(vLstLibraryNov, vLibraryDef);
  end;

  //-- inserir library

  for I := 0 to lbLibrary.Items.Count - 1 do begin
    gLibrary := TcLibrary(lbLibrary.Items.Objects[I]);
    AddLibrary(vLstLibraryNov, gLibrary.Val);
  end;

  TcRegister.WriteRegistry(vRegLibrary, vKeyLibrary, vLstLibraryNov);

  Mensagem(cMESSAGE_GRAVACAO);
end;

end.