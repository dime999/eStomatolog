﻿using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    public class TerminController : BaseController<eStomatologModel.Termin, BaseSearchObject>
    {
        public TerminController(ITerminService service)
            : base(service)
        {
        }

        public override IEnumerable<eStomatologModel.Termin> Get([FromQuery] BaseSearchObject search = null)
        {
            return base.Get(search);
        }
    }
}
