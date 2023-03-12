using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class TerminController : Controller
    {

        private readonly ITerminService TerminService;

        public TerminController(ITerminService terminService)
        {
            this.TerminService = terminService;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Termin> Get() {

          return TerminService.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Termin GetById(int id)
        {
            return TerminService.GetById(id);
        }
    }
}
