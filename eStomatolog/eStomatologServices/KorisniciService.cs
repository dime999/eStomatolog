using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Models
{
    
    public class KorisniciService : IKorisniciService
    {
        public eStomatologContext Context { get; set; }

        public KorisniciService(eStomatologContext context)
        {
            Context = context;
        }

        public IEnumerable<eStomatologModel.Korisnik> Get()
        {
            List<eStomatologModel.Korisnik> list = new List<eStomatologModel.Korisnik>();
            
            var result= Context.Korisnik.ToList();

            foreach (var item in result)
            {
                list.Add(new eStomatologModel.Korisnik() { Ime=item.Ime,Prezime=item.Prezime,KorisnickoIme=item.KorisnickoIme,Telefon=item.Telefon,Email=item.Email,Lozinka=item.Lozinka,Status=item.Status});
            }

            return list;
        }
    }
}
