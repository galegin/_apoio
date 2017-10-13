package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("USUARIO")
public class Usuario extends CollectionItem
{
    @Campo("ID_USUARIO", CampoTipo.tfKey)
    public Integer Id_Usuario;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("NM_USUARIO", CampoTipo.tfReq)
    public String Nm_Usuario;
    @Campo("NM_LOGIN", CampoTipo.tfReq)
    public String Nm_Login;
    @Campo("CD_SENHA", CampoTipo.tfReq)
    public String Cd_Senha;
    @Campo("CD_PAPEL", CampoTipo.tfNul)
    public String Cd_Papel;
    @Campo("TP_BLOQUEIO", CampoTipo.tfReq)
    public Integer Tp_Bloqueio;
    @Campo("DT_BLOQUEIO", CampoTipo.tfNul)
    public DateTime Dt_Bloqueio;
}