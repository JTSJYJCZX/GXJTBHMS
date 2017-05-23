using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Infrastructure.Helpers;
using System.IO;
using System;

namespace GxjtBHMS.Service.Implementations
{
    class DisplacementMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase<Basic_DisplacementTable>
    {
        public DisplacementMonitorDatasOriginalValueDownloadFileSystemService(IDisplacementDatasOriginalValueDAL displacementOriginalDatasDAL):base(displacementOriginalDatasDAL)
        {
        }
        protected override void CreateBody(StreamWriter sw, IEnumerable<Basic_DisplacementTable> alldatas)
        {
            foreach (var item in alldatas)
            {
                sw.WriteLine(string.Concat(item.PointsNumber.Name, Separator, DateTimeHelper.FormatDateTime(item.Time), Separator, item.Displacement));
            }
        }

        protected override IEnumerable<Basic_DisplacementTable> GetDataSource(IList<Func<Basic_DisplacementTable, bool>> ps)
        {
            return _dal.FindBy(ps).ToList();
        }

        protected override string GetHeader(string defaultHead)
        {
            return string.Concat(defaultHead, Separator, "位移值(mm)");
        }
    }
}
