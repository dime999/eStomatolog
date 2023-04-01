using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class PlacanjaController : Controller
    {

        private readonly IService<eStomatologModel.Placanja, BaseSearchObject> _service;

        public PlacanjaController(IService<eStomatologModel.Placanja, BaseSearchObject> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Placanja> Get([FromQuery] BaseSearchObject? search = null) { 

          return _service.Get(search);
        }

        [HttpGet("{id}")]
        public eStomatologModel.Placanja GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
