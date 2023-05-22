using AutoMapper;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
   

    public class SpecijalizacijaService : BaseService<eStomatologModel.Specijalizacija, Database.Specijalizacija, BaseSearchObject>, ISpecijalizacijaService
    {
        public SpecijalizacijaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
