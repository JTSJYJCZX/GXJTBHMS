using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Infrastructure.Helpers;
using System;
using System.IO;

namespace GxjtBHMS.Service.Implementations
{
    class SteelLatticeStrainMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase<Basic_SteelLatticeStrainTable >
    {
        public SteelLatticeStrainMonitorDatasOriginalValueDownloadFileSystemService(ISteelLatticeStrainDatasOriginalValueDAL steelLatticeStrainOriginalDatasDAL):base(steelLatticeStrainOriginalDatasDAL)
        {
        }

        protected override void CreateBody(StreamWriter sw, IEnumerable<Basic_SteelLatticeStrainTable> alldatas)
        {
            foreach (var item in alldatas)
            {
                sw.WriteLine(string.Concat(item.PointsNumber.Name, Separator, DateTimeHelper.FormatDateTime(item.Time), Separator, item.Strain, Separator, item.Temperature));
            }
        }

        protected override IEnumerable<Basic_SteelLatticeStrainTable> GetDataSource(IList<Func<Basic_SteelLatticeStrainTable, bool>> ps)
        {
            return _dal.FindBy(ps).ToList();
        }

        protected override string GetHeader(string defaultHead)
        {
            return string.Concat(defaultHead, Separator, "应变值(με)", Separator, "温度(℃)");
        }
    }
}
