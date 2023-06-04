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

    public class PacijentiOrdinacijeService : BaseCRUDService<eStomatologModel.PacijentOrdinacija, Database.PacijentOrdinacija, BaseSearchObject, PacijentOrdinacijaInsertRequest, PacijentOrdinacijaInsertRequest>, IPacijentiOrdinacijeService
    {

        public PacijentiOrdinacijeService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public IEnumerable<PacijentOrdinacija> GetByOrdinacijaId(int id)
        {
            var entity = Context.Set<eStomatologServices.Database.PacijentOrdinacija>().Include(pac => pac.Pacijnet).Where(x => x.OrdinacijaId == id).AsQueryable();
            var list = entity.ToList();
            return Mapper.Map<IList<PacijentOrdinacija>>(list);
        }

    }

}
