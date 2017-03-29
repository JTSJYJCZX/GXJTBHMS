using System.Collections.Generic;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.IDAL;
using NPOI.SS.UserModel;
using System.Linq;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class WindLoadDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadFileSystemServiceBase<WindLoadTable>
    {
        public WindLoadDatasOriginalValueDownloadFileSystemService(IWindLoadDatasOriginalValueDAL windLoadDatasOriginalValueDAL):base(windLoadDatasOriginalValueDAL)
        {
            _sheetName = "风荷载原始数据查询结果";
        }

        protected override void PartialHeadRow(IRow headRow)
        {
            headRow.CreateCell(3).SetCellValue("风速(m/s)");
        }

        protected override void BuildPartialContent(IRow row, int index, IEnumerable<WindLoadTable> source)
        {
            row.CreateCell(3).SetCellValue(source.ToArray()[index].WindSpeed);
        }
    }
}
