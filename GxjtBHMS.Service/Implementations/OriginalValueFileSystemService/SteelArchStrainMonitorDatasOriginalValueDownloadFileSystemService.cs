using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using GxjtBHMS.Infrastructure.Helpers;
using System.IO;

namespace GxjtBHMS.Service.Implementations
{
    class SteelArchStrainMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase<Basic_SteelArchStrainTable >
    {
        public SteelArchStrainMonitorDatasOriginalValueDownloadFileSystemService(ISteelArchStrainDatasOriginalValueDAL steelArchStrainOriginalDatasDAL):base(steelArchStrainOriginalDatasDAL)
        {
        }
        protected override void CreateBody(StreamWriter sw, IEnumerable<Basic_SteelArchStrainTable> alldatas)
        {
            foreach (var item in alldatas)
            {
                sw.WriteLine(string.Concat(item.PointsNumber.Name, Separator, DateTimeHelper.FormatDateTime(item.Time), Separator, item.Strain, Separator, item.Temperature));
            }
        }

        protected override IEnumerable<Basic_SteelArchStrainTable> GetDataSource(IList<Func<Basic_SteelArchStrainTable, bool>> ps)
        {
            return _dal.FindBy(ps).ToList();
        }

        protected override string GetHeader(string defaultHead)
        {
            return string.Concat(defaultHead, Separator, "应变值(με)", Separator, "温度(℃)");
        }
    }
}
