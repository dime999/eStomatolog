using AutoMapper;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class PacijentService : BaseService<eStomatologModel.Pacijent, Models.Pacijent>, IService<eStomatologModel.Pacijent>
    {    
        public PacijentService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
           
        }    
    }
}
