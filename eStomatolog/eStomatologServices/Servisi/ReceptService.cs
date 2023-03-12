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
    public class ReceptService : IReceptService
    {
        public eStomatologContext Context;
        public IMapper Mapper;

        public ReceptService(eStomatologContext context,IMapper mapper)
        {
            Context= context;
            Mapper= mapper;
        }

        public IEnumerable<eStomatologModel.Recept> Get()
        {
           List<eStomatologModel.Recept> list = new List<Recept>();

            var result = Context.Recepti.ToList();

            return Mapper.Map<List<eStomatologModel.Recept>>(result);

        }

        public eStomatologModel.Recept GetById(int id)
        {
            var result = Context.Recepti.Find(id);
            return Mapper.Map<eStomatologModel.Recept>(result);
        }
    }
}
