using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class KorisnikController : Controller
    {
        private readonly IKorisniciService KorisniciService;

        public KorisnikController(IKorisniciService korisniciService)
        {
            this.KorisniciService = korisniciService;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Korisnik> Get()
        {

            return KorisniciService.Get();
        }

        //[HttpGet("{id}")]
        //public Pacijent GetById(int id)
        //{
        //    return PacijentService.GetByID(id);
        //}
    }
}
