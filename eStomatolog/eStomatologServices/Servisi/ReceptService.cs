using AutoMapper;
using eStomatologModel;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class ReceptService : BaseService<eStomatologModel.Recept, Models.Recept, object>, IReceptService
    {
    
        public ReceptService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
            
        }

    }
}
