using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public class GeneralPreloadDataSet : IPreloadDataSet
    {
        IMonitoringTestTypeService _mtts;
        public GeneralPreloadDataSet(IMonitoringTestTypeService mtts)
        {
            _mtts = mtts;
        }
        public IEnumerable<dynamic> Load(PreloadDataSetType type)
        {
            switch (type)
            {
                case PreloadDataSetType.MornitoringTestType:
                    return _mtts.GetAllTestType().Datas; 
                default:
                    break;
            }
            return null;
        }
    }
}