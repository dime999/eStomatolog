using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IDoktorService : ICRUDService<eStomatologModel.Doktor, BaseSearchObject,DoktorUpsertRequest,DoktorUpsertRequest>
    {
        public eStomatologModel.Doktor GetByKorisnikId(int id);
    }
}
