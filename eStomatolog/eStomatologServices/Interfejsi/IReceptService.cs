using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IReceptService
    {
        IEnumerable<eStomatologModel.Recept> Get();
        eStomatologModel.Recept GetById(int id);
    }
}
