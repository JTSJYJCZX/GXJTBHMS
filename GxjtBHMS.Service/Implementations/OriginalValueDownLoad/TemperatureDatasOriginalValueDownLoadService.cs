﻿using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Interfaces.MonitoringDatasOriginalValueDownLoadInerfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    public class TemperatureDatasOriginalValueDownloadService : MonitorDatasOringinalValueDownloadServiceBase<TemperatureTable>,
        ITemperatureDatasOriginalValueDownloadService
    {
        public TemperatureDatasOriginalValueDownloadService(IMonitorDatasQueryFileSystemService<TemperatureTable> fileSystemService) :
            base(fileSystemService)
        {
        }

        public DownloadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            IList<Func<TemperatureTable, bool>> ps = new List<Func<TemperatureTable,bool>>();
            var resp = new DownloadOriginalvalueDatasResponse();
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
