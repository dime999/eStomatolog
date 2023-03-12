using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IDijagnozaService
    {
        IEnumerable<eStomatologModel.Dijagnoza> Get();
        eStomatologModel.Dijagnoza GetById(int id);
    }
}
