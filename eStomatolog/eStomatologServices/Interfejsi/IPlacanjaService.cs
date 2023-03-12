using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IPlacanjaService
    {
        IEnumerable<eStomatologModel.Placanja> Get();
        eStomatologModel.Placanja GetById(int id);
    }
}
