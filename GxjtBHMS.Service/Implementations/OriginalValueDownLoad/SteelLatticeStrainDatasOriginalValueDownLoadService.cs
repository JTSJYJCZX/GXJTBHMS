using System;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.IDAL;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.Service.Implementations
{
    public class SteelLatticeStrainDatasOriginalValueDownloadService : MonitorDatasOringinalValueDownloadServiceBase<SteelLatticeStrainTable>,
        ISteelLatticeStrainDatasOriginalValueDownLoadService
    {
        public SteelLatticeStrainDatasOriginalValueDownloadService(
            IMonitorDatasQueryFileSystemService<SteelLatticeStrainTable> fileSystemService
            ) : base(fileSystemService)
        {
        }

        public DownLoadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownLoadOriginalvalueDatasResponse();
            IList<Func<SteelLatticeStrainTable, bool>> ps = new List<Func<SteelLatticeStrainTable, bool>>();
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

