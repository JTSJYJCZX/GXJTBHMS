using GxjtBHMS.IDAL.OriginalValueDownLoad;
using GxjtBHMS.Models;
using System.Collections.Generic;
using System.Linq;
using System;
using System.IO;
using GxjtBHMS.Infrastructure.Helpers;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class CableForceMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase<Basic_CableForceTable>
    {
        public CableForceMonitorDatasOriginalValueDownloadFileSystemService(ICableForceDatasOriginalValueDAL cableForceDatasOriginalValueDAL) : base(cableForceDatasOriginalValueDAL)
        {
        }

        protected override void CreateBody(StreamWriter sw, IEnumerable<Basic_CableForceTable> alldatas)
        {
            foreach (var item in alldatas)
            {
                sw.WriteLine(string.Concat(item.PointsNumber.Name, Separator, DateTimeHelper.FormatDateTime(item.Time), Separator, item.CableForce, Separator, item.Temperature));
            }
        }

        protected override IEnumerable<Basic_CableForceTable> GetDataSource(IList<Func<Basic_CableForceTable, bool>> ps)
        {
            return _dal.FindBy(ps).ToList();
        }

        protected override string GetHeader(string defaultHead)
        {
            return string.Concat(defaultHead, Separator, "索力值(kN)", Separator, "温度(℃)");
        }
    }
}
