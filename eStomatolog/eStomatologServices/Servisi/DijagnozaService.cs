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
    public class DijagnozaService : IDijagnozaService
    {
        public eStomatologContext Context;
        public IMapper Mapper;

        public DijagnozaService(eStomatologContext context,IMapper mapper)
        {
            Context= context;
            Mapper= mapper;
        }

        public IEnumerable<eStomatologModel.Dijagnoza> Get()
        {
           List<eStomatologModel.Dijagnoza> list = new List<Dijagnoza>();

            var result = Context.Dijagnoze.ToList();

            return Mapper.Map<List<eStomatologModel.Dijagnoza>>(result);

        }

        public eStomatologModel.Dijagnoza GetById(int id)
        {
            var result = Context.Dijagnoze.Find(id);
            return Mapper.Map<eStomatologModel.Dijagnoza>(result);
        }
    }
}
