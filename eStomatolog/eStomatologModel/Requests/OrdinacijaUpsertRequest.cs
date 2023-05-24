using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class OrdinacijaUpsertRequest
    {

        public string Naziv { get; set; } 

        public string Adresa { get; set; }

        public string Grad { get; set; } 

        public string Drzava { get; set; } 

        public string Telefon { get; set; } 

        public byte[] Slika { get; set; } 

        public virtual List<int> DoktoriId { get; set; } = new List<int> { };
    }
}
