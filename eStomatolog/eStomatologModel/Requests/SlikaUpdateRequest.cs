using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class SlikaUpdateRequest
    {
        public IFormFile SlikeFile { get; set; }
    }
}
