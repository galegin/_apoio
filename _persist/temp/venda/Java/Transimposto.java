package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("TRANSIMPOSTO")
public class Transimposto extends CollectionItem
{
    @Campo("ID_TRANSACAO", CampoTipo.tfKey)
    public String Id_Transacao;
    @Campo("NR_ITEM", CampoTipo.tfKey)
    public Integer Nr_Item;
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
    @Campo("VL_BASECALCULO", CampoTipo.tfReq)
    public Float Vl_Basecalculo;
    @Campo("PR_BASECALCULO", CampoTipo.tfReq)
    public Float Pr_Basecalculo;
    @Campo("PR_REDBASECALCULO", CampoTipo.tfReq)
    public Float Pr_Redbasecalculo;
    @Campo("VL_IMPOSTO", CampoTipo.tfReq)
    public Float Vl_Imposto;
    @Campo("VL_OUTRO", CampoTipo.tfReq)
    public Float Vl_Outro;
    @Campo("VL_ISENTO", CampoTipo.tfReq)
    public Float Vl_Isento;
    @Campo("CD_CST", CampoTipo.tfReq)
    public String Cd_Cst;
    @Campo("CD_CSOSN", CampoTipo.tfNul)
    public String Cd_Csosn;
}