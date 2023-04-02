using AutoMapper;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Database;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class VrstaUslugeService : BaseCRUDService<eStomatologModel.VrstaUsluge, Database.VrstaUsluge, VrstaUslugeSearchObject, VrstaUslugeUpsertRequest, VrstaUslugeUpsertRequest>, IVrstaUslugeService
    {
        public VrstaUslugeService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<VrstaUsluge> AddFilter(IQueryable<VrstaUsluge> query, VrstaUslugeSearchObject search = null)
        {
           
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrEmpty(search?.NazivGT))
            {
                filteredQuery = filteredQuery.Where(x=>x.Naziv.StartsWith(search.NazivGT));
            }
            return filteredQuery;
        }
    }
}
