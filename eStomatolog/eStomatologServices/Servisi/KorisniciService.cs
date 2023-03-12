using AutoMapper;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{

    public class KorisniciService : IKorisniciService
    {
        public eStomatologContext Context { get; set; }
        public IMapper Mapper { get; set; }

        public KorisniciService(eStomatologContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public IEnumerable<eStomatologModel.Korisnik> Get()
        {
            List<eStomatologModel.Korisnik> list = new List<eStomatologModel.Korisnik>();

            var result = Context.Korisnik.ToList();

            return Mapper.Map<List<eStomatologModel.Korisnik>>(result);
        }

        public eStomatologModel.Korisnik GetById(int id)
        {
            var result = Context.Korisnik.Find(id);
            return Mapper.Map<eStomatologModel.Korisnik>(result);
        }
    }
}
