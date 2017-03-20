using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class SteelArchStrainOriginalValueDatasDownLoad : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly ISteelArchStrainDatasOriginalValueDownLoadService _steelArchStrainDatasOriginalValueDownLoadService;

        public SteelArchStrainOriginalValueDatasDownLoad()
        {
            _steelArchStrainDatasOriginalValueDownLoadService = new NinjectFactory()
                .GetInstance<ISteelArchStrainDatasOriginalValueDownLoadService>();
        }
         
        public override DownLoadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _steelArchStrainDatasOriginalValueDownLoadService.SaveAs(req);
        }
    }
}