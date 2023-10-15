using AutoMapper;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Database;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class PacijentService : BaseCRUDService<eStomatologModel.Pacijent, Database.Pacijent, PacijentSearchObject,PacijentUpdateRequest,PacijentUpdateRequest>, IPacijentService
    {
        public PacijentService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public eStomatologModel.Pacijent GetByKorisnikId(int id)
        {
            var Pacijent = Context.Set<Pacijent>().FirstOrDefault(d => d.KorisnikId == id);

            return Mapper.Map<eStomatologModel.Pacijent>(Pacijent);
        }

        public override IQueryable<eStomatologServices.Database.Pacijent> AddFilter(IQueryable<eStomatologServices.Database.Pacijent> query, PacijentSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrEmpty(search?.Ime))
            {
                filteredQuery = filteredQuery.Where(x => x.Ime == search.Ime);
            }
            if (search.Page.HasValue == true)
            {
                filteredQuery = filteredQuery.Take(search.Size.Value).Skip(search.Page.Value * search.Size.Value);
            }

            return filteredQuery;
        }

    }
}
