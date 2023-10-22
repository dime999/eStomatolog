using AutoMapper;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Database;
using eStomatologServices.Interfejsi;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{

    public class OcjeneService : BaseCRUDService<eStomatologModel.Ocjene, eStomatologServices.Database.Ocjene, BaseSearchObject, OcjenaUpsertRequest, OcjenaUpsertRequest>, IOcjenaService
    {
        private readonly IPacijentService _pacijentService;
        private readonly IDoktorService _doktorService;

        public OcjeneService(eStomatologContext context, IMapper mapper, IPacijentService pacijentService, IDoktorService doktorService) : base(context, mapper)
        {
            this._pacijentService = pacijentService;
            this._doktorService = doktorService;
        }

        public override eStomatologModel.Ocjene Insert(OcjenaUpsertRequest insert)
        {
            var entity = base.Insert(insert);

            var pacijent = _pacijentService.GetById(insert.PacijentId);
            var doktor = _doktorService.GetById(insert.DoktorId);

            if (pacijent != null)
            {
                entity.Pacijent = pacijent;
            }

            if (doktor != null)
            {
                entity.Doktor = doktor;
            }
            Context.SaveChanges();
            return entity;
        }

        public IEnumerable<eStomatologModel.Ocjene> GetByDoktorId(int id)
        {
            var ocjene = Context.Set<Database.Ocjene>().Where(d => d.DoktorId == id).Include(r => r.Pacijent).Include(o => o.Doktor).AsQueryable();
            var list = ocjene.ToList();

            return Mapper.Map<IList<eStomatologModel.Ocjene>>(list);
        }



    }
}
