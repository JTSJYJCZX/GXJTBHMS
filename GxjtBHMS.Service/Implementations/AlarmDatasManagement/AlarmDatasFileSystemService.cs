using GxjtBHMS.IDAL.AlarmDatasManagement;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.Interfaces;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations
{
    public  class AlarmDatasFileSystemService<T>: IAlarmDatasFileSystemService<T> where T: SafetyPreWarningBaseModel
    {
        readonly IAlarmDatasQueryDAL<T> _alarmDatasDAL;
        public AlarmDatasFileSystemService(IAlarmDatasQueryDAL<T> alarmDatasDAL)
        {
            _alarmDatasDAL = alarmDatasDAL; 
        }
        public object ConvertToDocument(IList<Func<T, bool>> ps)
        {
            string[] navigationProperties = { ServiceConstant.PointsNumberPointsPositionNavigationProperty, ServiceConstant.ThresholdGradeNavigationProperty };
            IEnumerable<T> monitwringDatasExcludePaging = new List<T>();
            monitwringDatasExcludePaging = _alarmDatasDAL.FindBy(ps, navigationProperties);//获取不分页的查询结果
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("报警数据查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("监测时间");
            headRow.CreateCell(2).SetCellValue("测点位置");
            headRow.CreateCell(3).SetCellValue("测点编号");
            headRow.CreateCell(4).SetCellValue("测试值");
            headRow.CreateCell(5).SetCellValue("预警值");
            headRow.CreateCell(6).SetCellValue("预警等级");
            for (int i = 0; i < monitwringDatasExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].Time.FormatDateTime());
                row.CreateCell(2).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].PointsNumber.PointsPosition.Name);
                row.CreateCell(3).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(4).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].MonitoringData);
                row.CreateCell(5).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].ThresholdValue);
                row.CreateCell(6).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].ThresholdGrade.ThresholdGrade);
            }
            return workbook;
        }      
    }
}
