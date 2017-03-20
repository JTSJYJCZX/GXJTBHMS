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
    class SteelArchStrainMonitorDatasOriginalValueDownLoadFileSystemService : IMonitorDatasQueryFileSystemService<SteelArchStrainTable>
    {
        readonly ISteelArchStrainDatasOriginalValueDAL _steelArchStrainOriginalDatasDAL;
        public SteelArchStrainMonitorDatasOriginalValueDownLoadFileSystemService(ISteelArchStrainDatasOriginalValueDAL steelArchStrainOriginalDatasDAL)
        {
            _steelArchStrainOriginalDatasDAL = steelArchStrainOriginalDatasDAL;
        }
        public object ConvertToDocument(IList<Func<SteelArchStrainTable, bool>> ps)
        {
            IEnumerable<SteelArchStrainTable> strainsExcludePaging = new List<SteelArchStrainTable>();
            strainsExcludePaging = _steelArchStrainOriginalDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("钢拱肋应变原始数据查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("监测时间");
            headRow.CreateCell(3).SetCellValue("应变值");
            headRow.CreateCell(4).SetCellValue("温度");
            for (int i = 0; i < strainsExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(strainsExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue(strainsExcludePaging.ToArray()[i].Time.FormatDateTime());
                row.CreateCell(3).SetCellValue(strainsExcludePaging.ToArray()[i].Strain);
                row.CreateCell(4).SetCellValue(strainsExcludePaging.ToArray()[i].Temperature);
            }           
            return workbook;         
        }       
    }
}
