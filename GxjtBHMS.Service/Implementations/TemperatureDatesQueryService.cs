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
    public class TemperatureDatasQueryService : MonitorDatasQueryServiceBase<TemperatureTable>, ITemperatureDatasQueryService
    {
        readonly ITemperatureDatasDAL _temperatureDatasDAL;

        public TemperatureDatasQueryService(
            ITemperatureDatasDAL temperatureDatasDAL,
            IMonitorDatasEigenvalueQueryChartService<TemperatureTable> chartService,
            IMonitorDatasQueryFileSystemService<TemperatureTable> fileSystemService
            ) : base(chartService, fileSystemService)
        {
            _temperatureDatasDAL = temperatureDatasDAL;
        }

        

        public ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            var resp = new ChartDatasResponse();
            IList<Func<TemperatureTable, bool>> ps = new List<Func<TemperatureTable, bool>>();
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
            IList<Func<TemperatureTable, bool>> ps = new List<Func<TemperatureTable, bool>>();
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

        public TemperatureDatasQueryResultResponse GetPaginatorDataBy(DatasQueryResultRequest req)
        {

            var resp = new TemperatureDatasQueryResultResponse();
            IEnumerable<TemperatureTable> temperatureExcludePaging = new List<TemperatureTable>();
            IList<Func<TemperatureTable, bool>> ps = new List<Func<TemperatureTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                temperatureExcludePaging = _temperatureDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
                resp.TotalResultCount = _temperatureDatasDAL.GetCountByContains(ps.ToArray(), ServiceConstant.PointsNumberPointsPositionNavigationProperty);
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
            IList<Func<TemperatureTable, bool>> ps = new List<Func<TemperatureTable, bool>>();
            DealWithConditions(req, ps);
            return _temperatureDatasDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }
    }
}



