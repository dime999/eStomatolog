using AutoMapper;
using eStomatologModel.SearchObjects;
using eStomatologModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eStomatologModel.Requests;
using eStomatologServices.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eStomatologServices.Servisi
{
   

 
    public class DoktorSpecijalizacijeService : BaseCRUDService<eStomatologModel.DoktoriSpecijalizacije, Database.DoktoriSpecijalizacije, BaseSearchObject, DoktoriSpecijalizacijeUpsertRequest, DoktoriSpecijalizacijeUpsertRequest>, IDoktorSpecijalizacijeService
    {

        public DoktorSpecijalizacijeService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IEnumerable<DoktoriSpecijalizacije> Get(BaseSearchObject search = null)
        {
            var entity = Context.Set<eStomatologServices.Database.DoktoriSpecijalizacije>().Include(o=> o.Specijalizacija).Include(o=>o.Doktor).AsQueryable();
            var list = entity.ToList();

            return Mapper.Map<IList<DoktoriSpecijalizacije>>(list);
        }

        public IEnumerable<DoktoriSpecijalizacije> GetByDoktorId(int id)
        {
            var entity = Context.Set<eStomatologServices.Database.DoktoriSpecijalizacije>().Include(s => s.Specijalizacija).Where(x => x.DoktorId == id).AsQueryable();
            var list = entity.ToList();
            return Mapper.Map<IList<DoktoriSpecijalizacije>>(list);
        }

    }

}
