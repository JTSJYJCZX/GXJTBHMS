using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Interfaces.MonitoringDatasOriginalValueDownLoadInerfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    public class WindLoadDatasOriginalValueDownloadService : MonitorDatasOringinalValueDownloadServiceBase<WindLoadTable>,
        IWindLoadDatasOriginalValueDownloadService
    {
        public WindLoadDatasOriginalValueDownloadService(IMonitorDatasQueryFileSystemService<WindLoadTable> fileSystemService) : base(fileSystemService)
        {
        }

        public DownloadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownloadOriginalvalueDatasResponse();
            IList<Func<WindLoadTable,bool> > ps = new List<Func<WindLoadTable, bool>>();
            try
            {
                DealWithConditions(req,ps);
                resp.Datas = _fileSystemService.ConvertToDocument(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "数据无法下载";
                Log(ex);
            }
            return resp;
        }
    }
}
