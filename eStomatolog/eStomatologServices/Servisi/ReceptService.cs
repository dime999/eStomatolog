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
    public class ReceptService : BaseService<eStomatologModel.Recept, Models.Recept, BaseSearchObject>, IReceptService
    {
    
        public ReceptService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
            
        }

    }
}
