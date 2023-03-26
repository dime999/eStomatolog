using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using eStomatologServices.Servisi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class PacijentController : Controller
    {
        private readonly IService<eStomatologModel.Pacijent, PacijentSearchObject> _service;

        public PacijentController(IService<eStomatologModel.Pacijent, PacijentSearchObject> service)
        {
            this._service = service;
        }



        [HttpGet]
        public IEnumerable<eStomatologModel.Pacijent> Get([FromQuery] PacijentSearchObject? search = null)
        {
            return _service.Get(search);
        }

        [HttpGet("{id}")]
        public eStomatologModel.Pacijent GetById(int id)
        {
            return _service.GetById(id);
        }

       
    }
}
