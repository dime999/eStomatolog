using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class Ordinacija
    {
        public Ordinacija()
        {
            Doktori = new HashSet<Doktor>();
        }
        public int OrdinacijaId { get; set; }

        public string Naziv { get; set; } = null!;

        public string Adresa { get; set; } = null!;

        public string Grad { get; set; } = null!; 

        public string Drzava { get; set; } = null!; 

        public string Telefon { get; set; } = null!;

        public byte[] Slika { get; set; } = null!;

        public virtual ICollection<Doktor> Doktori { get; set; }
        public virtual ICollection<Pacijent> Pacijenti { get; set; }
    }
}
