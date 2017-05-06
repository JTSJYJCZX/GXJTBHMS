using GxjtBHMS.Models.AnomalousEventTable;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IAnomalousEventManagementsFileSystemService
    {
        object ConvertToDocument(IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps);
    }
}