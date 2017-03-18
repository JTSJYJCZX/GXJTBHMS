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

namespace GxjtBHMS.Service.Implementations
{
    public class HumidityDatasQueryService : MonitorDatasEigenvalueQueryServiceBase<HumidityTable>, IHumidityDatasQueryService
    {
        readonly IHumidityDatasDAL _humidityDatasDAL;

        public HumidityDatasQueryService(
            IHumidityDatasDAL humidityDatasDAL,
            IMonitorDatasEigenvalueQueryChartService<HumidityTable> chartService,
            IMonitorDatasEigenvalueQueryFileSystemService<HumidityTable> fileSystemService
            ) : base(chartService, fileSystemService)
        {
            _humidityDatasDAL = humidityDatasDAL;
        }



        public ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            var resp = new ChartDatasResponse();
            IList<Func<HumidityTable, bool>> ps = new List<Func<HumidityTable, bool>>();
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
            IList<Func<HumidityTable, bool>> ps = new List<Func<HumidityTable, bool>>();
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

        public HumidityDatasQueryResultResponse GetPaginatorDataBy(DatasQueryResultRequest req)
        {

            var resp = new HumidityDatasQueryResultResponse();
            IEnumerable<HumidityTable> humiditysExcludePaging = new List<HumidityTable>();
            IList<Func<HumidityTable, bool>> ps = new List<Func<HumidityTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                humiditysExcludePaging = _humidityDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
                resp.TotalResultCount = _humidityDatasDAL.GetCountByContains(ps.ToArray(), ServiceConstant.PointsNumberPointsPositionNavigationProperty);
                resp.Succeed = true;

            }
            catch (Exception ex)
            {
                resp.Message = "搜索数据列表信息发生错误";
                Log(ex);
            }
            return resp;
        }

        public long GetTotalResultCountBy(DatasQueryResultRequest req)
        {
            IList<Func<HumidityTable, bool>> ps = new List<Func<HumidityTable, bool>>();
            DealWithConditions(req, ps);
            return _humidityDatasDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }
    }
}



