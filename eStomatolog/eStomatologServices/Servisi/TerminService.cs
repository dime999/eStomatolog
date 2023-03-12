using AutoMapper;
using eStomatologModel;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class TerminService : ITerminService
    {
        public eStomatologContext Context;
        public IMapper Mapper;

        public TerminService(eStomatologContext context,IMapper mapper)
        {
            Context= context;
            Mapper= mapper;
        }

        public IEnumerable<eStomatologModel.Termin> Get()
        {
           List<eStomatologModel.Termin> list = new List<Termin>();

            var result = Context.Termini.ToList();

            return Mapper.Map<List<eStomatologModel.Termin>>(result);

        }

        public eStomatologModel.Termin GetById(int id)
        {
            var result = Context.Termini.Find(id);
            return Mapper.Map<eStomatologModel.Termin>(result);
        }
    }
}
