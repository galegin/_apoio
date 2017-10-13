using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("HISTREL")]
    public class Histrel : CollectionItem
    {
        [Campo("ID_HISTREL", CampoTipo.tfKey)]
        public int Id_Histrel { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("TP_DOCUMENTO", CampoTipo.tfReq)]
        public int Tp_Documento { get; set; }
        [Campo("CD_HISTREL", CampoTipo.tfReq)]
        public int Cd_Histrel { get; set; }
        [Campo("DS_HISTREL", CampoTipo.tfReq)]
        public string Ds_Histrel { get; set; }
        [Campo("NR_PARCELAS", CampoTipo.tfReq)]
        public int Nr_Parcelas { get; set; }
    }
}