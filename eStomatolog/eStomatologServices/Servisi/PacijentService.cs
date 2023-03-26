using AutoMapper;
using eStomatologModel.SearchObjects;
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
    public class PacijentService : BaseService<eStomatologModel.Pacijent, Models.Pacijent, PacijentSearchObject>, IPacijentService
    {    
        public PacijentService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
           
        }

        public override IQueryable<eStomatologServices.Models.Pacijent> AddFilter(IQueryable<eStomatologServices.Models.Pacijent> query, PacijentSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrEmpty(search?.Ime))
            {
                filteredQuery = filteredQuery.Where(x => x.Ime == search.Ime);
            }

            return filteredQuery;
        }

    }
}
