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
    public class PlacanjaService : IPlacanjaService
    {
        public eStomatologContext Context;
        public IMapper Mapper;

        public PlacanjaService(eStomatologContext context,IMapper mapper)
        {
            Context= context;
            Mapper= mapper;
        }

        public IEnumerable<eStomatologModel.Placanja> Get()
        {
           List<eStomatologModel.Placanja> list = new List<Placanja>();

            var result = Context.Placanja.ToList();

            return Mapper.Map<List<eStomatologModel.Placanja>>(result);

        }

        public eStomatologModel.Placanja GetById(int id)
        {
            var result = Context.Placanja.Find(id);
            return Mapper.Map<eStomatologModel.Placanja>(result);
        }
    }
}
