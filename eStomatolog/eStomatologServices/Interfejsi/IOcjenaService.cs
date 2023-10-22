using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IOcjenaService : ICRUDService<eStomatologModel.Ocjene, BaseSearchObject, OcjenaUpsertRequest, OcjenaUpsertRequest>
    {
        public IEnumerable<eStomatologModel.Ocjene> GetByDoktorId(int id);
    }
}
