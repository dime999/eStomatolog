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
    public class ReceptService : BaseService<eStomatologModel.Recept, Models.Recept>, IService<eStomatologModel.Recept>
    {
    
        public ReceptService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
            
        }

    }
}
