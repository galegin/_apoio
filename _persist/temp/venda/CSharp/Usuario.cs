using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("USUARIO")]
    public class Usuario : CollectionItem
    {
        [Campo("ID_USUARIO", CampoTipo.tfKey)]
        public int Id_Usuario { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("NM_USUARIO", CampoTipo.tfReq)]
        public string Nm_Usuario { get; set; }
        [Campo("NM_LOGIN", CampoTipo.tfReq)]
        public string Nm_Login { get; set; }
        [Campo("CD_SENHA", CampoTipo.tfReq)]
        public string Cd_Senha { get; set; }
        [Campo("CD_PAPEL", CampoTipo.tfNul)]
        public string Cd_Papel { get; set; }
        [Campo("TP_BLOQUEIO", CampoTipo.tfReq)]
        public int Tp_Bloqueio { get; set; }
        [Campo("DT_BLOQUEIO", CampoTipo.tfNul)]
        public DateTime Dt_Bloqueio { get; set; }
    }
}