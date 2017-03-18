using System;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class ConcreteStrainEigenvalueDatasQuery : MonitoringDatasEigenvalueQueryServiceBase
    {
        readonly IConcreteStrainDatasEigenvalueQueryService _concreteStrainDatasService;

        public ConcreteStrainEigenvalueDatasQuery()
        {
            _concreteStrainDatasService = new NinjectFactory()
                .GetInstance<IConcreteStrainDatasEigenvalueQueryService>();
        }

        public override ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
             return  _concreteStrainDatasService.GetChartDatasBy(req);

        }




        public override bool HasQueryResult(DatasQueryResultRequest req)
        {
            var result = false;
            try
            {
                var count = _concreteStrainDatasService.GetTotalResultCountBy(req);
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
            return _concreteStrainDatasService.SaveAs(req);
        }
    }
}