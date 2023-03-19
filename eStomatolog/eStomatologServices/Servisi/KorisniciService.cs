using AutoMapper;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{

    public class KorisniciService : BaseService<eStomatologModel.Korisnik, Models.Korisnik>, IService<eStomatologModel.Korisnik>
    {
       
        public KorisniciService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
           
        }

    }
}
