using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class KorisnikKartica
    {
        public int Id { get; set; }
        public int KorisnikId { get; set; }
        public string BrojKartice { get; set; }
        public string VrstaKartica { get; set; }
        public string DatumIsteka { get; set; }
        public string Cvv { get; set; }
        public Korisnik Korisnik { get; set; }
    }
}
