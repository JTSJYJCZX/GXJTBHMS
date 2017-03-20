using GxjtBHMS.IDAL;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Service.Interfaces;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations
{
    class TemperatureMonitorDatasQueryFileSystemService : IMonitorDatasQueryFileSystemService<TemperatureEigenvalueTable>
    {
        readonly ITemperatureDatasEigenvalueDAL _temperatureDatasDAL;
        public TemperatureMonitorDatasQueryFileSystemService(ITemperatureDatasEigenvalueDAL temperatureDatasDAL)
        {
            _temperatureDatasDAL = temperatureDatasDAL;
        }
        public object ConvertToDocument(IList<Func<TemperatureEigenvalueTable, bool>> ps)
        {
            IEnumerable<TemperatureEigenvalueTable> temperatureExcludePaging = new List<TemperatureEigenvalueTable>();
            temperatureExcludePaging = _temperatureDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("温度查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("测点位置");
            headRow.CreateCell(3).SetCellValue("温度值");
            headRow.CreateCell(4).SetCellValue("监测时间");
            for (int i = 0; i < temperatureExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(temperatureExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue("");
                row.CreateCell(3).SetCellValue(temperatureExcludePaging.ToArray()[i].Max);
                row.CreateCell(4).SetCellValue(temperatureExcludePaging.ToArray()[i].Min);
                row.CreateCell(5).SetCellValue(temperatureExcludePaging.ToArray()[i].Average);
                row.CreateCell(6).SetCellValue(temperatureExcludePaging.ToArray()[i].Time.FormatDateTime());
            }
            return workbook;
        }       
    }
}
