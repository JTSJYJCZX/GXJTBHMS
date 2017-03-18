using System;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.IDAL;
using System.Linq;
using System.Collections.Generic;
using GxjtBHMS.Models;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging;
using Microsoft.Office.Interop.Excel;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.Service.Implementations
{
    public class ConcreteStrainDatasEigenvalueQueryService : MonitorDatasQueryServiceBase<ConcreteStrainEigenvalueTable>, 
        IConcreteStrainDatasEigenvalueQueryService
    {
        readonly IConcreteStrainDatasEigenValueDAL _concreteStrainDatasEigenValueDAL;
        public ConcreteStrainDatasEigenvalueQueryService(IConcreteStrainDatasEigenValueDAL concreteStrainDatasEigenValueDAL,
            IMonitorDatasEigenvalueQueryChartService<ConcreteStrainEigenvalueTable> chartService,
            IMonitorDatasQueryFileSystemService<ConcreteStrainEigenvalueTable> fileSystemService
            ) : base(chartService, fileSystemService)
        {
            _concreteStrainDatasEigenValueDAL = concreteStrainDatasEigenValueDAL;
        }
    

        public ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            var resp = new ChartDatasResponse();
            IList<Func<ConcreteStrainEigenvalueTable, bool>> ps = new List<Func<ConcreteStrainEigenvalueTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                resp.Datas = _chartService.GetChartDataSourceBy(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = ex.Message;
                Log(ex);
            }
            return resp;
        }

        public DownLoadDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownLoadDatasResponse();
            IList<Func<ConcreteStrainEigenvalueTable, bool>> ps = new List<Func<ConcreteStrainEigenvalueTable, bool>>();
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

        public long GetTotalResultCountBy(DatasQueryResultRequest req)
        {
            IList<Func<ConcreteStrainEigenvalueTable, bool>> ps = new List<Func<ConcreteStrainEigenvalueTable, bool>>();
            DealWithConditions(req, ps);
            return _concreteStrainDatasEigenValueDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }
    }
}

