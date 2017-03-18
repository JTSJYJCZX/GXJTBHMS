using System;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class HumidityEigenvalueDatasQuery : MonitoringDatasEigenvalueQueryServiceBase
    {
        readonly IHumidityDatasEigenvalueQueryService _humidityDatasService;

        public HumidityEigenvalueDatasQuery()
        {
            _humidityDatasService = new NinjectFactory()
                .GetInstance<IHumidityDatasEigenvalueQueryService>();
        }

        public override ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            return _humidityDatasService.GetChartDatasBy(req);
        }




        public override bool HasQueryResult(DatasQueryResultRequest req)
        {
            var result = false;
            try
            {
                var count = _humidityDatasService.GetTotalResultCountBy(req);
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
            return _humidityDatasService.SaveAs(req);
        }
    }
}