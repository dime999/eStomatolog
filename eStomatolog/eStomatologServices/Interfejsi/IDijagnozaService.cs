﻿using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IDijagnozaService : ICRUDService<eStomatologModel.Dijagnoza, BaseSearchObject, DijanozaInsertRequest, DijagnozaUpdateRequest>
    {
        public IEnumerable<DijagnozaInfoModel> GetByPacijentId(int id);
    }
}
