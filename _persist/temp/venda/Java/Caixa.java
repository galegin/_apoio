package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("CAIXA")
public class Caixa extends CollectionItem
{
    @Campo("ID_CAIXA", CampoTipo.tfKey)
    public Integer Id_Caixa;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("ID_EMPRESA", CampoTipo.tfReq)
    public Integer Id_Empresa;
    @Campo("ID_TERMINAL", CampoTipo.tfReq)
    public Integer Id_Terminal;
    @Campo("DT_ABERTURA", CampoTipo.tfReq)
    public DateTime Dt_Abertura;
    @Campo("VL_ABERTURA", CampoTipo.tfReq)
    public Float Vl_Abertura;
    @Campo("IN_FECHADO", CampoTipo.tfReq)
    public String In_Fechado;
    @Campo("DT_FECHADO", CampoTipo.tfNul)
    public DateTime Dt_Fechado;
}