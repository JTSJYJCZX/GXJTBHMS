﻿using System;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.IDAL;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.Service.Implementations
{
    public class SteelArchStrainDatasOriginalValueDownloadService : MonitorDatasOringinalValueDownloadServiceBase<SteelArchStrainTable>,
        ISteelArchStrainDatasOriginalValueDownLoadService
    {
        public SteelArchStrainDatasOriginalValueDownloadService(
            IMonitorDatasQueryFileSystemService<SteelArchStrainTable> fileSystemService
            ) : base(fileSystemService)
        {
        }


        public DownLoadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownLoadOriginalvalueDatasResponse();
            IList<Func<SteelArchStrainTable, bool>> ps = new List<Func<SteelArchStrainTable, bool>>();
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

