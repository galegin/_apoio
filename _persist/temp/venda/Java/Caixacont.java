package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("CAIXACONT")
public class Caixacont extends CollectionItem
{
    @Campo("ID_CAIXA", CampoTipo.tfKey)
    public Integer Id_Caixa;
    @Campo("ID_HISTREL", CampoTipo.tfKey)
    public Integer Id_Histrel;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("VL_CONTADO", CampoTipo.tfReq)
    public Float Vl_Contado;
    @Campo("VL_SISTEMA", CampoTipo.tfReq)
    public Float Vl_Sistema;
    @Campo("VL_RETIRADA", CampoTipo.tfReq)
    public Float Vl_Retirada;
    @Campo("VL_SUPRIMENTO", CampoTipo.tfReq)
    public Float Vl_Suprimento;
    @Campo("VL_DIFERENCA", CampoTipo.tfReq)
    public Float Vl_Diferenca;
}