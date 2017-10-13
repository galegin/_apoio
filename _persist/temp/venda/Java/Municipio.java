package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("MUNICIPIO")
public class Municipio extends CollectionItem
{
    @Campo("ID_MUNICIPIO", CampoTipo.tfKey)
    public Integer Id_Municipio;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("CD_MUNICIPIO", CampoTipo.tfReq)
    public Integer Cd_Municipio;
    @Campo("DS_MUNICIPIO", CampoTipo.tfReq)
    public String Ds_Municipio;
    @Campo("DS_SIGLA", CampoTipo.tfReq)
    public String Ds_Sigla;
    @Campo("ID_ESTADO", CampoTipo.tfReq)
    public Integer Id_Estado;
}