using AutoMapper;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
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
       
       
        public KorisniciService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
           
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
          
                };
                Context.Doktori.Add(doktor);
                Context.SaveChanges();

                foreach (var specijalizacijaId in insert.SpecijalizacijeIdList)
                {
                    Database.DoktoriSpecijalizacije doktoriSpecijalizacije = new Database.DoktoriSpecijalizacije();
                    doktoriSpecijalizacije.SpecijalizacijaId = specijalizacijaId;
                    doktoriSpecijalizacije.DoktorId = doktor.Id;
                    

                    Context.DoktoriSpecijalizacije.Add(doktoriSpecijalizacije);
                    Context.SaveChanges();
                }
                foreach (var ordinacijaId in insert.OrdinacijeIdList)
                {
                    Database.DoktorOrdinacija doktoriOrdinacije = new Database.DoktorOrdinacija();
                    doktoriOrdinacije.OrdinacijaId = ordinacijaId;
                    doktoriOrdinacije.DoktorId = doktor.Id;


                    Context.DoktoriOrdinacije.Add(doktoriOrdinacije);
                    Context.SaveChanges();
                }

            }

            return entity;
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
