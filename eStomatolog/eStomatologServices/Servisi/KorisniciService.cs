using AutoMapper;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Database;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Services.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;


namespace eStomatologServices.Servisi
{

    public class KorisniciService : BaseCRUDService<eStomatologModel.Korisnik, Models.Korisnik, KorisnikSearchObject,KorisniciInsertRequest,KorisniciUpdateRequest>, IKorisniciService
    {

        private IPacijentService _pacijentService;
        private IDoktorService _doktorService;

        public KorisniciService(eStomatologContext context, IMapper mapper, IPacijentService pacijentService, IDoktorService doktorService) : base(context, mapper)
        {
            _pacijentService = pacijentService;
            _doktorService = doktorService;
        }
        public override eStomatologModel.Korisnik Insert(KorisniciInsertRequest insert)
        {
            if (insert.Password != insert.PasswordPotvrda)
            {
                throw new UserException("Password and confirmation must be the same");
            }

            var entity = base.Insert(insert);

            foreach (var ulogaId in insert.UlogeIdList)
            {
                Database.KorisniciUloge korisniciUloge = new Database.KorisniciUloge();
                korisniciUloge.UlogaId = ulogaId;
                korisniciUloge.KorisnikId = entity.KorisnikId;
                korisniciUloge.DatumIzmjene = DateTime.Now;
                Context.KorisnikUloge.Add(korisniciUloge);
               
            }

            Context.SaveChanges();
            

            if (insert.UlogeIdList.Contains(1))
            {
                eStomatologServices.Models.Doktor doktor = new eStomatologServices.Models.Doktor()
                {
                    KorisnikId = entity.KorisnikId,
                    Ime=entity.Ime,
                    Prezime = entity.Prezime,
                    GradId = insert.GradId,
          
                };
                Context.Doktori.Add(doktor);
                Context.SaveChanges();

                foreach (var specijalizacijaId in insert.SpecijalizacijeIdList)
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
                foreach (var ordinacijaId in insert.OrdinacijeIdList)
                {
                    Database.DoktorOrdinacija doktoriOrdinacije = new Database.DoktorOrdinacija();
                    doktoriOrdinacije.OrdinacijaId = ordinacijaId;
                    doktoriOrdinacije.DoktorId = doktor.Id;
                    doktoriOrdinacije.Doktor = doktor;
                    doktoriOrdinacije.Ordinacija = Context.Ordinacija.FirstOrDefault(x => x.OrdinacijaId == ordinacijaId);
                    Context.DoktoriOrdinacije.Add(doktoriOrdinacije);
                    doktor.DoktorOrdinacije.Add(doktoriOrdinacije);
                    Context.SaveChanges();
                    
                }
               

            }
            if (insert.UlogeIdList.Contains(2))
            {
                eStomatologServices.Database.Pacijent pacijent = new eStomatologServices.Database.Pacijent()
                {
                    KorisnikId = entity.KorisnikId,
                    Ime = entity.Ime,
                    Prezime = entity.Prezime,
                    GradId = insert.GradId,
                    Telefon = insert.Telefon,
                    DatumRodjenja= insert.DatumRodjenja,
                };
                Context.Pacijenti.Add(pacijent);
                Context.SaveChanges();


                foreach (var ordinacijaId in insert.OrdinacijeIdList)
                {
                    Database.PacijentOrdinacija pacijentOrdinacija = new Database.PacijentOrdinacija();
                    pacijentOrdinacija.OrdinacijaId = ordinacijaId;
                    pacijentOrdinacija.PacijentId = pacijent.Id;
                    pacijentOrdinacija.Pacijnet = pacijent;
                    pacijentOrdinacija.Ordinacija = Context.Ordinacija.FirstOrDefault(x => x.OrdinacijaId == ordinacijaId);
                    Context.PacijentiOrdinacije.Add(pacijentOrdinacija);
                    pacijent.PacijentOrdinacije.Add(pacijentOrdinacija);
                    Context.SaveChanges();
                }


            }

            return entity;
        }

