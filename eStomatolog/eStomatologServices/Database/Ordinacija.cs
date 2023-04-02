using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class Ordinacija
    {
        public int Id { get; set; }
        public string Naziv { get; set; }
        public string Adresa { get; set; }
        public string Grad { get; set; }
        public string Drzava { get; set; }
        public string Telefon { get; set; }
        public virtual ICollection<Doktor> Doktori { get; set; }
    }
}
