using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("TRANSPAGTO")]
    public class Transpagto : CollectionItem
    {
        [Campo("ID_TRANSACAO", CampoTipo.tfKey)]
        public string Id_Transacao { get; set; }
        [Campo("NR_SEQ", CampoTipo.tfKey)]
        public int Nr_Seq { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("ID_CAIXA", CampoTipo.tfReq)]
        public int Id_Caixa { get; set; }
        [Campo("TP_DOCUMENTO", CampoTipo.tfReq)]
        public int Tp_Documento { get; set; }
        [Campo("ID_HISTREL", CampoTipo.tfReq)]
        public int Id_Histrel { get; set; }
        [Campo("NR_PARCELA", CampoTipo.tfReq)]
        public int Nr_Parcela { get; set; }
        [Campo("NR_PARCELAS", CampoTipo.tfReq)]
        public int Nr_Parcelas { get; set; }
        [Campo("NR_DOCUMENTO", CampoTipo.tfNul)]
        public int Nr_Documento { get; set; }
        [Campo("VL_DOCUMENTO", CampoTipo.tfReq)]
        public double Vl_Documento { get; set; }
        [Campo("DT_VENCIMENTO", CampoTipo.tfReq)]
        public DateTime Dt_Vencimento { get; set; }
        [Campo("CD_AUTORIZACAO", CampoTipo.tfNul)]
        public string Cd_Autorizacao { get; set; }
        [Campo("NR_NSU", CampoTipo.tfNul)]
        public int Nr_Nsu { get; set; }
        [Campo("DS_REDETEF", CampoTipo.tfNul)]
        public string Ds_Redetef { get; set; }
        [Campo("NM_OPERADORA", CampoTipo.tfNul)]
        public string Nm_Operadora { get; set; }
        [Campo("NR_BANCO", CampoTipo.tfNul)]
        public int Nr_Banco { get; set; }
        [Campo("NR_AGENCIA", CampoTipo.tfNul)]
        public int Nr_Agencia { get; set; }
        [Campo("DS_CONTA", CampoTipo.tfNul)]
        public string Ds_Conta { get; set; }
        [Campo("NR_CHEQUE", CampoTipo.tfNul)]
        public int Nr_Cheque { get; set; }
        [Campo("DS_CMC7", CampoTipo.tfNul)]
        public string Ds_Cmc7 { get; set; }
        [Campo("TP_BAIXA", CampoTipo.tfNul)]
        public int Tp_Baixa { get; set; }
        [Campo("CD_OPERBAIXA", CampoTipo.tfNul)]
        public int Cd_Operbaixa { get; set; }
        [Campo("DT_BAIXA", CampoTipo.tfNul)]
        public DateTime Dt_Baixa { get; set; }
    }
}