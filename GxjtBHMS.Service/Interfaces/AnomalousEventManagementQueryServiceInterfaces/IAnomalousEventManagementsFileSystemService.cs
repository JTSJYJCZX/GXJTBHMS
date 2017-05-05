using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IAnomalousEventManagementsFileSystemService<T> 
    {
        object ConvertToDocument(IList<Func<T, bool>> ps);
    }
}