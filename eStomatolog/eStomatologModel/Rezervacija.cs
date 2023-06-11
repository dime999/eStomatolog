using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Rezervacija
    {
        public int RezervacijaId { get; set; }

        public int DoktorId { get; set; }
        public virtual Doktor Doktor { get; set; }

        public int PacijentId { get; set; }
        public virtual Pacijent Pacijent { get; set; }

        public int OrdinacijaId { get; set; }
        public virtual Ordinacije Ordinacija { get; set; }

        public DateTime Od { get; set; }
        public DateTime Do { get; set; }

        public string DoktorIme => Doktor?.Ime;
        public string PacijentPrezime => Pacijent?.Prezime;
        public string OrdinacijaIme => Ordinacija?.Naziv;
    }
}
