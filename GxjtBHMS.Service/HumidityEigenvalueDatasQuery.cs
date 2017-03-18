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




        public override PagedResponse GetPaginatorDatas(DatasQueryResultRequest req)
        {
            var resp = new PagedResponse();

            try
            {
                resp.TotalResultCount = _humidityDatasService.GetTotalResultCountBy(req);
                if (resp.TotalResultCount > 0)
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
            return _humidityDatasService.SaveAs(req);
        }
    }
}