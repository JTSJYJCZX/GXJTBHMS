using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class CableForceDatasOriginalValueDownload 
    {
        readonly ICableForceDatasOriginalValueDownloadService _cableForceDatasOriginalValueDownloadService;

        public CableForceDatasOriginalValueDownload()
        {
            _cableForceDatasOriginalValueDownloadService = new NinjectFactory()
                .GetInstance<ICableForceDatasOriginalValueDownloadService>();
        }
         
        //public override DownloadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        //{
        //    return _cableForceDatasOriginalValueDownloadService.SaveAs(req);
        //}
    }
}