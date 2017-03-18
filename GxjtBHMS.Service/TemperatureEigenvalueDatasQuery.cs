using System;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class TemperatureEigenvalueDatasQuery : MonitoringDatasEigenvalueQueryServiceBase
    {
        readonly ITemperatureDatasEigenvalueQueryService _temperatureDatasService;

        public TemperatureEigenvalueDatasQuery()
        {
            _temperatureDatasService = new NinjectFactory()
                .GetInstance<ITemperatureDatasEigenvalueQueryService>();
        }

        public override ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            return _temperatureDatasService.GetChartDatasBy(req);
        }




        public override bool HasQueryResult(DatasQueryResultRequest req)
        {
            var result = false;
            try
            {
                var count = _temperatureDatasService.GetTotalResultCountBy(req);
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
            return _temperatureDatasService.SaveAs(req);
        }
    }
}