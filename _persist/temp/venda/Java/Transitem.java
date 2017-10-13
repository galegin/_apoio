package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("TRANSITEM")
public class Transitem extends CollectionItem
{
    @Campo("ID_TRANSACAO", CampoTipo.tfKey)
    public String Id_Transacao;
    @Campo("NR_ITEM", CampoTipo.tfKey)
    public Integer Nr_Item;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("ID_PRODUTO", CampoTipo.tfReq)
    public String Id_Produto;
    @Campo("CD_PRODUTO", CampoTipo.tfReq)
    public Integer Cd_Produto;
    @Campo("DS_PRODUTO", CampoTipo.tfReq)
    public String Ds_Produto;
    @Campo("CD_CFOP", CampoTipo.tfReq)
    public Integer Cd_Cfop;
    @Campo("CD_ESPECIE", CampoTipo.tfReq)
    public String Cd_Especie;
    @Campo("CD_NCM", CampoTipo.tfReq)
    public String Cd_Ncm;
    @Campo("QT_ITEM", CampoTipo.tfReq)
    public Float Qt_Item;
    @Campo("VL_CUSTO", CampoTipo.tfReq)
    public Float Vl_Custo;
    @Campo("VL_UNITARIO", CampoTipo.tfReq)
    public Float Vl_Unitario;
    @Campo("VL_ITEM", CampoTipo.tfReq)
    public Float Vl_Item;
    @Campo("VL_VARIACAO", CampoTipo.tfReq)
    public Float Vl_Variacao;
    @Campo("VL_VARIACAOCAPA", CampoTipo.tfReq)
    public Float Vl_Variacaocapa;
    @Campo("VL_FRETE", CampoTipo.tfReq)
    public Float Vl_Frete;
    @Campo("VL_SEGURO", CampoTipo.tfReq)
    public Float Vl_Seguro;
    @Campo("VL_OUTRO", CampoTipo.tfReq)
    public Float Vl_Outro;
    @Campo("VL_DESPESA", CampoTipo.tfReq)
    public Float Vl_Despesa;
}