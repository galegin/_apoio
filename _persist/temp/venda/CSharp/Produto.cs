using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("PRODUTO")]
    public class Produto : CollectionItem
    {
        [Campo("ID_PRODUTO", CampoTipo.tfKey)]
        public string Id_Produto { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("CD_PRODUTO", CampoTipo.tfReq)]
        public int Cd_Produto { get; set; }
        [Campo("DS_PRODUTO", CampoTipo.tfReq)]
        public string Ds_Produto { get; set; }
        [Campo("CD_ESPECIE", CampoTipo.tfReq)]
        public string Cd_Especie { get; set; }
        [Campo("CD_NCM", CampoTipo.tfReq)]
        public string Cd_Ncm { get; set; }
        [Campo("CD_CST", CampoTipo.tfReq)]
        public string Cd_Cst { get; set; }
        [Campo("CD_CSOSN", CampoTipo.tfReq)]
        public string Cd_Csosn { get; set; }
        [Campo("PR_ALIQUOTA", CampoTipo.tfReq)]
        public double Pr_Aliquota { get; set; }
        [Campo("TP_PRODUCAO", CampoTipo.tfReq)]
        public int Tp_Producao { get; set; }
        [Campo("VL_CUSTO", CampoTipo.tfReq)]
        public double Vl_Custo { get; set; }
        [Campo("VL_VENDA", CampoTipo.tfReq)]
        public double Vl_Venda { get; set; }
        [Campo("VL_PROMOCAO", CampoTipo.tfReq)]
        public double Vl_Promocao { get; set; }
    }
}