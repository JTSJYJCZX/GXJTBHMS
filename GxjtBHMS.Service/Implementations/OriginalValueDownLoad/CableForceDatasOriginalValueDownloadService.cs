﻿using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.Implementations.OriginalValueDownLoad
{
    public class CableForceDatasOriginalValueDownloadService : MonitorDatasOringinalValueDownloadServiceBase<CableForceTable>,
          ICableForceDatasOriginalValueDownloadService
    {
        public CableForceDatasOriginalValueDownloadService(
            IMonitorDatasQueryFileSystemService<CableForceTable> fileSystemService) : base(fileSystemService)
        {

        }

        public DownloadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownloadOriginalvalueDatasResponse();
            IList<Func<CableForceTable, bool>> ps = new List<Func<CableForceTable, bool>>();
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
