using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Office.Interop.Excel;
using GxjtBHMS.IDAL;
using GxjtBHMS.Service.Interfaces;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.Service.Implementations
{
    class StrainMonitorDatasOriginalValueDownLoadFileSystemService : IMonitorDatasQueryFileSystemService<ConcreteStrainTable>
    {
        readonly IConcreteStrainDatasOriginalValueDAL _strainOriginalDatasDAL;
        public StrainMonitorDatasOriginalValueDownLoadFileSystemService(IConcreteStrainDatasOriginalValueDAL strainOriginalDatasDAL)
        {
            _strainOriginalDatasDAL = strainOriginalDatasDAL;
        }
        public object ConvertToDocument(IList<Func<ConcreteStrainTable, bool>> ps)
        {
            IEnumerable<ConcreteStrainTable> strainsExcludePaging = new List<ConcreteStrainTable>();
            strainsExcludePaging = _strainOriginalDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("应变查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("测点位置");
            headRow.CreateCell(3).SetCellValue("监测时间");
            headRow.CreateCell(4).SetCellValue("应变值");
            for (int i = 0; i < strainsExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(strainsExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue("");
                row.CreateCell(3).SetCellValue(strainsExcludePaging.ToArray()[i].Time.FormatDateTime());
                row.CreateCell(4).SetCellValue(strainsExcludePaging.ToArray()[i].Strain);
            }           
            return workbook;         
        }       
    }
}
