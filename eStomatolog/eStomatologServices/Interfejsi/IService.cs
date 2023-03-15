using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IService<T> where T : class
    {
        IEnumerable<T> Get();
        T GetById(int id);

    }
}
