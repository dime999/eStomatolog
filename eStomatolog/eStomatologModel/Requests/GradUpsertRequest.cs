using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class GradUpsertRequest
    {
        public string Naziv { get; set; }

        public List<int> DoktoriIdList { get; set; }
    }
}
