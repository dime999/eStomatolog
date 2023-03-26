using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class UslugaController : Controller
    {

        private readonly IService<eStomatologModel.Usluga, object> _service;

        public UslugaController(IService<eStomatologModel.Usluga, object> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Usluga> Get() {

          return _service.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Usluga GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
