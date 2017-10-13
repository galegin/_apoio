using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("CAIXAMOV")]
    public class Caixamov : CollectionItem
    {
        [Campo("ID_CAIXA", CampoTipo.tfKey)]
        public int Id_Caixa { get; set; }
        [Campo("NR_SEQ", CampoTipo.tfKey)]
        public int Nr_Seq { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("TP_LANCTO", CampoTipo.tfReq)]
        public int Tp_Lancto { get; set; }
        [Campo("VL_LANCTO", CampoTipo.tfReq)]
        public double Vl_Lancto { get; set; }
        [Campo("NR_DOC", CampoTipo.tfReq)]
        public int Nr_Doc { get; set; }
        [Campo("DS_AUX", CampoTipo.tfReq)]
        public string Ds_Aux { get; set; }
    }
}