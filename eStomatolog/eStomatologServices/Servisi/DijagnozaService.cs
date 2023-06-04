using AutoMapper;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class DijagnozaService : BaseCRUDService<eStomatologModel.Dijagnoza,Models.Dijagnoza, BaseSearchObject,DijanozaInsertRequest,DijagnozaUpdateRequest>, IDijagnozaService
    {
       
        public DijagnozaService(eStomatologContext context,IMapper mapper) : base(context,mapper)
        {
            
        }

        public IEnumerable<DijagnozaInfoModel> GetByPacijentId(int id)
        {
            var entity = Context.Set<eStomatologServices.Models.Dijagnoza>().Include(dok => dok.Doktor).Where(x => x.PacijentId == id).AsQueryable();
            var list = entity.ToList();
            return Mapper.Map<IList<DijagnozaInfoModel>>(list);
        }

    }
}
