using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class PacijentController : Controller
    {

        private readonly IPacijentService PacijentService;

        public PacijentController(IPacijentService _pacijentService)
        {
            this.PacijentService = _pacijentService;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Pacijent> Get() {

          return PacijentService.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Pacijent GetById(int id)
        {
            return PacijentService.GetById(id);
        }
    }
}
