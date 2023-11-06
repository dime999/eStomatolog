using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class PoklonBon
    {
        public int PoklonBonId { get; set; }
        public string Kod { get; set; }
        public decimal IznosPlacanja { get; set; }
        public int PacijentId { get; set; }
        public Pacijent pacijent { get; set; }
        public int OrdinacijaId { get; set; }
        public Ordinacije Ordinacija { get; set; }
        public string ImePrezimeKorisnikaKojiKoristi { get; set; }
        public bool Placeno { get; set; }
        public string BrojKartice { get; set; }
        public DateTime DatumIstekaKartice { get; set; }
        public string CvcCvvKod { get; set; }
        public bool Iskoristeno { get; set; }

        public string PacijentIme => pacijent?.Ime;

        public string PacijentPrezime => pacijent?.Prezime;

        public string OrdinacijaNaziv => Ordinacija?.Naziv;


    }
}
