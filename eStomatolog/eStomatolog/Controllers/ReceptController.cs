using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class ReceptController : Controller
    {

        private readonly IReceptService ReceptService;

        public ReceptController(IReceptService receptService)
        {
            this.ReceptService = receptService;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Recept> Get() {

          return ReceptService.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Recept GetById(int id)
        {
            return ReceptService.GetById(id);
        }
    }
}
