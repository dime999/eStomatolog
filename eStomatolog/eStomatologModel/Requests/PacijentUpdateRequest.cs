using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class PacijentUpdateRequest
    {
      
        public int GradId { get; set; }

        public string Ime { get; set; } = null;

        public string Prezime { get; set; } = null;

        public DateTime DatumRodjenja { get; set; }

        public string Telefon { get; set; }
    }
}
