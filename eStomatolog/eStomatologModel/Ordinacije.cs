using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Ordinacije
    {

        public int OrdinacijaId { get; set; }

        public string Naziv { get; set; } 

        public string Adresa { get; set; } 

        public string Telefon { get; set; }

        public int GradId { get; set; }

        public Grad Grad { get; set; }

    }
}
