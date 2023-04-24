using eStomatologServices.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Models
{
    public partial class Korisnik
    {
        public Korisnik()
        {         
            KorisniciUloges = new HashSet<KorisniciUloge>();       
        }

        public int KorisnikId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Email { get; set; }
        public string? Telefon { get; set; }
        public string KorisnickoIme { get; set; } = null!;
        public string LozinkaHash { get; set; } = null!;
        public string LozinkaSalt { get; set; } = null!;
        public bool? Status { get; set; }

        public virtual ICollection<KorisniciUloge> KorisniciUloges { get; set; }    

    }
}
