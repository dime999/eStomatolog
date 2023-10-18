using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Rezervacija
    {
        public int RezervacijaId { get; set; }
        public DateTime Datum { get; set; }
        public string Email { get; set; }

        public int TerminId { get; set; }
        public virtual Termin Termin { get; set; }

        public int DoktorId { get; set; }
        public virtual Doktor Doktor { get; set; }

        public int PacijentId { get; set; }
        public virtual Pacijent Pacijent { get; set; }

        public int OrdinacijaId { get; set; }
        public virtual Ordinacije Ordinacija { get; set; }

        public string DoktorIme => Doktor?.Ime;
        public string DoktorPrezime => Doktor?.Prezime;
        public string PacijentIme => Pacijent?.Ime;
        public string PacijentPrezime => Pacijent?.Prezime;
        public string OrdinacijaNaziv => Ordinacija?.Naziv;
        public DateTime TerminVrijeme => (DateTime)(Termin?.Vrijeme);

    }
}
