using GxjtBHMS.IDAL.OriginalValueDownLoad;
using GxjtBHMS.Models;
using NPOI.SS.UserModel;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    class CableForceMonitorDatasOriginalValueDownloadFileSystemService : MonitorDatasOriginalValueDownloadFileSystemServiceBase<Basic_CableForceTable>
    {       
        public CableForceMonitorDatasOriginalValueDownloadFileSystemService(ICableForceDatasOriginalValueDAL cableForceDatasOriginalValueDAL):base(cableForceDatasOriginalValueDAL)
        {
           _sheetName= "索力原始数据查询结果";
        }

        protected override void BuildPartialContent(IRow row,int index,IEnumerable<Basic_CableForceTable> source)
        {
            row.CreateCell(3).SetCellValue(source.ToArray()[index].CableForce);
            row.CreateCell(4).SetCellValue(source.ToArray()[index].Temperature);
        }

        //protected override HSSFWorkbook CreateWorkBook()
        //{
        //    _sheetName = "索力原始数据查询结果";
        //    var workbook = base.CreateWorkBook() as HSSFWorkbook;
        //    var sheet = workbook.GetSheet(_sheetName);
        //    var headRow = sheet.GetRow(0);
        //    //PartialHeadRow(headRow);
        //    return workbook;
        //}

        protected override void PartialHeadRow(IRow headRow)
        {
            _sheetName = "索力原始数据查询结果";
            headRow.CreateCell(3).SetCellValue("索力值(kN)");
            headRow.CreateCell(4).SetCellValue("温度(℃)");
        }
    }
}
