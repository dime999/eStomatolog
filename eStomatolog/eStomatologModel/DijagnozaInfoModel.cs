using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class DijagnozaInfoModel
    {
        public Doktor Doktor { get; set; }


        public string DoktorIme => Doktor?.Ime;

        public string Opis { get; set; }

        public DateTime Datum { get; set; }
    }
}
