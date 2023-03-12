using AutoMapper;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class PacijentService : IPacijentService
    {
        public eStomatologContext Context { get; set; }
        public IMapper Mapper { get; set; }

        public PacijentService(eStomatologContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public IEnumerable<eStomatologModel.Pacijent> Get()
        {
            List<eStomatologModel.Pacijent> list = new List<eStomatologModel.Pacijent>();
            var result = Context.Pacijenti.ToList();

            return Mapper.Map<List<eStomatologModel.Pacijent>>(result);

        }

        public eStomatologModel.Pacijent GetById(int id)
        {
            var result = Context.Pacijenti.Find(id);

            return Mapper.Map<eStomatologModel.Pacijent>(result);
        }
    }
}
