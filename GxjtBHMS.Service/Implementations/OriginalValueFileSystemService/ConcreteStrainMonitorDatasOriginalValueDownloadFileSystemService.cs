using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.IDAL;
using NPOI.SS.UserModel;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.Service.Implementations
{
    class ConcreteStrainMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadFileSystemServiceBase<Basic_ConcreteStrainTable >
    {
        public ConcreteStrainMonitorDatasOriginalValueDownloadFileSystemService(IConcreteStrainDatasOriginalValueDAL strainOriginalDatasDAL):base(strainOriginalDatasDAL)
        {
            _sheetName = "混凝土应变原始数据查询结果";
        }

        protected override void PartialHeadRow(IRow headRow)
        {
            headRow.CreateCell(3).SetCellValue("应变值(με)");
            headRow.CreateCell(4).SetCellValue("温度(℃)");
        }

        protected override void BuildPartialContent(IRow row, int index, IEnumerable<Basic_ConcreteStrainTable > source)
        {
            row.CreateCell(3).SetCellValue(source.ToArray()[index].Strain);
            row.CreateCell(4).SetCellValue(source.ToArray()[index].Temperature);
        }
    }
}
