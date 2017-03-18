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
    public class CableForceDatasQueryService : MonitorDatasEigenvalueQueryServiceBase<CableForceTable>, ICableForceDatasQueryService
    {
        readonly ICableForceDatasDAL _cableForceDatasDAL;

        public CableForceDatasQueryService(
            ICableForceDatasDAL cableForceDatasDAL,
            IMonitorDatasEigenvalueQueryChartService<CableForceTable> chartService,
            IMonitorDatasEigenvalueQueryFileSystemService<CableForceTable> fileSystemService
            ) : base(chartService, fileSystemService)
        {
            _cableForceDatasDAL = cableForceDatasDAL;
        }


        public ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            var resp = new ChartDatasResponse();
            IList<Func<CableForceTable, bool>> ps = new List<Func<CableForceTable, bool>>();
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
            IList<Func<CableForceTable, bool>> ps = new List<Func<CableForceTable, bool>>();
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
            IEnumerable<CableForceTable> displaymentsExcludePaging = new List<CableForceTable>();
            IList<Func<CableForceTable, bool>> ps = new List<Func<CableForceTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                displaymentsExcludePaging = _cableForceDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
                resp.TotalResultCount = _cableForceDatasDAL.GetCountByContains(ps.ToArray(), ServiceConstant.PointsNumberPointsPositionNavigationProperty);
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
            IList<Func<CableForceTable, bool>> ps = new List<Func<CableForceTable, bool>>();
            DealWithConditions(req, ps);
            return _cableForceDatasDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }
    }
}



