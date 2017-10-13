using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("TRANSFISCAL")]
    public class Transfiscal : CollectionItem
    {
        [Campo("ID_TRANSACAO", CampoTipo.tfKey)]
        public string Id_Transacao { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("TP_OPERACAO", CampoTipo.tfReq)]
        public int Tp_Operacao { get; set; }
        [Campo("TP_MODALIDADE", CampoTipo.tfReq)]
        public int Tp_Modalidade { get; set; }
        [Campo("TP_MODELONF", CampoTipo.tfReq)]
        public int Tp_Modelonf { get; set; }
        [Campo("CD_SERIE", CampoTipo.tfReq)]
        public string Cd_Serie { get; set; }
        [Campo("NR_NF", CampoTipo.tfReq)]
        public int Nr_Nf { get; set; }
        [Campo("TP_PROCESSAMENTO", CampoTipo.tfReq)]
        public string Tp_Processamento { get; set; }
        [Campo("DS_CHAVEACESSO", CampoTipo.tfNul)]
        public string Ds_Chaveacesso { get; set; }
        [Campo("DT_RECEBIMENTO", CampoTipo.tfNul)]
        public DateTime Dt_Recebimento { get; set; }
        [Campo("NR_RECIBO", CampoTipo.tfNul)]
        public string Nr_Recibo { get; set; }
    }
}