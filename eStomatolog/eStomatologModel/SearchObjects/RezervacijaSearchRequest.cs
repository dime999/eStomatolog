using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.SearchObjects
{
    public class RezervacijaSearchRequest : BaseSearchObject
    {
        public int? DoktorId { get; set; }
        public int? KorisnikId { get; set; }
        public DateTime? Od { get; set; }
        public DateTime? Do { get; set; }
        public int? OrdinacijaId { get; set; }

        public int Dan { get; set; }

        public int Mjesec { get; set; }
    }
}
