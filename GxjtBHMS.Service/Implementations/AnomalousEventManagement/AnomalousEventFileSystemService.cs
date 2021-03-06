﻿using GxjtBHMS.IDAL.AnomalousEventIDAL;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Service.Interfaces;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.Models.AnomalousEventTable;

namespace GxjtBHMS.Service.Implementations
{
    public class AnomalousEventFileSystemService : IAnomalousEventManagementsFileSystemService
    {
        readonly IAnomalousEventQueryDAL _anomalousEventDAL;
        public AnomalousEventFileSystemService(IAnomalousEventQueryDAL anomalousEventDAL)
        {
            _anomalousEventDAL = anomalousEventDAL;
        }
        public object ConvertToDocument(IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps)
        {
            string[] navigationProperties = { ServiceConstant.PointsNumberPointsPositionNavigationProperty, ServiceConstant.AnomalousEventReasonNavigationProperty };
            IEnumerable<AnomalousEvent_AnomalousEventTable> monitwringDatasExcludePaging = new List<AnomalousEvent_AnomalousEventTable>();
            monitwringDatasExcludePaging = _anomalousEventDAL.FindBy(ps, navigationProperties);//获取不分页的查询结果
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("异常事件查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("监测时间");
            headRow.CreateCell(2).SetCellValue("测试类型");
            headRow.CreateCell(3).SetCellValue("测点位置");
            headRow.CreateCell(4).SetCellValue("测点编号");
            headRow.CreateCell(5).SetCellValue("测试值");
            headRow.CreateCell(6).SetCellValue("异常原因");
            for (int i = 0; i < monitwringDatasExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].Time.FormatDateTime());
                row.CreateCell(2).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].PointsNumber.PointsPosition.TestType.Name);

                row.CreateCell(3).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].PointsNumber.PointsPosition.Name);
                row.CreateCell(4).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(5).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].AnomalousData);
                row.CreateCell(6).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].AnomalousEventReason.AnomalousEventReason);
            }
            return workbook;
        }
    }
}
