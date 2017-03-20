using System;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.IDAL;
using System.Linq;
using System.Collections.Generic;
using GxjtBHMS.Models;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.Service.Implementations
{
    public class TemperatureDatasEigenvalueQueryService : MonitorDatasEigenvalueQueryServiceBase<TemperatureEigenvalueTable>, ITemperatureDatasEigenvalueQueryService 
    {
        readonly ITemperatureDatasEigenvalueDAL _temperatureDatasDAL;

        public TemperatureDatasEigenvalueQueryService(
            ITemperatureDatasEigenvalueDAL temperatureDatasDAL,
            IMonitorDatasEigenvalueQueryChartService<TemperatureEigenvalueTable> chartService,
            IMonitorDatasQueryFileSystemService<TemperatureEigenvalueTable> fileSystemService
            ) : base(chartService, fileSystemService)
        {
            _temperatureDatasDAL = temperatureDatasDAL;
        }

        

        public ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            var resp = new ChartDatasResponse();
            IList<Func<TemperatureEigenvalueTable, bool>> ps = new List<Func<TemperatureEigenvalueTable, bool>>();
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
            IList<Func<TemperatureEigenvalueTable, bool>> ps = new List<Func<TemperatureEigenvalueTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                resp.Datas=_fileSystemService.ConvertToDocument(ps);
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
            IList<Func<TemperatureEigenvalueTable, bool>> ps = new List<Func<TemperatureEigenvalueTable, bool>>();
            DealWithConditions(req, ps);
            return _temperatureDatasDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }
    }
}



