using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("TRANSACAO")]
    public class Transacao : CollectionItem
    {
        [Campo("ID_TRANSACAO", CampoTipo.tfKey)]
        public string Id_Transacao { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("ID_EMPRESA", CampoTipo.tfReq)]
        public int Id_Empresa { get; set; }
        [Campo("ID_PESSOA", CampoTipo.tfReq)]
        public string Id_Pessoa { get; set; }
        [Campo("ID_OPERACAO", CampoTipo.tfReq)]
        public string Id_Operacao { get; set; }
        [Campo("DT_TRANSACAO", CampoTipo.tfReq)]
        public DateTime Dt_Transacao { get; set; }
        [Campo("NR_TRANSACAO", CampoTipo.tfReq)]
        public int Nr_Transacao { get; set; }
        [Campo("TP_SITUACAO", CampoTipo.tfReq)]
        public int Tp_Situacao { get; set; }
        [Campo("DT_CANCELAMENTO", CampoTipo.tfNul)]
        public DateTime Dt_Cancelamento { get; set; }
    }
}