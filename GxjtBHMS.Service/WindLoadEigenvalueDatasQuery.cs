using System;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
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

        public override bool HasQueryResult(DatasQueryResultRequest req)
        {
            var result = false;
            try
            {
                var count = _windLoadEigenValueDatasService.GetTotalResultCountBy(req);
                if (count > 0)
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return result;
        }

        public override DownLoadDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _windLoadEigenValueDatasService.SaveAs(req);
        }
    }
}