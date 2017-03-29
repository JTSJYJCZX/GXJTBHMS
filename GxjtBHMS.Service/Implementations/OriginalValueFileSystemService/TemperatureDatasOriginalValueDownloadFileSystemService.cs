using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using NPOI.SS.UserModel;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class TemperatureDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadFileSystemServiceBase<TemperatureTable>
    {
        public TemperatureDatasOriginalValueDownloadFileSystemService(ITemperatureDatasOriginalValueDAL temperatureDatasOriginalValueDAL):base(temperatureDatasOriginalValueDAL)
        {
            _sheetName = "温度原始数据查询结果";
        }

        protected override void PartialHeadRow(IRow headRow)
        {
            headRow.CreateCell(3).SetCellValue("温度(℃)");
        }

        protected override void BuildPartialContent(IRow row, int index, IEnumerable<TemperatureTable> source)
        {
            row.CreateCell(3).SetCellValue(source.ToArray()[index].Temperature);
        }
    }
}
