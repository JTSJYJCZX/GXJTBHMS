using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.IDAL;
using NPOI.SS.UserModel;
using GxjtBHMS.Models;

namespace GxjtBHMS.Service.Implementations
{
    class DisplacementMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadFileSystemServiceBase<Basic_DisplacementTable>
    {
        public DisplacementMonitorDatasOriginalValueDownloadFileSystemService(IDisplacementDatasOriginalValueDAL displacementOriginalDatasDAL):base(displacementOriginalDatasDAL)
        {
            _sheetName = "位移原始数据查询结果";
        }

        protected override void PartialHeadRow(IRow headRow)
        {
            headRow.CreateCell(3).SetCellValue("位移值(mm)");
        }

        protected override void BuildPartialContent(IRow row, int index, IEnumerable<Basic_DisplacementTable> source)
        {
            row.CreateCell(3).SetCellValue(source.ToArray()[index].Displacement);
        }
    }
}
