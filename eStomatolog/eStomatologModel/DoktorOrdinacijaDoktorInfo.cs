using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class DoktorOrdinacijaDoktorInfo
    {
        public Doktor Doktor { get; set; }


        public string DoktorIme => Doktor?.Ime;

        public string DoktorPrezime => Doktor?.Prezime;

        public int KorisnikId => Doktor.KorisnikId;
    }
}
