﻿using GxjtBHMS.Models;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IMonitorDatasQueryFileSystemService<T> where T : MonitorDatasQueryConditionsModel
    {
        object ConvertToDocument(IList<Func<T, bool>> ps);
    }
}