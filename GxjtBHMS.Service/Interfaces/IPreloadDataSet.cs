using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IPreloadDataSet
    {
       IEnumerable<dynamic> Load(PreloadDataSetType type);
    }
}