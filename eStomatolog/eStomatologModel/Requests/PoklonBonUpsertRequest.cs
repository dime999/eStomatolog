using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class PoklonBonUpsertRequest
    {
        public string Kod { get; set; }
        public decimal IznosPlacanja { get; set; }
        public int PacijentId { get; set; }
        public int OrdinacijaId { get; set; }
        public string ImePrezimeKorisnikaKojiKoristi { get; set; }
        public bool Placeno { get; set; }
        public string BrojKartice { get; set; }
        public DateTime DatumIstekaKartice { get; set; }
        public string CvcCvvKod { get; set; }
        public bool Iskoristeno { get; set; }
    }
}
