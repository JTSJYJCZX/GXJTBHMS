using System;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class CableForceEigenvalueDatasQuery : MonitoringDatasEigenvalueQueryServiceBase
    {
        readonly ICableForceDatasEigenvalueQueryService _cableForceDatasService;

        public CableForceEigenvalueDatasQuery()
        {
            _cableForceDatasService = new NinjectFactory()
                .GetInstance<ICableForceDatasEigenvalueQueryService>();
        }

        public override ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            return _cableForceDatasService.GetChartDatasBy(req);
        }




        public override bool HasQueryResult(DatasQueryResultRequest req)
        {
            var result = false;
            try
            {
               var count = _cableForceDatasService.GetTotalResultCountBy(req);
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
            return _cableForceDatasService.SaveAs(req);
        }
    }
}