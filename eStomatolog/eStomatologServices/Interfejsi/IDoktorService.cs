using eStomatologModel;
using eStomatologModel.SearchObjects;
using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IDoktorService : IService<eStomatologModel.Doktor, BaseSearchObject>
    {
        public eStomatologModel.Doktor GetByKorisnikId(int id);
    }
}
