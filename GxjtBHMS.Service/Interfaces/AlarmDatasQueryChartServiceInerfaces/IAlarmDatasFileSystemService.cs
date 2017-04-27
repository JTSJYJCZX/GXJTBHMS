using GxjtBHMS.Models;
using GxjtBHMS.Models.SafetyPreWarningTable;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IAlarmDatasFileSystemService<T> 
    {
        object ConvertToDocument(IList<Func<T, bool>> ps);
    }
}