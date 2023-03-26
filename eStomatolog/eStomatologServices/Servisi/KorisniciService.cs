using AutoMapper;
using eStomatologModel;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{

    public class KorisniciService : BaseService<eStomatologModel.Korisnik, Models.Korisnik, KorisnikSearchObject>, IKorisniciService
    {
       
        public KorisniciService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
           
        }


        public override IQueryable<eStomatologServices.Models.Korisnik> AddFilter(IQueryable<eStomatologServices.Models.Korisnik> query, KorisnikSearchObject search = null)
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
