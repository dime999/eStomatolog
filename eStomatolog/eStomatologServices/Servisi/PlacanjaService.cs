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
    public class PlacanjaService : BaseService<eStomatologModel.Placanja, Models.Placanja>, IService<eStomatologModel.Placanja>
    {
        
        public PlacanjaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
            
        }

    }
}
