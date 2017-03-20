using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.SqlServerDAL;
using Microsoft.Office.Interop.Excel;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace GxjtBHMS.Service.Implementations
{
    class DisplaymentMonitorDatasQueryFileSystemService : IMonitorDatasQueryFileSystemService<DisplacementEigenvalueTable>
    {
        readonly IDisplaymentDatasEigenValueDAL  _displaymentDatasDAL;
        public DisplaymentMonitorDatasQueryFileSystemService(IDisplaymentDatasEigenValueDAL  displaymentDatasDAL)
        {
            _displaymentDatasDAL = displaymentDatasDAL;
        }
        public object ConvertToDocument(IList<Func<DisplacementEigenvalueTable, bool>> ps)
        {
            IEnumerable<DisplacementEigenvalueTable> displaymentsExcludePaging = new List<DisplacementEigenvalueTable>();
            displaymentsExcludePaging = _displaymentDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("位移查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("测点位置");
            headRow.CreateCell(3).SetCellValue("位移值");
            headRow.CreateCell(4).SetCellValue("监测时间");
            for (int i = 0; i < displaymentsExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(displaymentsExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue("");
                row.CreateCell(3).SetCellValue(displaymentsExcludePaging.ToArray()[i].Max);
                row.CreateCell(4).SetCellValue(displaymentsExcludePaging.ToArray()[i].Min);
                row.CreateCell(5).SetCellValue(displaymentsExcludePaging.ToArray()[i].Average);
                row.CreateCell(6).SetCellValue(displaymentsExcludePaging.ToArray()[i].Time.FormatDateTime());
            }
            return workbook;
        }      
    }
}
