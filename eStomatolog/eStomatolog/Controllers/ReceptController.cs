using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class ReceptController : Controller
    {

        private readonly IService<eStomatologModel.Recept, BaseSearchObject> _service;

        public ReceptController(IService<eStomatologModel.Recept, BaseSearchObject> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Recept> Get([FromQuery] BaseSearchObject? search = null) { 

          return _service.Get(search);
        }

        [HttpGet("{id}")]
        public eStomatologModel.Recept GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
