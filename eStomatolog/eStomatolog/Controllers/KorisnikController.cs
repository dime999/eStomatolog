using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class KorisnikController : Controller
    {
        private readonly IService<eStomatologModel.Korisnik> _service;

        public KorisnikController(IService<eStomatologModel.Korisnik> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Korisnik> Get()
        {
            return _service.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Korisnik GetById(int id)
        {
            return _service.GetById(id);
        }
    }  
}
