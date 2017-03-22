using GxjtBHMS.IDAL;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class TemperatureDatasOriginalValueDownloadFileSystemService : IMonitorDatasQueryFileSystemService<TemperatureTable>
    {
        readonly ITemperatureDatasOriginalValueDAL _temperatureDatasOriginalValueDAL;
        public TemperatureDatasOriginalValueDownloadFileSystemService(ITemperatureDatasOriginalValueDAL temperatureDatasOriginalValueDAL)
        {
            _temperatureDatasOriginalValueDAL = temperatureDatasOriginalValueDAL;
        }
        public object ConvertToDocument(IList<Func<TemperatureTable, bool>> ps)
        {
            IEnumerable<TemperatureTable> temperaturesExcludePaging = new List<TemperatureTable>();
            temperaturesExcludePaging = _temperatureDatasOriginalValueDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("温度初始值数据查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("监测时间");
            headRow.CreateCell(3).SetCellValue("温度");
            for (int i = 0;i< temperaturesExcludePaging.ToArray().Length;i++)
            {
                IRow row = sheet.CreateRow(i+1);
                row.CreateCell(0).SetCellValue(i+1);
                row.CreateCell(1).SetCellValue(temperaturesExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue(temperaturesExcludePaging.ToArray()[i].Time.FormatDateTime());
                row.CreateCell(3).SetCellValue(temperaturesExcludePaging.ToArray()[i].Temperature);
            }
            return workbook;
        }
    }
}
