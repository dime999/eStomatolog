using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Ordinacija
    {
        public int OrdinacijaId { get; set; }

        public string Naziv { get; set; }

        public string Adresa { get; set; } 

        public string Grad { get; set; } 

        public string Drzava { get; set; } 

        public string Telefon { get; set; }

        public byte[] Slika { get; set; } 

        public virtual ICollection<Doktor> Doktori { get; set; }
        public virtual ICollection<Pacijent> Pacijenti { get; set; }
    }
}
