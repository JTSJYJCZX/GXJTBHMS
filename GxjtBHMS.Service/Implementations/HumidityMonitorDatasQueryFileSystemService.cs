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
    class HumidityMonitorDatasQueryFileSystemService : IMonitorDatasQueryFileSystemService<HumidityEigenvalueTable>
    {
        readonly IHumidityDatasEigenvalueDAL _humidityDatasDAL;
        public HumidityMonitorDatasQueryFileSystemService(IHumidityDatasEigenvalueDAL humidityDatasDAL)
        {
            _humidityDatasDAL = humidityDatasDAL;
        }
        public object ConvertToDocument(IList<Func<HumidityEigenvalueTable, bool>> ps)
        {
            IEnumerable<HumidityEigenvalueTable> humidityExcludePaging = new List<HumidityEigenvalueTable>();
            humidityExcludePaging = _humidityDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("湿度查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("测点位置");
            headRow.CreateCell(3).SetCellValue("湿度值");
            headRow.CreateCell(4).SetCellValue("监测时间");
            for (int i = 0; i < humidityExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(humidityExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue("");
                row.CreateCell(3).SetCellValue(humidityExcludePaging.ToArray()[i].Max);
                row.CreateCell(4).SetCellValue(humidityExcludePaging.ToArray()[i].Min);
                row.CreateCell(5).SetCellValue(humidityExcludePaging.ToArray()[i].Average);
                row.CreateCell(6).SetCellValue(humidityExcludePaging.ToArray()[i].Time.FormatDateTime());
            }
            return workbook;
        }       
    }
}
