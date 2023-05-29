using AutoMapper;
using eStomatologModel;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Text.Json;
using Newtonsoft.Json;
using System.Threading.Tasks;
using Doktor = eStomatologServices.Models.Doktor;

namespace eStomatologServices.Servisi
{
    public class DoktorService : BaseService<eStomatologModel.Doktor, Models.Doktor, BaseSearchObject>, IDoktorService
    {     

        public DoktorService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

      

        public  eStomatologModel.Doktor GetByKorisnikId(int id)
        {
            var Doktor = Context.Set<eStomatologServices.Models.Doktor>().FirstOrDefault(d => d.KorisnikId == id);

            return Mapper.Map<eStomatologModel.Doktor>(Doktor);
        }
    }
}
