using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices
{
    public class PacijentService : IPacijentService
    {
       public eStomatologContext Context { get; set; }

        public PacijentService(eStomatologContext context)
        {
            Context = context;
        }

        public IEnumerable<Pacijent> Get()
        {
            var tmp = Context.Pacijenti.ToList();

            return tmp;
        }

        //public Pacijent GetByID(int id)
        //{
           
        //}
    }
}
