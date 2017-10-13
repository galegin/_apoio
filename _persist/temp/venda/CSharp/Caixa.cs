using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("CAIXA")]
    public class Caixa : CollectionItem
    {
        [Campo("ID_CAIXA", CampoTipo.tfKey)]
        public int Id_Caixa { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("ID_EMPRESA", CampoTipo.tfReq)]
        public int Id_Empresa { get; set; }
        [Campo("ID_TERMINAL", CampoTipo.tfReq)]
        public int Id_Terminal { get; set; }
        [Campo("DT_ABERTURA", CampoTipo.tfReq)]
        public DateTime Dt_Abertura { get; set; }
        [Campo("VL_ABERTURA", CampoTipo.tfReq)]
        public double Vl_Abertura { get; set; }
        [Campo("IN_FECHADO", CampoTipo.tfReq)]
        public string In_Fechado { get; set; }
        [Campo("DT_FECHADO", CampoTipo.tfNul)]
        public DateTime Dt_Fechado { get; set; }
    }
}