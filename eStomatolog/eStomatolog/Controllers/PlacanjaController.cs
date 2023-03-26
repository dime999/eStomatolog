using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class PlacanjaController : Controller
    {

        private readonly IService<eStomatologModel.Placanja, object> _service;

        public PlacanjaController(IService<eStomatologModel.Placanja, object> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Placanja> Get() {

          return _service.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Placanja GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
