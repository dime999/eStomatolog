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
    public interface IPacijentService : ICRUDService<eStomatologModel.Pacijent, PacijentSearchObject,PacijentUpdateRequest,PacijentUpdateRequest>
    {
        public eStomatologModel.Pacijent GetByKorisnikId(int id);
        public eStomatologModel.Pacijent PronadiNajblizegPacijenta(int pacijentId);
    }
}
