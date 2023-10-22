using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{

    public interface IPoklonBonService : ICRUDService<eStomatologModel.PoklonBon, BaseSearchObject, PoklonBonUpsertRequest, PoklonBonUpsertRequest>
    {
        public IEnumerable<PoklonBon> GetByOrdinacijaId(int id);
    }
}
