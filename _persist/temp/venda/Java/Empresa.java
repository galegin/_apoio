package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("EMPRESA")
public class Empresa extends CollectionItem
{
    @Campo("ID_EMPRESA", CampoTipo.tfKey)
    public Integer Id_Empresa;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("ID_PESSOA", CampoTipo.tfReq)
    public String Id_Pessoa;
}