package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("OPERACAO")
public class Operacao extends CollectionItem
{
    @Campo("ID_OPERACAO", CampoTipo.tfKey)
    public String Id_Operacao;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("DS_OPERACAO", CampoTipo.tfReq)
    public String Ds_Operacao;
    @Campo("TP_MODELONF", CampoTipo.tfReq)
    public Integer Tp_Modelonf;
    @Campo("TP_MODALIDADE", CampoTipo.tfReq)
    public Integer Tp_Modalidade;
    @Campo("TP_OPERACAO", CampoTipo.tfReq)
    public Integer Tp_Operacao;
    @Campo("CD_SERIE", CampoTipo.tfReq)
    public String Cd_Serie;
    @Campo("CD_CFOP", CampoTipo.tfReq)
    public Integer Cd_Cfop;
    @Campo("ID_REGRAFISCAL", CampoTipo.tfReq)
    public Integer Id_Regrafiscal;
}