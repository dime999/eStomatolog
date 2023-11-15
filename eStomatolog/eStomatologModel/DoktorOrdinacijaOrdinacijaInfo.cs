using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class DoktorOrdinacijaOrdinacijaInfo
    {
        public Ordinacije Ordinacija { get; set; }


        public string OrdinacijaNaziv => Ordinacija?.Naziv;

      

        public int OrdinacijaId => Ordinacija.OrdinacijaId;

       


       
    }
}
