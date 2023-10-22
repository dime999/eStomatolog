using AutoMapper;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologModel;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.Services.Users;
using Microsoft.EntityFrameworkCore;

namespace eStomatologServices.Servisi
{
   
    public class PoklonBonService : BaseCRUDService<PoklonBon, eStomatologServices.Database.PoklonBon, BaseSearchObject, PoklonBonUpsertRequest, PoklonBonUpsertRequest>, IPoklonBonService
    {
        private readonly IPacijentService _pacijentService;
        private readonly IOrdinacijaService _ordinacijaService;

        public PoklonBonService(eStomatologContext context, IMapper mapper,IPacijentService pacijentService, IOrdinacijaService ordinacijaService) : base(context, mapper)
        {
            this._pacijentService = pacijentService;
            this._ordinacijaService = ordinacijaService;
        }
        public override PoklonBon Insert(PoklonBonUpsertRequest insert)
        {

            var entity = base.Insert(insert);

            var pacijent = _pacijentService.GetById(insert.PacijentId);
            var ordinacija = _ordinacijaService.GetById(insert.OrdinacijaId);

            if (pacijent!=null)
            {
                entity.pacijent = pacijent;
            }

            if (ordinacija != null)
            {
                entity.Ordinacija = ordinacija;
            }
            Context.SaveChanges();
            return entity;

        }

        public IEnumerable<PoklonBon> GetByOrdinacijaId(int id)
        {
            var PoklonBoniovi = Context.Set<Database.PoklonBon>().Where(d => d.OrdinacijaId == id).Include(r => r.Pacijent).Include(o => o.Ordinacija).AsQueryable();
            var list = PoklonBoniovi.ToList();

            return Mapper.Map<IList<PoklonBon>>(list);
        }

    }
}
