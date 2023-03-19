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
    public class DoktorService : BaseService<eStomatologModel.Doktor, Models.Doktor>, IService<eStomatologModel.Doktor>
    {     

        public DoktorService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
            
        }

    }
}
