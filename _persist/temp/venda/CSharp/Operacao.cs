using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("OPERACAO")]
    public class Operacao : CollectionItem
    {
        [Campo("ID_OPERACAO", CampoTipo.tfKey)]
        public string Id_Operacao { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("DS_OPERACAO", CampoTipo.tfReq)]
        public string Ds_Operacao { get; set; }
        [Campo("TP_MODELONF", CampoTipo.tfReq)]
        public int Tp_Modelonf { get; set; }
        [Campo("TP_MODALIDADE", CampoTipo.tfReq)]
        public int Tp_Modalidade { get; set; }
        [Campo("TP_OPERACAO", CampoTipo.tfReq)]
        public int Tp_Operacao { get; set; }
        [Campo("CD_SERIE", CampoTipo.tfReq)]
        public string Cd_Serie { get; set; }
        [Campo("CD_CFOP", CampoTipo.tfReq)]
        public int Cd_Cfop { get; set; }
        [Campo("ID_REGRAFISCAL", CampoTipo.tfReq)]
        public int Id_Regrafiscal { get; set; }
    }
}