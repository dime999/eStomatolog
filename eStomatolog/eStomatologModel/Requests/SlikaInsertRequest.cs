using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Http;

namespace eStomatologModel.Requests
{
    public class SlikaInsertRequest
    {
        public int? OrdinacijaId { get; set; }
      
        public IFormFile SlikaFile { get; set; }
    }
}
