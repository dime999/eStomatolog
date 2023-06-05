using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class Galerija
    {
        public class Row
        {
            public int slikaId;
        }
        public List<Row> Rows { get; set; }
        public int[] slikeIds { get; set; }
    }
}
