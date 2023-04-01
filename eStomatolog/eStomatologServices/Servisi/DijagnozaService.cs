using AutoMapper;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class DijagnozaService : BaseCRUDService<eStomatologModel.Dijagnoza,Models.Dijagnoza, BaseSearchObject,DijanozaInsertRequest,DijanozaInsertRequest>, IDijagnozaService
    {
       
        public DijagnozaService(eStomatologContext context,IMapper mapper) : base(context,mapper)
        {
            
        }
    }
}
