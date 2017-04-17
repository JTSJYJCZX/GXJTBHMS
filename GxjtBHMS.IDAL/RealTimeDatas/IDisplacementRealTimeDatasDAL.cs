﻿using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IDisplacementRealTimeDatasDAL : IReadOnlyRepository<Basic_DisplacementTable, int>
    {
        IEnumerable<Basic_DisplacementTable> GetRealTimeDisplacement(int pointPositionId);
    }
}
