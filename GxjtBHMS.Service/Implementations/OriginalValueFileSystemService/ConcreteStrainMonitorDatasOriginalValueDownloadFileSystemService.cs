using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using System.IO;
using GxjtBHMS.Infrastructure.Helpers;

namespace GxjtBHMS.Service.Implementations
{
    class ConcreteStrainMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase<Basic_ConcreteStrainTable >
    {
        public ConcreteStrainMonitorDatasOriginalValueDownloadFileSystemService(IConcreteStrainDatasOriginalValueDAL strainOriginalDatasDAL):base(strainOriginalDatasDAL)
        {
        }

        protected override void CreateBody(StreamWriter sw, IEnumerable<Basic_ConcreteStrainTable> alldatas)
        {
            foreach (var item in alldatas)
            {
                sw.WriteLine(string.Concat(item.PointsNumber.Name, Separator, DateTimeHelper.FormatDateTime(item.Time), Separator, item.Strain, Separator, item.Temperature));
            }
        }

        protected override IEnumerable<Basic_ConcreteStrainTable> GetDataSource(IList<Func<Basic_ConcreteStrainTable, bool>> ps)
        {
            return _dal.FindBy(ps).ToList();
        }

        protected override string GetHeader(string defaultHead)
        {
            return string.Concat(defaultHead, Separator, "应变值(με)", Separator, "温度(℃)");
        }
    }
}
