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
    class HumidityDatasOriginalValueDownLoadFileSystemService : IMonitorDatasQueryFileSystemService<HumidityTable>
    {
        readonly IHumidityDatasOriginalValueDAL _humidityDatasOriginalValueDAL;
        public HumidityDatasOriginalValueDownLoadFileSystemService(IHumidityDatasOriginalValueDAL humidityDatasOriginalValueDAL)
        {
            _humidityDatasOriginalValueDAL = humidityDatasOriginalValueDAL;
        }
        public object ConvertToDocument(IList<Func<HumidityTable, bool>> ps)
        {
            IEnumerable<HumidityTable> HumiditiesExcludePaging = new List<HumidityTable>();
            HumiditiesExcludePaging = _humidityDatasOriginalValueDAL.FindBy(ps,ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("湿度原始数据查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("监测时间");
            headRow.CreateCell(3).SetCellValue("湿度");
            for(int i = 0; i < HumiditiesExcludePaging.ToArray().Length; i++)
            {
                IRow Row = sheet.CreateRow(i+1);
                Row.CreateCell(0).SetCellValue(i+1);
                Row.CreateCell(1).SetCellValue(HumiditiesExcludePaging.ToArray()[i].PointsNumber.Name);
                Row.CreateCell(2).SetCellValue(HumiditiesExcludePaging.ToArray()[i].Time.FormatDateTime());
                Row.CreateCell(3).SetCellValue(HumiditiesExcludePaging.ToArray()[i].Humidity);
            }
            return workbook;
        }
    }
}
