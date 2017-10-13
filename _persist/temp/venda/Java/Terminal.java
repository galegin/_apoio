package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("TERMINAL")
public class Terminal extends CollectionItem
{
    @Campo("ID_TERMINAL", CampoTipo.tfKey)
    public Integer Id_Terminal;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("CD_TERMINAL", CampoTipo.tfReq)
    public Integer Cd_Terminal;
    @Campo("DS_TERMINAL", CampoTipo.tfReq)
    public String Ds_Terminal;
}