using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.IDAL;
using NPOI.SS.UserModel;
using GxjtBHMS.Models;

namespace GxjtBHMS.Service.Implementations
{
    class DisplacementMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadFileSystemServiceBase<DisplacementTable>
    {
        public DisplacementMonitorDatasOriginalValueDownloadFileSystemService(IDisplacementDatasOriginalValueDAL displacementOriginalDatasDAL):base(displacementOriginalDatasDAL)
        {
            _sheetName = "位移原始数据查询结果";
        }

        protected override void PartialHeadRow(IRow headRow)
        {
            headRow.CreateCell(3).SetCellValue("位移值(mm)");
        }

        protected override void BuildPartialContent(IRow row, int index, IEnumerable<DisplacementTable> source)
        {
            row.CreateCell(3).SetCellValue(source.ToArray()[index].Displacement);
        }

        //public object ConvertToDocument(IList<Func<DisplacementTable, bool>> ps)
        //{
        //    IEnumerable<DisplacementTable> displacementsExcludePaging = new List<DisplacementTable>();
        //    displacementsExcludePaging = _displacementOriginalDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
        //    HSSFWorkbook workbook = new HSSFWorkbook();
        //    ISheet sheet = workbook.CreateSheet("位移原始数据查询结果");
        //    IRow headRow = sheet.CreateRow(0);
        //    headRow.CreateCell(0).SetCellValue("序号");
        //    headRow.CreateCell(1).SetCellValue("测点编号");
        //    headRow.CreateCell(2).SetCellValue("监测时间");
        //    headRow.CreateCell(3).SetCellValue("位移值(mm)");
        //    for (int i = 0; i < displacementsExcludePaging.ToArray().Length; i++)
        //    {
        //        IRow row = sheet.CreateRow(i + 1);
        //        row.CreateCell(0).SetCellValue(i + 1);
        //        row.CreateCell(1).SetCellValue(displacementsExcludePaging.ToArray()[i].PointsNumber.Name);
        //        row.CreateCell(2).SetCellValue(displacementsExcludePaging.ToArray()[i].Time.FormatDateTime());
        //        row.CreateCell(3).SetCellValue(displacementsExcludePaging.ToArray()[i].Displacement);
        //    }           
        //    return workbook;         
        //}       
    }
}
