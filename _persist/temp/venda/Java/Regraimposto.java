package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("REGRAIMPOSTO")
public class Regraimposto extends CollectionItem
{
    @Campo("ID_REGRAFISCAL", CampoTipo.tfKey)
    public Integer Id_Regrafiscal;
    @Campo("CD_IMPOSTO", CampoTipo.tfKey)
    public Integer Cd_Imposto;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("PR_ALIQUOTA", CampoTipo.tfReq)
    public Float Pr_Aliquota;
    @Campo("PR_BASECALCULO", CampoTipo.tfReq)
    public Float Pr_Basecalculo;
    @Campo("CD_CST", CampoTipo.tfReq)
    public String Cd_Cst;
    @Campo("CD_CSOSN", CampoTipo.tfNul)
    public String Cd_Csosn;
    @Campo("IN_ISENTO", CampoTipo.tfReq)
    public String In_Isento;
    @Campo("IN_OUTRO", CampoTipo.tfReq)
    public String In_Outro;
}