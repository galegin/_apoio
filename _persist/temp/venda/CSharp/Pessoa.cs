using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("PESSOA")]
    public class Pessoa : CollectionItem
    {
        [Campo("ID_PESSOA", CampoTipo.tfKey)]
        public string Id_Pessoa { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("CD_PESSOA", CampoTipo.tfReq)]
        public int Cd_Pessoa { get; set; }
        [Campo("NM_PESSOA", CampoTipo.tfReq)]
        public string Nm_Pessoa { get; set; }
        [Campo("NR_CPFCNPJ", CampoTipo.tfReq)]
        public string Nr_Cpfcnpj { get; set; }
        [Campo("NR_RGIE", CampoTipo.tfReq)]
        public string Nr_Rgie { get; set; }
        [Campo("NM_FANTASIA", CampoTipo.tfNul)]
        public string Nm_Fantasia { get; set; }
        [Campo("CD_CEP", CampoTipo.tfReq)]
        public int Cd_Cep { get; set; }
        [Campo("NM_LOGRADOURO", CampoTipo.tfReq)]
        public string Nm_Logradouro { get; set; }
        [Campo("NR_LOGRADOURO", CampoTipo.tfReq)]
        public string Nr_Logradouro { get; set; }
        [Campo("DS_BAIRRO", CampoTipo.tfReq)]
        public string Ds_Bairro { get; set; }
        [Campo("DS_COMPLEMENTO", CampoTipo.tfNul)]
        public string Ds_Complemento { get; set; }
        [Campo("CD_MUNICIPIO", CampoTipo.tfReq)]
        public int Cd_Municipio { get; set; }
        [Campo("DS_MUNICIPIO", CampoTipo.tfReq)]
        public string Ds_Municipio { get; set; }
        [Campo("CD_ESTADO", CampoTipo.tfReq)]
        public int Cd_Estado { get; set; }
        [Campo("DS_ESTADO", CampoTipo.tfReq)]
        public string Ds_Estado { get; set; }
        [Campo("DS_SIGLAESTADO", CampoTipo.tfReq)]
        public string Ds_Siglaestado { get; set; }
        [Campo("CD_PAIS", CampoTipo.tfReq)]
        public int Cd_Pais { get; set; }
        [Campo("DS_PAIS", CampoTipo.tfReq)]
        public string Ds_Pais { get; set; }
        [Campo("DS_FONE", CampoTipo.tfNul)]
        public string Ds_Fone { get; set; }
        [Campo("DS_CELULAR", CampoTipo.tfNul)]
        public string Ds_Celular { get; set; }
        [Campo("DS_EMAIL", CampoTipo.tfNul)]
        public string Ds_Email { get; set; }
        [Campo("IN_CONSUMIDORFINAL", CampoTipo.tfNul)]
        public string In_Consumidorfinal { get; set; }
    }
}