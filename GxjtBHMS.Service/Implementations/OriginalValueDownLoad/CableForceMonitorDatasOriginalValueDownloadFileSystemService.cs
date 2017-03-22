using GxjtBHMS.IDAL.OriginalValueDownLoad;
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
    class CableForceMonitorDatasOriginalValueDownloadFileSystemService : IMonitorDatasQueryFileSystemService<CableForceTable>
    {
        readonly ICableForceDatasOriginalValueDAL _cableForceDatasOriginalValueDAL;
        public CableForceMonitorDatasOriginalValueDownloadFileSystemService(ICableForceDatasOriginalValueDAL cableForceDatasOriginalValueDAL)
        {
            _cableForceDatasOriginalValueDAL = cableForceDatasOriginalValueDAL;
        }
        public object ConvertToDocument(IList<Func<CableForceTable, bool>> ps)
        {
            IEnumerable<CableForceTable> cableForcesExcludePaging = new List<CableForceTable>();
            cableForcesExcludePaging = _cableForceDatasOriginalValueDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("索力原始数据查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("监测时间");
            headRow.CreateCell(3).SetCellValue("索力值");
            headRow.CreateCell(4).SetCellValue("温度");
            for (int i = 0; i < cableForcesExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(cableForcesExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue(cableForcesExcludePaging.ToArray()[i].Time.FormatDateTime());
                row.CreateCell(3).SetCellValue(cableForcesExcludePaging.ToArray()[i].CableForce);
                row.CreateCell(4).SetCellValue(cableForcesExcludePaging.ToArray()[i].Temperature);
            }
            return workbook;
        }
    }
}
