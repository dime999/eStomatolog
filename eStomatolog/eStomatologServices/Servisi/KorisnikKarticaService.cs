using AutoMapper;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
   

    public class KorisnikKarticaService : BaseCRUDService<eStomatologModel.KorisnikKartica, Database.KorisnikKartica, BaseSearchObject, KorisnikKarticaUpsertRequest, KorisnikKarticaUpsertRequest>, IKorisnikKartica
    {
        public KorisnikKarticaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public IEnumerable<KorisnikKartica> GetByKorisnikId(int id)
        {
            var entity = Context.Set<eStomatologServices.Database.KorisnikKartica>().Include(k => k.Korisnik).Where(x => x.KorisnikId == id).AsQueryable();
            var list = entity.ToList();
            return Mapper.Map<IList<KorisnikKartica>>(list);
        }
    }
}
