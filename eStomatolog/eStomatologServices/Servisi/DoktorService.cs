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
    public class DoktorService : IDoktorService
    {
        public eStomatologContext Context;
        public IMapper Mapper;

        public DoktorService(eStomatologContext context,IMapper mapper)
        {
            Context= context;
            Mapper= mapper;
        }

        public IEnumerable<eStomatologModel.Doktor> Get()
        {
           List<eStomatologModel.Doktor> list = new List<Doktor>();

            var result = Context.Doktori.ToList();

            return Mapper.Map<List<eStomatologModel.Doktor>>(result);

        }

        public eStomatologModel.Doktor GetById(int id)
        {
            var result = Context.Doktori.Find(id);
            return Mapper.Map<eStomatologModel.Doktor>(result);
        }
    }
}
