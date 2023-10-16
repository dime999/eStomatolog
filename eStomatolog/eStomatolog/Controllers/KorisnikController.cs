using eStomatologModel.Requests;
using eStomatologModel;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace eStomatolog.Controllers
{

    public class KorisnikController : BaseCRUDController<eStomatologModel.Korisnik, KorisnikSearchObject,KorisniciInsertRequest,KorisniciUpdateRequest>
    {
        private readonly IKorisniciService service;
       
        public KorisnikController(IKorisniciService service)
            : base(service)
        {
            this.service = service;
        }
        //[Authorize(Roles ="Administrator")]
        [AllowAnonymous]
        public override eStomatologModel.Korisnik Insert([FromBody] KorisniciInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override eStomatologModel.Korisnik Update(int id,[FromBody] KorisniciUpdateRequest update)
        {
            return base.Update(id,update);
        }

        [Authorize(Roles = "Administrator")]
        public override eStomatologModel.Korisnik Delete(int id)
        {
            return service.Delete(id);
           
        }

        [Authorize(Roles = "Administrator")]
        [HttpGet("/GetByKorisnickoIme")]
        public eStomatologModel.Korisnik GetByKorisnickoIme(string ime)
        {
            return service.GetByKorisnickoIme(ime);

        }


        [AllowAnonymous]
        [HttpGet("/Login")]
        public async Task<eStomatologModel.Korisnik> Login([FromQuery] KorisnikLoginRequest request)
        {
            return await service.Login(request.Username, request.Password);
        }




    }
}
