using GxjtBHMS.IDAL;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class HumidityDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase<Basic_HumidityTable>
    {
        public HumidityDatasOriginalValueDownloadFileSystemService(IHumidityDatasOriginalValueDAL humidityDatasOriginalValueDAL):base(humidityDatasOriginalValueDAL)
        {
        }

        protected override void CreateBody(StreamWriter sw, IEnumerable<Basic_HumidityTable> alldatas)
        {
            foreach (var item in alldatas)
            {
                sw.WriteLine(string.Concat(item.PointsNumber.Name, Separator, DateTimeHelper.FormatDateTime(item.Time), Separator, item.Humidity));
            }
        }

        protected override IEnumerable<Basic_HumidityTable> GetDataSource(IList<Func<Basic_HumidityTable, bool>> ps)
        {
            return _dal.FindBy(ps).ToList();
        }

        protected override string GetHeader(string defaultHead)
        {
            return string.Concat(defaultHead, Separator, "湿度(%)");
        }
    }
}
