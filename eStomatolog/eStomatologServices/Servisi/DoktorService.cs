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

namespace eStomatologServices.Servisi
{
   
    
    public class DoktorService : BaseCRUDService<eStomatologModel.Doktor, Models.Doktor, BaseSearchObject, DoktorUpsertRequest, DoktorUpsertRequest>, IDoktorService
    {
       

        public DoktorService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {

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

    }
}
