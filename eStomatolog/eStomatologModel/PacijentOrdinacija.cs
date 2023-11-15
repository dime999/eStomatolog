using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class PacijentOrdinacija
    {
       
        public Pacijent Pacijnet { get; set; }


        public string PacijentIme => Pacijnet?.Ime;

        public string PacijentPrezime => Pacijnet?.Prezime;

        public int KorisnikId => Pacijnet.KorisnikId;

        public int PacijentId => Pacijnet.Id;
    }
}
