using System;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class WindLoadEigenvalueDatasQuery : MonitoringDatasEigenvalueQueryServiceBase
    {
        readonly IWindLoadDatasEigenvalueQueryService _windLoadEigenValueDatasService;

        public WindLoadEigenvalueDatasQuery()
        {
            _windLoadEigenValueDatasService = new NinjectFactory()
                .GetInstance<IWindLoadDatasEigenvalueQueryService>();
        }

        public override ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            return _windLoadEigenValueDatasService.GetChartDatasBy(req);
        }
    

        

        public override PagedResponse GetPaginatorDatas(DatasQueryResultRequest req)
        {
            var resp = new PagedResponse();

            try
            {
                resp.TotalResultCount = _windLoadEigenValueDatasService.GetTotalResultCountBy(req);
                if (resp.TotalResultCount>0)
                {
                    resp.Succeed = true;
                }
                else
                {
                    resp.Message = "无记录";
                }
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return resp;
        }

        public override DownLoadDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _windLoadEigenValueDatasService.SaveAs(req);
        }
    }
}