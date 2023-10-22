using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class Pacijent
    {
       
        public int Id { get; set; }

        public int KorisnikId { get; set; }

        public int GradId { get; set; }

        public string Ime { get; set; } = null;

        public string Prezime { get; set; } = null;

        public string Telefon { get; set; } = null;

        public DateTime DatumRodjenja { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;

        public virtual Grad Grad { get; set; } = null!;

        public virtual ICollection<PacijentOrdinacija> PacijentOrdinacije { get; set; }

        public virtual ICollection<PoklonBon> PoklonBonovi { get; set; }
    }
}
