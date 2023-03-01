using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices
{
    public class PacijentService : IPacijentService
    {
        public List<Pacijent> PacijentList = new List<Pacijent>() { new Pacijent() { Id = 1, Ime = "User", Prezime = "User" } };

        public IEnumerable<Pacijent> Get()
        {
            return PacijentList;
        }

        public Pacijent GetByID(int id)
        {
            return PacijentList.FirstOrDefault(x=>x.Id==id);
        }
    }
}
