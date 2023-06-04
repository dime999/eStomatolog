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

    public interface IPacijentiOrdinacijeService : ICRUDService<PacijentOrdinacija, BaseSearchObject, PacijentOrdinacijaInsertRequest, PacijentOrdinacijaInsertRequest>
    {
        public IEnumerable<PacijentOrdinacija> GetByOrdinacijaId(int id);
    }
}
