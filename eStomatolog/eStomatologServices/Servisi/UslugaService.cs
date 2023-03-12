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
    public class UslugaService : IUslugaService
    {
        public eStomatologContext Context;
        public IMapper Mapper;

        public UslugaService(eStomatologContext context,IMapper mapper)
        {
            Context= context;
            Mapper= mapper;
        }

        public IEnumerable<eStomatologModel.Usluga> Get()
        {
           List<eStomatologModel.Usluga> list = new List<Usluga>();

            var result = Context.Usluge.ToList();

            return Mapper.Map<List<eStomatologModel.Usluga>>(result);

        }

        public eStomatologModel.Usluga GetById(int id)
        {
            var result = Context.Usluge.Find(id);
            return Mapper.Map<eStomatologModel.Usluga>(result);
        }
    }
}
