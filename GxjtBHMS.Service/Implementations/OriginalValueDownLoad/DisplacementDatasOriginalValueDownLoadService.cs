using System;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Models;

namespace GxjtBHMS.Service.Implementations
{
    public class DisplacementDatasOriginalValueDownloadService : MonitorDatasOringinalValueDownloadServiceBase<DisplacementTable>,
        IDisplacementDatasOriginalValueDownLoadService
    {
        public DisplacementDatasOriginalValueDownloadService(
            IMonitorDatasQueryFileSystemService<DisplacementTable> fileSystemService
            ) : base(fileSystemService)
        {
        }


        public DownLoadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownLoadOriginalvalueDatasResponse();
            IList<Func<DisplacementTable, bool>> ps = new List<Func<DisplacementTable, bool>>();
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

