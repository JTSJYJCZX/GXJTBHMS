using System;
using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.IDAL;
using GxjtBHMS.Service.Interfaces;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.Service.Implementations
{
    class SteelLatticeStrainMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadFileSystemServiceBase<Basic_SteelLatticeStrainTable >
    {
        public SteelLatticeStrainMonitorDatasOriginalValueDownloadFileSystemService(ISteelLatticeStrainDatasOriginalValueDAL steelLatticeStrainOriginalDatasDAL):base(steelLatticeStrainOriginalDatasDAL)
        {
            _sheetName = "钢拱肋应变原始数据查询结果";
        }

        protected override void PartialHeadRow(IRow headRow)
        {
            headRow.CreateCell(3).SetCellValue("应变值(με)");
            headRow.CreateCell(4).SetCellValue("温度(℃)");
        }

        protected override void BuildPartialContent(IRow row, int index, IEnumerable<Basic_SteelLatticeStrainTable > source)
        {
            row.CreateCell(3).SetCellValue(source.ToArray()[index].Strain);
            row.CreateCell(4).SetCellValue(source.ToArray()[index].Temperature);
        }
    }
}
