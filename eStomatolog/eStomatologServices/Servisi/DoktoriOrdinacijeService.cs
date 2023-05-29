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

    public class DoktoriOrdinacijeService : BaseCRUDService<eStomatologModel.DoktorOrdinacija, Database.DoktorOrdinacija, BaseSearchObject, DoktorOrdinacijaInsertRequest, DoktorOrdinacijaInsertRequest>, IDoktoriOrdinacije
    {

        public DoktoriOrdinacijeService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IEnumerable<DoktorOrdinacija> Get(BaseSearchObject search = null)
        {
            var entity = Context.Set<eStomatologServices.Database.DoktorOrdinacija>().Include(dor=>dor.Doktor).Include(or=> or.Ordinacija).AsQueryable();
            var list = entity.ToList();
            //NOTE: elaborate IEnumerable vs IList
            return Mapper.Map<IList<DoktorOrdinacija>>(list);
        }

        public IEnumerable<DoktorOrdinacija> GetByDoktorId(int id)
        {
            var entity = Context.Set<eStomatologServices.Database.DoktorOrdinacija>().Include(or => or.Ordinacija).Where(x=>x.DoktorId==id).AsQueryable();
            var list = entity.ToList();
           
            return Mapper.Map<IList<DoktorOrdinacija>>(list);
        }



    }
}
