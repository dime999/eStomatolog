using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DijagnozaController : Controller
    {
        private readonly IService<eStomatologModel.Dijagnoza, object> _service;

        public DijagnozaController(IService<eStomatologModel.Dijagnoza, object> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Dijagnoza> Get()
        {
            return _service.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Dijagnoza GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
