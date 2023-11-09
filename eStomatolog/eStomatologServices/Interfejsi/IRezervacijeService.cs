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

    public interface IRezervacijeService : ICRUDService<eStomatologModel.Rezervacija, RezervacijaSearchRequest, RezervacijaInsertRequest, RezervacijaInsertRequest>
    {
        public IEnumerable<Rezervacija> GetByOrdinacijaId(int id);
        public IEnumerable<Rezervacija> GetByPacijentId(int ordinacijaId, int pacijentId);
        public IEnumerable<Rezervacija> GetByPacijent(int pacijentId);
        public IEnumerable<Rezervacija> DohvatiZauzeteTermine(int ordinacijaId, DateTime datum);
    }
}
