using AutoMapper;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class UlogaService : BaseService<eStomatologModel.Uloge,Database.Uloge,BaseSearchObject>, IUlogaService
    {
        public UlogaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {

        }
    }
}
