using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using NPOI.SS.UserModel;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class HumidityDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadFileSystemServiceBase<HumidityTable>
    {
        public HumidityDatasOriginalValueDownloadFileSystemService(IHumidityDatasOriginalValueDAL humidityDatasOriginalValueDAL):base(humidityDatasOriginalValueDAL)
        {
            _sheetName = "湿度原始数据查询结果";
        }

        protected override void PartialHeadRow(IRow headRow)
        {
            headRow.CreateCell(3).SetCellValue("湿度(%)");
        }

        protected override void BuildPartialContent(IRow row, int index, IEnumerable<HumidityTable> source)
        {
            row.CreateCell(3).SetCellValue(source.ToArray()[index].Humidity);
        }

    }
}
