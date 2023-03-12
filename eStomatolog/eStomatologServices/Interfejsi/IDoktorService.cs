using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IDoktorService
    {
        IEnumerable<eStomatologModel.Doktor> Get();
        eStomatologModel.Doktor GetById(int id);
    }
}
