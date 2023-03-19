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
    public class UslugaService : BaseService<eStomatologModel.Usluga, Models.Usluga>, IService<eStomatologModel.Usluga>
    {
        
        public UslugaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
         
        }
      
    }
}
