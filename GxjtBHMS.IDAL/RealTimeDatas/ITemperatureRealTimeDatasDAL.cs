﻿using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ITemperatureRealTimeDatasDAL : IReadOnlyRepository<Basic_TemperatureTable, int>
    {
        IEnumerable<Basic_TemperatureTable> GetRealTimeTemperature(int pointPositionId);
    }
}
