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
    public interface IDoktoriOrdinacije : ICRUDService<DoktorOrdinacija, BaseSearchObject, DoktorOrdinacijaInsertRequest, DoktorOrdinacijaInsertRequest>
    {
        public IEnumerable<DoktorOrdinacija> GetByDoktorId(int id);

    }
}