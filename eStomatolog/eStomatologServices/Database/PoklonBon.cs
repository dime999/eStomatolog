using eStomatologModel;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class PoklonBon
    {
        public int PoklonBonId { get; set; }
        public string Opis { get; set; }
        public decimal IznosPlacanja { get; set; }
        public int PacijentId { get; set; } 
        public Pacijent Pacijent { get; set; }
        public int OrdinacijaId { get; set; }
        public Ordinacije Ordinacija { get; set; }
        public string ImePrezimeKorisnikaKojiKoristi { get; set; } 
        public bool Placeno { get; set; }
        public string BrojKartice { get; set; }
        public DateTime DatumIstekaKartice { get; set; }
        public string CvcCvvKod { get; set; }
        public bool Iskoristeno { get; set; }
        public string PacijentIme => Pacijent?.Ime;

        public string PacijentPrezime => Pacijent?.Prezime;

        public string OrdinacijaNaziv => Ordinacija?.Naziv;

      


    }
}
