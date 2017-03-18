using System;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.IDAL;
using System.Linq;
using System.Collections.Generic;
using Microsoft.Office.Interop.Excel;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.Service.Implementations
{
    public class ConcreteStrainDatasOriginalValueDownLoadService : MonitorDatasOringinalValueDownLoadServiceBase<ConcreteStrainTable>, 
        IConcreteStrainDatasOriginalValueDownLoadService
    {
        readonly IConcreteStrainDatasOriginalValueDAL _concreteStrainDatasOriginalValueDAL;
        public ConcreteStrainDatasOriginalValueDownLoadService(IConcreteStrainDatasOriginalValueDAL concreteStrainDatasOriginalValueDAL,
            IMonitorDatasEigenvalueQueryFileSystemService<ConcreteStrainTable> fileSystemService
            ) : base(fileSystemService)
        {
            _concreteStrainDatasOriginalValueDAL = concreteStrainDatasOriginalValueDAL;
        }


        public DownLoadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownLoadOriginalvalueDatasResponse();
            IList<Func<ConcreteStrainTable, bool>> ps = new List<Func<ConcreteStrainTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                resp.Datas = _fileSystemService.ConvertToDocument(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "无法下载数据";
                Log(ex);
            }
            return resp;
        }
      

        /// <summary>
        /// 根据查询条件将查询结果写入excel
        /// </summary>
        /// <param name="excel"></param>
        /// <param name="ps"></param>
        void ExcelCreate(Application excel, IList<Func<ConcreteStrainTable, bool>> ps)
        {
            IEnumerable<ConcreteStrainTable> strainsExcludePaging = new List<ConcreteStrainTable>();
            strainsExcludePaging = _concreteStrainDatasOriginalValueDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果

            //设置表头信息
            excel.Cells[1, 1] = "序号";
            excel.Cells[1, 2] = "测点编号";
            excel.Cells[1, 3] = "测点位置";
            excel.Cells[1, 4] = "应变值";
            excel.Cells[1, 5] = "监测时间";
            excel.Cells[1, 6] = "温度";
            for (int i = 0; i < strainsExcludePaging.ToArray().Length; i++)
            {
                excel.Cells[i + 2, 1] = i + 1;
                excel.Cells[i + 2, 2] = strainsExcludePaging.ToArray()[i].PointsNumber.Name;
                excel.Cells[i + 2, 3] = null;
                excel.Cells[i + 2, 4] = strainsExcludePaging.ToArray()[i].Strain;
                excel.Cells[i + 2, 5] = strainsExcludePaging.ToArray()[i].Time;
                excel.Cells[i + 2, 6] = strainsExcludePaging.ToArray()[i].Temperature;
            }
        }
        
    }
}

