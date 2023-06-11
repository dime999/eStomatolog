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
   
    public class RezervacijaService : BaseCRUDService<eStomatologModel.Rezervacija, Database.Rezervacija, RezervacijaSearchRequest, RezervacijaInsertRequest, RezervacijaInsertRequest>, IRezervacijeService
    {
        public RezervacijaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IEnumerable<Rezervacija> Get(RezervacijaSearchRequest search = null)
        {
            var entity = Context.Set<eStomatologServices.Database.Rezervacija>().Include(pac => pac.Pacijent).Include(dok=> dok.Doktor).Include(ord=> ord.Ordinacija).AsQueryable();
            var list = entity.ToList();
            return Mapper.Map<IList<Rezervacija>>(list);
        }

    }
}
