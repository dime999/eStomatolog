using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public  class Pacijent
    {
        public int Id { get; set; }

        public string Ime { get; set; }

        public string Prezime { get; set; }

        public DateTime DatumRodjenja { get; set; }

        public string Adresa { get; set; } 

        public string BrojTelefona { get; set; } 

        public string Email { get; set; } 

        public string Napomene { get; set; }
    }
}
