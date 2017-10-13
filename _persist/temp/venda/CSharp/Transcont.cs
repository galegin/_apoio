using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("TRANSCONT")]
    public class Transcont : CollectionItem
    {
        [Campo("ID_TRANSACAO", CampoTipo.tfKey)]
        public string Id_Transacao { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("TP_SITUACAO", CampoTipo.tfReq)]
        public int Tp_Situacao { get; set; }
        [Campo("CD_TERMINAL", CampoTipo.tfReq)]
        public int Cd_Terminal { get; set; }
    }
}