using GxjtBHMS.IDAL;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class TemperatureDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase<Basic_TemperatureTable>
    {
        public TemperatureDatasOriginalValueDownloadFileSystemService(ITemperatureDatasOriginalValueDAL temperatureDatasOriginalValueDAL):base(temperatureDatasOriginalValueDAL)
        {
        }
        protected override void CreateBody(StreamWriter sw, IEnumerable<Basic_TemperatureTable> alldatas)
        {
            foreach (var item in alldatas)
            {
                sw.WriteLine(string.Concat(item.PointsNumber.Name, Separator, DateTimeHelper.FormatDateTime(item.Time), Separator, item.Temperature));
            }
        }

        protected override IEnumerable<Basic_TemperatureTable> GetDataSource(IList<Func<Basic_TemperatureTable, bool>> ps)
        {
            return _dal.FindBy(ps).ToList();
        }

        protected override string GetHeader(string defaultHead)
        {
            return string.Concat(defaultHead, Separator, "温度(℃)");
        }
    }
}