        public override eStomatologModel.Korisnik Update(int id,KorisniciUpdateRequest insert)
        {

            if (insert.Password != insert.PasswordPotvrda && insert.Password!="" && insert.PasswordPotvrda != "")
            {
                throw new UserException("Password and confirmation must be the same");
            }
            var set = Context.Set<eStomatologServices.Models.Korisnik>();
            var entity = set.Find(id);

        

            entity.KorisnickoIme = insert.KorisnickoIme;
            entity.Prezime=insert.Prezime;
            entity.Telefon=insert.Telefon;
            entity.Email=insert.Email;  
            entity.Ime=insert.Ime;
            entity.Status=insert.Status;

            if(insert.Password != "")
            {
                var salt = GenerateSalt();
                entity.LozinkaSalt = salt;
                entity.LozinkaHash = GenerateHash(salt, insert.Password);
            }


            if (entity != null)
            {
                Mapper.Map(insert, entity);
            }


            foreach (var ulogaId in insert.UlogeIdList)
            {
                Database.KorisniciUloge korisniciUloge = new Database.KorisniciUloge();
                korisniciUloge.UlogaId = ulogaId;
                korisniciUloge.KorisnikId = id;
                korisniciUloge.DatumIzmjene = DateTime.Now;
                Context.KorisnikUloge.Add(korisniciUloge);

            }

            Context.SaveChanges();


            if (insert.UlogeIdList.Contains(1))
            {
               
                var doktor = Context.Doktori.FirstOrDefault(x=> x.KorisnikId==id);
                doktor.Ime = insert.Ime;
                doktor.Prezime= insert.Prezime; 
                doktor.GradId=insert.GradId;
                Context.Doktori.Update(doktor);
                Context.SaveChanges();



                var existingDoktorSpecijalizacije = Context.DoktoriSpecijalizacije.Where(x => x.DoktorId == doktor.Id).ToList();


                Context.DoktoriSpecijalizacije.RemoveRange(existingDoktorSpecijalizacije);
                Context.SaveChanges();

                foreach (var specijalizacijaId in insert.SpecijalizacijeIdList)
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
                var existingDoktorOrdinacije = Context.DoktoriOrdinacije.Where(x => x.DoktorId == doktor.Id).ToList();

                
                Context.DoktoriOrdinacije.RemoveRange(existingDoktorOrdinacije);
                Context.SaveChanges();
                foreach (var ordinacijaId in insert.OrdinacijeIdList)
                {
                    Database.DoktorOrdinacija doktoriOrdinacije = new Database.DoktorOrdinacija();
                    doktoriOrdinacije.OrdinacijaId = ordinacijaId;
                    doktoriOrdinacije.DoktorId = doktor.Id;
                    doktoriOrdinacije.Doktor = doktor;
                    doktoriOrdinacije.Ordinacija = Context.Ordinacija.FirstOrDefault(x => x.OrdinacijaId == ordinacijaId);
                    Context.DoktoriOrdinacije.Add(doktoriOrdinacije);
                    doktor.DoktorOrdinacije.Add(doktoriOrdinacije);
                    Context.SaveChanges();

                }


            }
            if (insert.UlogeIdList.Contains(2))
            {
                var pacijent = Context.Pacijenti.FirstOrDefault(x => x.KorisnikId == id);
                pacijent.Ime = insert.Ime;
                pacijent.Prezime = insert.Prezime;
                pacijent.GradId = insert.GradId;
                Context.Pacijenti.Update(pacijent);
               
                Context.SaveChanges();


                var existingPacijentOrdinacije = Context.PacijentiOrdinacije.Where(x => x.PacijentId == pacijent.Id).ToList();


                Context.PacijentiOrdinacije.RemoveRange(existingPacijentOrdinacije);
                Context.SaveChanges();
                if (insert.OrdinacijeIdList.Count > 0)
                {
                    foreach (var ordinacijaId in insert.OrdinacijeIdList)
                    {
                        Database.PacijentOrdinacija pacijentOrdinacija = new Database.PacijentOrdinacija();
                        pacijentOrdinacija.OrdinacijaId = ordinacijaId;
                        pacijentOrdinacija.PacijentId = pacijent.Id;
                        pacijentOrdinacija.Pacijnet = pacijent;
                        pacijentOrdinacija.Ordinacija = Context.Ordinacija.FirstOrDefault(x => x.OrdinacijaId == ordinacijaId);
                        Context.PacijentiOrdinacije.Add(pacijentOrdinacija);
                        pacijent.PacijentOrdinacije.Add(pacijentOrdinacija);
                        Context.SaveChanges();

                    }
                }
                else
                {
                    foreach (var ordinacija in existingPacijentOrdinacije)
                    {
                        Database.PacijentOrdinacija pacijentOrdinacija = new Database.PacijentOrdinacija();
                        pacijentOrdinacija.OrdinacijaId = ordinacija.OrdinacijaId;
                        pacijentOrdinacija.PacijentId = pacijent.Id;
                        pacijentOrdinacija.Pacijnet = pacijent;
                        pacijentOrdinacija.Ordinacija = Context.Ordinacija.FirstOrDefault(x => x.OrdinacijaId == ordinacija.OrdinacijaId);
                        Context.PacijentiOrdinacije.Add(pacijentOrdinacija);
                        pacijent.PacijentOrdinacije.Add(pacijentOrdinacija);
                        Context.SaveChanges();

                    }

                }


            }

            return Mapper.Map<eStomatologModel.Korisnik>(entity);
        }





