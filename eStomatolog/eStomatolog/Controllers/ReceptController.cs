using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class ReceptController : Controller
    {

        private readonly IService<eStomatologModel.Recept> _service;

        public ReceptController(IService<eStomatologModel.Recept> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Recept> Get() {

          return _service.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Recept GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
