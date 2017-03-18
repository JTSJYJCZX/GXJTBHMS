﻿using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.SqlServerDAL;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations
{
    class CableForceMonitorDatasQueryFileSystemService : IMonitorDatasEigenvalueQueryFileSystemService<CableForceEigenvalueTable>
    {
        readonly ICableForceDatasEigenvalueDAL  _cableForceDatasDAL;
        public CableForceMonitorDatasQueryFileSystemService(ICableForceDatasEigenvalueDAL  cableForceDatasDAL)
        {
            _cableForceDatasDAL = cableForceDatasDAL;
        }
        public object ConvertToDocument(IList<Func<CableForceEigenvalueTable, bool>> ps)
        {
            IEnumerable<CableForceEigenvalueTable> cableForcesExcludePaging = new List<CableForceEigenvalueTable>();
            cableForcesExcludePaging = _cableForceDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("索力查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("测点位置");
            headRow.CreateCell(3).SetCellValue("索力值");
            headRow.CreateCell(4).SetCellValue("监测时间");
            headRow.CreateCell(5).SetCellValue("监测时间");
            headRow.CreateCell(6).SetCellValue("振动频率");
            for (int i = 0; i < cableForcesExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(cableForcesExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue("");
                row.CreateCell(3).SetCellValue(cableForcesExcludePaging.ToArray()[i].Max);
                row.CreateCell(4).SetCellValue(cableForcesExcludePaging.ToArray()[i].Min);
                row.CreateCell(5).SetCellValue(cableForcesExcludePaging.ToArray()[i].Average);
                row.CreateCell(6).SetCellValue(cableForcesExcludePaging.ToArray()[i].Time.FormatDateTime());
            }
            return workbook;
        }      
    }
}
