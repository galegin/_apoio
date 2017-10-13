package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("PRODUTO")
public class Produto extends CollectionItem
{
    @Campo("ID_PRODUTO", CampoTipo.tfKey)
    public String Id_Produto;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("CD_PRODUTO", CampoTipo.tfReq)
    public Integer Cd_Produto;
    @Campo("DS_PRODUTO", CampoTipo.tfReq)
    public String Ds_Produto;
    @Campo("CD_ESPECIE", CampoTipo.tfReq)
    public String Cd_Especie;
    @Campo("CD_NCM", CampoTipo.tfReq)
    public String Cd_Ncm;
    @Campo("CD_CST", CampoTipo.tfReq)
    public String Cd_Cst;
    @Campo("CD_CSOSN", CampoTipo.tfReq)
    public String Cd_Csosn;
    @Campo("PR_ALIQUOTA", CampoTipo.tfReq)
    public Float Pr_Aliquota;
    @Campo("TP_PRODUCAO", CampoTipo.tfReq)
    public Integer Tp_Producao;
    @Campo("VL_CUSTO", CampoTipo.tfReq)
    public Float Vl_Custo;
    @Campo("VL_VENDA", CampoTipo.tfReq)
    public Float Vl_Venda;
    @Campo("VL_PROMOCAO", CampoTipo.tfReq)
    public Float Vl_Promocao;
}