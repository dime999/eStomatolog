using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class Ordinacije
    {

        public int OrdinacijaId { get; set; }

        public string Naziv { get; set; } = null!;

        public string Adresa { get; set; } = null!;


        public string Telefon { get; set; } = null!;

        public byte[] Slika { get; set; } = null!;
    }
}
