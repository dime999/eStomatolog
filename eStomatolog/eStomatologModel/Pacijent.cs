using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public  class Pacijent
    {
        public int Id { get; set; }

        public int KorisnikId { get; set; }

        public int GradId { get; set; }

        public string Ime { get; set; } = null;

        public string Prezime { get; set; } = null;

        public DateTime DatumRodjenja { get; set; }

        public virtual Korisnik Korisnik { get; set; } 

        public virtual Grad Grad { get; set; }

        public string Telefon { get; set; } 


        public virtual ICollection<Ordinacija> Ordinacije { get; set; }
    }
}
