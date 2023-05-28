using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class KorisniciUpdateRequest
    {
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string KorisnickoIme { get; set; }
        public bool? Status { get; set; }
    }
}
