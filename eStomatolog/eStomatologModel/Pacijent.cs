using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public  class Pacijent
    {

        public Pacijent()
        {
            Ordinacije = new HashSet<Ordinacija>();
        }
        public int PacijentId { get; set; }

        public int KorisnikId { get; set; }

        public int GradId { get; set; }

        public string Ime { get; set; } 

        public string Prezime { get; set; } 

        public DateTime DatumRodjenja { get; set; }

        public string BrojTelefona { get; set; } 

        public string Email { get; set; }

        public virtual Korisnik Korisnik { get; set; } 
        public virtual Grad Grad { get; set; } 



        public virtual ICollection<Ordinacija> Ordinacije { get; set; }
    }
}
