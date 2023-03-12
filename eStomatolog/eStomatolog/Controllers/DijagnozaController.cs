using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DijagnozaController : Controller
    {
        private readonly IDijagnozaService DijagnozaService;

        public DijagnozaController(IDijagnozaService dijagnozaService)
        {
            this.DijagnozaService = dijagnozaService;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Dijagnoza> Get()
        {
            return DijagnozaService.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Dijagnoza GetById(int id)
        {
            return DijagnozaService.GetById(id);
        }
    }
}
