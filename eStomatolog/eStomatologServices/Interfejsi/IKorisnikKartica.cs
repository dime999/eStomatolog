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
  
    public interface IKorisnikKartica : ICRUDService<KorisnikKartica, BaseSearchObject, KorisnikKarticaUpsertRequest, KorisnikKarticaUpsertRequest>
    {
        public IEnumerable<KorisnikKartica> GetByKorisnikId(int id);
    }
}
