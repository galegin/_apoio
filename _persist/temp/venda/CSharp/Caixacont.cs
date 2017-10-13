using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("CAIXACONT")]
    public class Caixacont : CollectionItem
    {
        [Campo("ID_CAIXA", CampoTipo.tfKey)]
        public int Id_Caixa { get; set; }
        [Campo("ID_HISTREL", CampoTipo.tfKey)]
        public int Id_Histrel { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("VL_CONTADO", CampoTipo.tfReq)]
        public double Vl_Contado { get; set; }
        [Campo("VL_SISTEMA", CampoTipo.tfReq)]
        public double Vl_Sistema { get; set; }
        [Campo("VL_RETIRADA", CampoTipo.tfReq)]
        public double Vl_Retirada { get; set; }
        [Campo("VL_SUPRIMENTO", CampoTipo.tfReq)]
        public double Vl_Suprimento { get; set; }
        [Campo("VL_DIFERENCA", CampoTipo.tfReq)]
        public double Vl_Diferenca { get; set; }
    }
}