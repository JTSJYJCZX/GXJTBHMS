﻿using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;
namespace GxjtBHMS.Service.Interfaces
{
    public interface IStrainDataRealTimeDisplayService
    {
        IEnumerable<IncludeSectionWarningColorDataModel> GetWarningStrainDatasBy(int testTypeId);


    }
}
