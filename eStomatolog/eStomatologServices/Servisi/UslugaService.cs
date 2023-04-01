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
    public class UslugaService : BaseService<eStomatologModel.Usluga, Models.Usluga, BaseSearchObject>, IUslugaService
    {
        
        public UslugaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
         
        }
      
    }
} 
