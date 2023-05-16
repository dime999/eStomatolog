﻿using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    
    
        public class OrdinacijaController : BaseCRUDController<eStomatologModel.Ordinacija, BaseSearchObject, OrdinacijaUpsertRequest, OrdinacijaUpsertRequest>
        {
            public OrdinacijaController(IOrdinacijaService service)
                : base(service)
            {
            }
        }
    
}