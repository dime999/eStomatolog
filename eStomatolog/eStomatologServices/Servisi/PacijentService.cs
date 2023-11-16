using AutoMapper;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Database;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class PacijentService : BaseCRUDService<eStomatologModel.Pacijent, Database.Pacijent, PacijentSearchObject,PacijentUpdateRequest,PacijentUpdateRequest>, IPacijentService
    {
        public PacijentService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public eStomatologModel.Pacijent GetByKorisnikId(int id)
        {
            var Pacijent = Context.Set<Pacijent>().FirstOrDefault(d => d.KorisnikId == id);

            return Mapper.Map<eStomatologModel.Pacijent>(Pacijent);
        }

      

        public override IQueryable<eStomatologServices.Database.Pacijent> AddFilter(IQueryable<eStomatologServices.Database.Pacijent> query, PacijentSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrEmpty(search?.Ime))
            {
                filteredQuery = filteredQuery.Where(x => x.Ime == search.Ime);
            }
            if (search.Page.HasValue == true)
            {
                filteredQuery = filteredQuery.Take(search.Size.Value).Skip(search.Page.Value * search.Size.Value);
            }

            return filteredQuery;
        }

        public eStomatologModel.Pacijent PronadiNajblizegPacijenta(int pacijentId)
        {
            var Pacijent = Context.Set<Pacijent>().FirstOrDefault(d => d.Id == pacijentId);

           
            if (Pacijent == null)
            {
                
                return null;
            }

            var mapped = Mapper.Map<eStomatologModel.Pacijent>(Pacijent);


            var slicnosti = new List<Tuple<eStomatologModel.Pacijent, double>>();
            foreach (var drugiPacijent in Context.Set<eStomatologServices.Database.Pacijent>().Where(p => p.Id != pacijentId))
            {
                double sličnost = IzračunajPearsonKorelaciju(mapped, Mapper.Map<eStomatologModel.Pacijent>(drugiPacijent));
                slicnosti.Add(new Tuple<eStomatologModel.Pacijent, double>(Mapper.Map<eStomatologModel.Pacijent>(drugiPacijent), sličnost));
            }


            slicnosti.Sort((x, y) => y.Item2.CompareTo(x.Item2));

           var slicni = slicnosti.FirstOrDefault()?.Item1;
            return Mapper.Map<eStomatologModel.Pacijent>(slicni);
        }

        private double IzračunajPearsonKorelaciju(eStomatologModel.Pacijent pacijent1, eStomatologModel.Pacijent pacijent2)
        {
          
            var sličnostGrada = pacijent1.GradId == pacijent2.GradId ? 1.0 : 0.0;
            var sličnostDatuma = 1.0 / (1.0 + Math.Abs((pacijent1.DatumRodjenja - pacijent2.DatumRodjenja).Days));

            return (sličnostGrada + sličnostDatuma) / 2.0;
        }

    }
}
