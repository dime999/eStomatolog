using AutoMapper;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class OrdinacijaService : BaseCRUDService<eStomatologModel.Ordinacije, Database.Ordinacije, BaseSearchObject, OrdinacijaUpsertRequest, OrdinacijaUpsertRequest>, IOrdinacijaService
    {
        public OrdinacijaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }


        public eStomatologModel.Izvjestaj GetIzvjestaj(int ordinacijaId)
        {
            Izvjestaj izvjestaj = new Izvjestaj();

            izvjestaj.BrojDoktora = Context.DoktoriOrdinacije.Where(x => x.OrdinacijaId == ordinacijaId).Count();
            izvjestaj.BrojPacijenta = Context.PacijentiOrdinacije.Where(x => x.OrdinacijaId == ordinacijaId).Count();
            izvjestaj.UkopnoKorisnika = Context.DoktoriOrdinacije.Where(x => x.OrdinacijaId == ordinacijaId).Count() + Context.PacijentiOrdinacije.Where(x => x.OrdinacijaId == ordinacijaId).Count();
            izvjestaj.BrojRezervacija = Context.Rezervacije.Where(x => x.OrdinacijaId == ordinacijaId).Count();
            izvjestaj.BrojAktinihRezervacija = Context.Rezervacije.Where(x => x.OrdinacijaId == ordinacijaId && x.Datum > DateTime.Now).Count();
            izvjestaj.BrojNeaktivnihRezervacija = Context.Rezervacije.Where(x => x.OrdinacijaId == ordinacijaId && x.Datum < DateTime.Now).Count();
            izvjestaj.BrojNalaza = Context.Dijagnoze.Count();
            izvjestaj.BrojPoklonBonova = Context.PoklonBonovi.Where(x => x.OrdinacijaId == ordinacijaId).Count();

            return izvjestaj;
        }


    }
}
