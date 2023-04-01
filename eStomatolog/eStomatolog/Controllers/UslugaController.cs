using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class UslugaController : Controller
    {

        private readonly IService<eStomatologModel.Usluga, BaseSearchObject> _service;

        public UslugaController(IService<eStomatologModel.Usluga, BaseSearchObject> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Usluga> Get([FromQuery] BaseSearchObject? search = null)
        {

            return _service.Get(search);
        }

        [HttpGet("{id}")]
        public eStomatologModel.Usluga GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
