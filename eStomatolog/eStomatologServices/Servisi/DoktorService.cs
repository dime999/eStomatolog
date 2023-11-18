using AutoMapper;
using eStomatologModel;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Text.Json;
using Newtonsoft.Json;
using System.Threading.Tasks;
using Doktor = eStomatologServices.Models.Doktor;
using eStomatologModel.Requests;
using eStomatologServices.Database;
using Microsoft.VisualStudio.Services.Identity;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;

namespace eStomatologServices.Servisi
{


    public class DoktorService : BaseCRUDService<eStomatologModel.Doktor, Models.Doktor, BaseSearchObject, DoktorUpsertRequest, DoktorUpsertRequest>, IDoktorService
    {

        private IPacijentService _pacijentService;
        public DoktorService(eStomatologContext context, IMapper mapper, IPacijentService pacijentService) : base(context, mapper)
        {
            _pacijentService = pacijentService;
        }


        public eStomatologModel.Doktor GetByKorisnikId(int id)
        {
            var Doktor = Context.Set<eStomatologServices.Models.Doktor>().FirstOrDefault(d => d.KorisnikId == id);

            return Mapper.Map<eStomatologModel.Doktor>(Doktor);
        }

        public override eStomatologModel.Doktor Update(int id, DoktorUpsertRequest update)
        {
            eStomatologModel.Doktor existingDoktor = base.GetById(id);
            eStomatologServices.Models.Doktor doktor = new eStomatologServices.Models.Doktor()
            {
                Id = existingDoktor.Id,
                Ime = existingDoktor.Ime,
                Prezime = existingDoktor.Prezime,
                GradId = existingDoktor.GradId,

            };

            if (doktor == null)
            {
                throw new Exception("Doktor nije pronađen");
            }

            doktor.Ime = update.Ime;
            doktor.Prezime = update.Prezime;


            foreach (var specijalizacijaId in update.SpecijalizacijeIdList)
            {
                Database.DoktoriSpecijalizacije doktoriSpecijalizacije = new Database.DoktoriSpecijalizacije();
                doktoriSpecijalizacije.SpecijalizacijaId = specijalizacijaId;
                doktoriSpecijalizacije.DoktorId = doktor.Id;
                doktoriSpecijalizacije.Doktor = doktor;
                doktoriSpecijalizacije.Specijalizacija = Context.Specijalizacije.FirstOrDefault(x => x.SpecijalizacijaId == specijalizacijaId);
                Context.DoktoriSpecijalizacije.Add(doktoriSpecijalizacije);
                doktor.DoktoriSpecijalizacije.Add(doktoriSpecijalizacije);
                Context.SaveChanges();


            }
            foreach (var ordinacijaId in update.OrdinacijeIdList)
            {
                Database.DoktorOrdinacija doktorOrdinacija = new Database.DoktorOrdinacija();
                doktorOrdinacija.OrdinacijaId = ordinacijaId;
                doktorOrdinacija.DoktorId = doktor.Id;
                doktorOrdinacija.Doktor = doktor;
                doktorOrdinacija.Ordinacija = Context.Ordinacija.FirstOrDefault(x => x.OrdinacijaId == ordinacijaId);
                Context.DoktoriOrdinacije.Add(doktorOrdinacija);
                doktor.DoktorOrdinacije.Add(doktorOrdinacija);
                Context.SaveChanges();


            }

            Context.SaveChanges();

            return existingDoktor;
        }

        public override eStomatologModel.Doktor Delete(int id)
        {


            var ocjene = Context.Ocjene.Where(o => o.DoktorId == id).ToList();

            if (ocjene != null && ocjene.Count() > 0)
            {
                foreach (var ocjena in ocjene)
                {

                    Context.Ocjene.Remove(ocjena);
                }
            }

            var rezervacije = Context.Rezervacije.Where(o => o.DoktorId == id).ToList();

            if (rezervacije != null && rezervacije.Count() > 0)
            {
                foreach (var rez in rezervacije)
                {

                    Context.Rezervacije.Remove(rez);
                }
            }

            var nalazi = Context.Dijagnoze.Where(o => o.DoktorId == id).ToList();

            if (nalazi != null && nalazi.Count() > 0)
            {
                foreach (var nalaz in nalazi)
                {

                    Context.Dijagnoze.Remove(nalaz);
                }
            }



            var set = Context.Set<Models.Doktor>();


            var entity = set.Find(id);

            set.Remove(entity);

            Context.SaveChanges();

            return Mapper.Map<eStomatologModel.Doktor>(entity);
        }

        public IEnumerable<eStomatologModel.Doktor> Recommended(int id)
        {
            var pearsonCorellation = _pacijentService.PronadiNajblizegPacijenta(id);


            var ocjene = Context.Ocjene
           .Where(o => o.PacijentId == pearsonCorellation.Id)
           .OrderByDescending(o => o.Ocjena)
           .Take(3)
           .ToList();

            if (ocjene.Count == 0 || ocjene==null)
            {
                var ocjeneDef = Context.Ocjene
          .OrderByDescending(o => o.Ocjena)
          .Take(3)
          .ToList();


                List<int> doktoriIdsDef = new List<int>();
                foreach (var ocjena in ocjeneDef)
                {
                    doktoriIdsDef.Add(ocjena.DoktorId);
                }


                List<eStomatologModel.Doktor> doktoriDef = new List<eStomatologModel.Doktor>();
                foreach (var idDoktora in doktoriIdsDef)
                {
                    var entity = Context.Set<eStomatologServices.Models.Doktor>().FirstOrDefault(x => x.Id == idDoktora);
                    doktoriDef.Add(Mapper.Map<eStomatologModel.Doktor>(entity));

                }

                return Mapper.Map<IList<eStomatologModel.Doktor>>(doktoriDef);
            }

            List<int> doktoriIds = new List<int>();
            foreach (var ocjena in ocjene)
            {
                doktoriIds.Add(ocjena.DoktorId);
            }


            List<eStomatologModel.Doktor> doktori = new List<eStomatologModel.Doktor> ();
            foreach (var idDoktora in doktoriIds) {
                var entity = Context.Set<eStomatologServices.Models.Doktor>().FirstOrDefault(x => x.Id == idDoktora);
                doktori.Add(Mapper.Map<eStomatologModel.Doktor>(entity));
               
            }
          
            return Mapper.Map<IList<eStomatologModel.Doktor>>(doktori);
        }


       
    }


}


