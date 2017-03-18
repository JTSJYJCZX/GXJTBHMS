using System;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using System.Linq;
using System.Collections.Generic;
using GxjtBHMS.Models;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.SqlServerDAL;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.Implementations
{
    public class DisplaymentDatasQueryService : MonitorDatasEigenvalueQueryServiceBase<DisplacementTable>, IDisplaymentDatasQueryService
    {
        readonly IDisplaymentDatasDAL _displaymentDatasDAL;

        public DisplaymentDatasQueryService(
            IDisplaymentDatasDAL displaymentDatasDAL,
            IMonitorDatasEigenvalueQueryChartService<DisplacementTable> chartService,
            IMonitorDatasEigenvalueQueryFileSystemService<DisplacementTable> fileSystemService
            ) : base(chartService, fileSystemService)
        {
            _displaymentDatasDAL = displaymentDatasDAL;
        }

       
        public ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            var resp = new ChartDatasResponse();
            IList<Func<DisplacementTable, bool>> ps = new List<Func<DisplacementTable, bool>>();
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
            IList<Func<DisplacementTable, bool>> ps = new List<Func<DisplacementTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
               resp.Datas= _fileSystemService.ConvertToDocument(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "无法下载数据";
                Log(ex);
            }
            return resp;
        }

        public DisplaymentDatasQueryResultResponse GetPaginatorDataBy(DatasQueryResultRequest req)
        {

            var resp = new DisplaymentDatasQueryResultResponse();
            IEnumerable<DisplacementTable> displaymentsExcludePaging = new List<DisplacementTable>();
            IList<Func<DisplacementTable, bool>> ps = new List<Func<DisplacementTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                displaymentsExcludePaging = _displaymentDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
                resp.TotalResultCount = _displaymentDatasDAL.GetCountByContains(ps.ToArray(), ServiceConstant.PointsNumberPointsPositionNavigationProperty);
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
            IList<Func<DisplacementTable, bool>> ps = new List<Func<DisplacementTable, bool>>();
            DealWithConditions(req, ps);
            return _displaymentDatasDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }
    }
}



