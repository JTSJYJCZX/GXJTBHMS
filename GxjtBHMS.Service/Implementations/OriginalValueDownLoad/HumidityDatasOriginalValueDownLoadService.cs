using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces.MonitoringDatasOriginalValueDownLoadInerfaces;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    public class HumidityDatasOriginalValueDownLoadService : MonitorDatasOringinalValueDownloadServiceBase<HumidityTable>,
        IHumidityDatasOriginalValueDownLoadService
    {
        public HumidityDatasOriginalValueDownLoadService(IMonitorDatasQueryFileSystemService<HumidityTable> fileSystemService) : base(fileSystemService)
        {
        }

        public DownLoadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownLoadOriginalvalueDatasResponse();
            IList<Func<HumidityTable, bool>> ps = new List<Func<HumidityTable, bool>>();
            try
            {
                DealWithConditions(req,ps);
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
