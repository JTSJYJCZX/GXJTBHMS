using System;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class SteelArchStrainEigenvalueDatasQuery : MonitoringDatasEigenvalueQueryServiceBase
    {
        readonly ISteelArchStrainDatasEigenvalueQueryService _steelArchStrainDatasService;

        public SteelArchStrainEigenvalueDatasQuery()
        {
            _steelArchStrainDatasService = new NinjectFactory()
                .GetInstance<ISteelArchStrainDatasEigenvalueQueryService>();
        }

        public override ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            return _steelArchStrainDatasService.GetChartDatasBy(req);
        }




        public override bool HasQueryResult(DatasQueryResultRequest req)
        {
            var result = false;
            try
            {
                var count = _steelArchStrainDatasService.GetTotalResultCountBy(req);
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
            return _steelArchStrainDatasService.SaveAs(req);
        }
    }
}