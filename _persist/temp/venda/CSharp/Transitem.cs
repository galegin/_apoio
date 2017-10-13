using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("TRANSITEM")]
    public class Transitem : CollectionItem
    {
        [Campo("ID_TRANSACAO", CampoTipo.tfKey)]
        public string Id_Transacao { get; set; }
        [Campo("NR_ITEM", CampoTipo.tfKey)]
        public int Nr_Item { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("ID_PRODUTO", CampoTipo.tfReq)]
        public string Id_Produto { get; set; }
        [Campo("CD_PRODUTO", CampoTipo.tfReq)]
        public int Cd_Produto { get; set; }
        [Campo("DS_PRODUTO", CampoTipo.tfReq)]
        public string Ds_Produto { get; set; }
        [Campo("CD_CFOP", CampoTipo.tfReq)]
        public int Cd_Cfop { get; set; }
        [Campo("CD_ESPECIE", CampoTipo.tfReq)]
        public string Cd_Especie { get; set; }
        [Campo("CD_NCM", CampoTipo.tfReq)]
        public string Cd_Ncm { get; set; }
        [Campo("QT_ITEM", CampoTipo.tfReq)]
        public double Qt_Item { get; set; }
        [Campo("VL_CUSTO", CampoTipo.tfReq)]
        public double Vl_Custo { get; set; }
        [Campo("VL_UNITARIO", CampoTipo.tfReq)]
        public double Vl_Unitario { get; set; }
        [Campo("VL_ITEM", CampoTipo.tfReq)]
        public double Vl_Item { get; set; }
        [Campo("VL_VARIACAO", CampoTipo.tfReq)]
        public double Vl_Variacao { get; set; }
        [Campo("VL_VARIACAOCAPA", CampoTipo.tfReq)]
        public double Vl_Variacaocapa { get; set; }
        [Campo("VL_FRETE", CampoTipo.tfReq)]
        public double Vl_Frete { get; set; }
        [Campo("VL_SEGURO", CampoTipo.tfReq)]
        public double Vl_Seguro { get; set; }
        [Campo("VL_OUTRO", CampoTipo.tfReq)]
        public double Vl_Outro { get; set; }
        [Campo("VL_DESPESA", CampoTipo.tfReq)]
        public double Vl_Despesa { get; set; }
    }
}