using System;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.Service.Implementations
{
    public class ConcreteStrainDatasOriginalValueDownloadService : MonitorDatasOringinalValueDownloadServiceBase<ConcreteStrainTable>, 
        IConcreteStrainDatasOriginalValueDownloadService
    {
        public ConcreteStrainDatasOriginalValueDownloadService(
            IMonitorDatasQueryFileSystemService<ConcreteStrainTable> fileSystemService
            ) : base(fileSystemService)
        {
        }

        public DownloadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownloadOriginalvalueDatasResponse();
            IList<Func<ConcreteStrainTable, bool>> ps = new List<Func<ConcreteStrainTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                resp.Datas = _fileSystemService.ConvertToDocument(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "无法下载数据";
                Log(ex);
            }
            return resp;
        }
        
    }
}

