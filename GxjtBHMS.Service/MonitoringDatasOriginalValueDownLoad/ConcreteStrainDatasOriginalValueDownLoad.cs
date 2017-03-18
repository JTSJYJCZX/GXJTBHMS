using System;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class ConcreteStrainDatasOriginalValueDownLoad : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly IConcreteStrainDatasOriginalValueDownLoadService _concreteStrainDatasOriginalValueDownLoadService;

        public ConcreteStrainDatasOriginalValueDownLoad()
        {
            _concreteStrainDatasOriginalValueDownLoadService = new NinjectFactory()
                .GetInstance<IConcreteStrainDatasOriginalValueDownLoadService>();
        }
         
        public override DownLoadOriginalvalueDatasResponse OriginalvalueSaveAsFile(DatasQueryResultRequestBase req)
        {
            return _concreteStrainDatasOriginalValueDownLoadService.SaveAs(req);
        }
    }
}