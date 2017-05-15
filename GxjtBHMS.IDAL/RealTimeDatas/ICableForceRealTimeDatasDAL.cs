﻿using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ICableForceRealTimeDatasDAL : IReadOnlyRepository<Basic_CableForceTable, int>
    {
        IEnumerable<Basic_CableForceTable> GetRealTimeCableForce(int pointPositionId);
    }
}
