using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices
{
    public interface IPacijentService
    {
        IEnumerable<Pacijent> Get();
        Pacijent GetByID(int id);
    }
}
