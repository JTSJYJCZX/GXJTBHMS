using System;
using System.Collections.Generic;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.IDAL;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System.Linq;
using GxjtBHMS.Infrastructure.Helpers;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class WindLoadDatasOriginalValueDownloadFileSystemService : IMonitorDatasQueryFileSystemService<WindLoadTable>
    {
        readonly IWindLoadDatasOriginalValueDAL _windLoadDatasOriginalValue;
        public WindLoadDatasOriginalValueDownloadFileSystemService(IWindLoadDatasOriginalValueDAL windLoadDatasOriginalValueDAL)
        {
            _windLoadDatasOriginalValue = windLoadDatasOriginalValueDAL;
        }
        public object ConvertToDocument(IList<Func<WindLoadTable, bool>> ps)
        {
            IEnumerable<WindLoadTable> windLoadExcludePaging = new List<WindLoadTable>();
            windLoadExcludePaging = _windLoadDatasOriginalValue.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("风荷载原始数据查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("监测时间");
            headRow.CreateCell(3).SetCellValue("风速(m/s)");
            for (int i = 0; i < windLoadExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(windLoadExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue(windLoadExcludePaging.ToArray()[i].Time.FormatDateTime());
                row.CreateCell(3).SetCellValue(windLoadExcludePaging.ToArray()[i].WindSpeed);
            }
            return workbook;
        }
    }
}
