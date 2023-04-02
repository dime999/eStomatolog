using eStomatologModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public partial class VrstaUsluge
    {
        public VrstaUsluge()
        {
            Usluge = new HashSet<Usluga>();
        }

        public int VrstaUslugeId { get; set; }
        public string Naziv { get; set; } = null!;

        public virtual ICollection<Usluga> Usluge { get; set; }
    }
}
