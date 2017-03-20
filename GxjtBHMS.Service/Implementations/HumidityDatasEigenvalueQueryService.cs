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
    public class HumidityDatasEigenvalueQueryService : MonitorDatasEigenvalueQueryServiceBase<HumidityEigenvalueTable>, IHumidityDatasEigenvalueQueryService
    {
        readonly IHumidityDatasEigenvalueDAL _humidityDatasDAL;

        public HumidityDatasEigenvalueQueryService(
            IHumidityDatasEigenvalueDAL humidityDatasDAL,
            IMonitorDatasEigenvalueQueryChartService<HumidityEigenvalueTable> chartService,
            IMonitorDatasQueryFileSystemService<HumidityEigenvalueTable> fileSystemService
            ) : base(chartService, fileSystemService)
        {
            _humidityDatasDAL = humidityDatasDAL;
        }



        public ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            var resp = new ChartDatasResponse();
            IList<Func<HumidityEigenvalueTable, bool>> ps = new List<Func<HumidityEigenvalueTable, bool>>();
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
            IList<Func<HumidityEigenvalueTable, bool>> ps = new List<Func<HumidityEigenvalueTable, bool>>();
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
            IList<Func<HumidityEigenvalueTable, bool>> ps = new List<Func<HumidityEigenvalueTable, bool>>();
            DealWithConditions(req, ps);
            return _humidityDatasDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }
    }
}



