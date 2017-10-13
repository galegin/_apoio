using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("REGRAFISCAL")]
    public class Regrafiscal : CollectionItem
    {
        [Campo("ID_REGRAFISCAL", CampoTipo.tfKey)]
        public int Id_Regrafiscal { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("DS_REGRAFISCAL", CampoTipo.tfReq)]
        public string Ds_Regrafiscal { get; set; }
        [Campo("IN_CALCIMPOSTO", CampoTipo.tfReq)]
        public string In_Calcimposto { get; set; }
    }
}