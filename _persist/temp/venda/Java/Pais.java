package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("PAIS")
public class Pais extends CollectionItem
{
    @Campo("ID_PAIS", CampoTipo.tfKey)
    public Integer Id_Pais;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("CD_PAIS", CampoTipo.tfReq)
    public Integer Cd_Pais;
    @Campo("DS_PAIS", CampoTipo.tfReq)
    public String Ds_Pais;
    @Campo("DS_SIGLA", CampoTipo.tfReq)
    public String Ds_Sigla;
}