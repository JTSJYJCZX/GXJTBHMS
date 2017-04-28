using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.SqlServerDAL;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations
{
   public  class MonitorDatasEigenValueQueryFileSystemService<T>:IMonitorDatasQueryFileSystemService<T> where T: MonitoringDatasEigenvalueModel
    {
        readonly IMonitoringDatasEigenvalueDAL<T> _monitoringDatasDAL;
        public MonitorDatasEigenValueQueryFileSystemService(IMonitoringDatasEigenvalueDAL<T> monitoringDatasDAL)
        {
            _monitoringDatasDAL = monitoringDatasDAL;
        }
        public object ConvertToDocument(IList<Func<T, bool>> ps)
        {
            IEnumerable<T> monitwringDatasExcludePaging = new List<T>();
            monitwringDatasExcludePaging = _monitoringDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("特征值查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("监测时间");
            headRow.CreateCell(3).SetCellValue("最大值");
            headRow.CreateCell(4).SetCellValue("最小值");
            headRow.CreateCell(5).SetCellValue("平均值");
            for (int i = 0; i < monitwringDatasExcludePaging.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].Time.FormatDateTimeToHour());
                row.CreateCell(3).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].Max);
                row.CreateCell(4).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].Min);
                row.CreateCell(5).SetCellValue(monitwringDatasExcludePaging.ToArray()[i].Average);
            }
            return workbook;
        }      
    }
}
