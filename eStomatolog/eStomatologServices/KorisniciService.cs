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

        public IEnumerable<Korisnik> Get()
        {
            return Context.Korisnik.ToList();
        }
    }
}
