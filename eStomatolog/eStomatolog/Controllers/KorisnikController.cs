using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class KorisnikController : Controller
    {
        private readonly IService<eStomatologModel.Korisnik,KorisnikSearchObject> _service;

        public KorisnikController(IService<eStomatologModel.Korisnik,KorisnikSearchObject> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Korisnik> Get([FromQuery] KorisnikSearchObject? search = null)
        {
            return _service.Get(search);
        }


        [HttpGet("{id}")]
        public eStomatologModel.Korisnik GetById(int id)
        {
            return _service.GetById(id);
        }
    }  
}
