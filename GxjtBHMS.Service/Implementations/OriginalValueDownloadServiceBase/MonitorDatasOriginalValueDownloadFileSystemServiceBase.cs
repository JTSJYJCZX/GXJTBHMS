using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations
{
    abstract class MonitorDatasOriginalValueDownloadFileSystemServiceBase<T> : IMonitorDatasQueryFileSystemService<T> where T : MonitorDatasQueryConditionsModel
    {
        protected IReadOnlyRepository<T, int> _dal;
        public MonitorDatasOriginalValueDownloadFileSystemServiceBase(IReadOnlyRepository<T, int> dal)
        {
            _dal = dal;
        }

        /// <summary>
        /// 动态设置的表格名称
        /// </summary>
        protected string _sheetName;

        /// <summary>
        /// 实现接口的公共方法
        /// </summary>
        /// <param name="ps"></param>
        /// <returns></returns>
        public dynamic ConvertToDocument(IList<Func<T, bool>> ps)
        {
            var model = CreateWorkBook();
            return BuildContent(ps, model);
        }

        /// <summary>
        /// 创建WorkBook和表格对象，并对表格进行表头基本设置
        /// </summary>
        /// <returns></returns>
        protected virtual HSSFWorkbook CreateWorkBook()
        {
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet(_sheetName);
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("测点编号");
            headRow.CreateCell(2).SetCellValue("监测时间");
            PartialHeadRow(headRow);
            return workbook;
        }

        protected abstract void PartialHeadRow(IRow headRow);

        /// <summary>
        /// 构建表格主体内容
        /// </summary>
        /// <param name="ps"></param>
        /// <param name="workbook"></param>
        /// <returns></returns>
        protected HSSFWorkbook BuildContent(IList<Func<T, bool>> ps, HSSFWorkbook workbook)
        {
           var source = _dal.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            var sheet = workbook.GetSheet(_sheetName);
            for (int i = 0; i < source.Count(); i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(source.ToArray()[i].PointsNumber.Name);
                row.CreateCell(2).SetCellValue(source.ToArray()[i].Time.FormatDateTime());
                BuildPartialContent(row, i, source);
            }
            return workbook;
        }

        /// <summary>
        /// 动态构建表格列内容
        /// </summary>
        /// <param name="row"></param>
        /// <param name="index"></param>
        /// <param name="source"></param>
        protected abstract void BuildPartialContent(IRow row, int index, IEnumerable<T> source);

    }
}
