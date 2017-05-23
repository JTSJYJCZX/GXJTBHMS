using System.Collections.Generic;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.IDAL;
using System.Linq;
using System.IO;
using GxjtBHMS.Infrastructure.Helpers;
using System;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class WindLoadDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase<Basic_WindLoadTable >
    {
        public WindLoadDatasOriginalValueDownloadFileSystemService(IWindLoadDatasOriginalValueDAL windLoadDatasOriginalValueDAL):base(windLoadDatasOriginalValueDAL)
        {
        }

        protected override void CreateBody(StreamWriter sw, IEnumerable<Basic_WindLoadTable> alldatas)
        {
            foreach (var item in alldatas)
            {
                sw.WriteLine(string.Concat(item.PointsNumber.Name, Separator, DateTimeHelper.FormatDateTime(item.Time), Separator, item.WindSpeed));
            }
        }

        protected override IEnumerable<Basic_WindLoadTable> GetDataSource(IList<Func<Basic_WindLoadTable, bool>> ps)
        {
            return _dal.FindBy(ps).ToList();
        }

        protected override string GetHeader(string defaultHead)
        {
            return string.Concat(defaultHead, Separator, "风速(m/s)");
        }
    }
}
