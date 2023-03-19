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
    public class TerminService : BaseService<eStomatologModel.Termin, Models.Termin>, IService<eStomatologModel.Termin>
    {
        
        public TerminService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
            
        }   
    }
}