        public override void BeforeInsert(KorisniciInsertRequest insert, Models.Korisnik entity)
        {
            var salt = GenerateSalt();
            entity.LozinkaSalt = salt;
            entity.LozinkaHash = GenerateHash(salt, insert.Password);
            base.BeforeInsert(insert, entity);
        }


        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

       




        public override IQueryable<Models.Korisnik> AddFilter(IQueryable<Models.Korisnik> query, KorisnikSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.KorisnickoIme))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnickoIme == search.KorisnickoIme);
            }

            if (!string.IsNullOrWhiteSpace(search?.NameFTS))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnickoIme.Contains(search.NameFTS)
                    || x.Ime.Contains(search.NameFTS)
                    || x.Prezime.Contains(search.NameFTS));
            }

            return filteredQuery;
        }

        public override IQueryable<Models.Korisnik> AddInclude(IQueryable<Models.Korisnik> query, KorisnikSearchObject search = null)
        {
            if (search?.IncludeRoles == true)
            {
                query = query.Include("KorisniciUloges.Uloga");
            }
            return query;
        }

        public override eStomatologModel.Korisnik Delete(int id)
        {


            var korisniciUloge = Context.KorisnikUloge.Where(ku => ku.KorisnikId == id).ToList();

            foreach (var korisnikUloga in korisniciUloge)
            {
                if(korisnikUloga.UlogaId == 2)
                {
                    var pacijent = _pacijentService.GetByKorisnikId(id);
                    if (pacijent != null)
                    {
                        _pacijentService.Delete(pacijent.Id);
                    }

                }

                if (korisnikUloga.UlogaId == 1)
                {
                    var doktor = _doktorService.GetByKorisnikId(id);
                    if (doktor != null)
                    {
                        _doktorService.Delete(doktor.Id);
                    }

                }
                Context.KorisnikUloge.Remove(korisnikUloga);
            }

            var set = Context.Set<Models.Korisnik>(); 


            var entity = set.Find(id);

            set.Remove(entity);

            Context.SaveChanges();

            return Mapper.Map<eStomatologModel.Korisnik>(entity);
        }

        public eStomatologModel.Korisnik GetByKorisnickoIme(string ime)
        {
            var korisnik = Context.Korisnik.FirstOrDefault(ku => ku.KorisnickoIme == ime);
            return Mapper.Map<eStomatologModel.Korisnik>(korisnik);
        }





        public async Task<eStomatologModel.Korisnik> Login(string username, string password)
        {
            var entity = await Context.Korisnik.Include("KorisniciUloges.Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == username);
            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }

            return Mapper.Map<eStomatologModel.Korisnik>(entity);
        }

    }
}
