using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Service.MonitoringDatasDownloadService
{
  public  class OriginalValueDownloadService
    {
        IMonitoringPointsNumberDAL _mpnDAL;
        ISteelArchStrainDatasOriginalValueDAL _steelArchStrainDatasOriginalValueDAL;


        public OriginalValueDownloadService()
        {
            _steelArchStrainDatasOriginalValueDAL = new NinjectFactory().GetInstance<ISteelArchStrainDatasOriginalValueDAL>();
            _mpnDAL = new NinjectFactory().GetInstance<IMonitoringPointsNumberDAL>();
        }
        public DownLoadDatasResponse DownloadTxt(DatasQueryResultRequestBase req, string path)
        {
            var resp = new DownLoadDatasResponse();

            switch (req.TestTypeId)
            {
                case 1:
                    try
                    {
                        var ps = DealWithConditionParameter(req);
                        resp.FilePath = _steelArchStrainDatasOriginalValueDAL.DownLoadTxtByExec(ps, path);
                        resp.Succeed = true;
                    }
                    catch (Exception ex)
                    {
                        resp.Message = "无法下载数据";
                    }
                    return resp;
                case 2:
                    return resp;
                case 3:
                    return resp;
                case 4:
                    return resp;
                case 5:
                    return resp;
                case 6:
                    return resp;
                case 7:
                    return resp;
                case 8:
                    return resp;
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }

        public int[] GetMonitoringPointsNumberIds(int mornitoringPointsPositionId)
        {
            var source = _mpnDAL.GetModelsByPointsPositionId(mornitoringPointsPositionId);
            return source.Select(m => m.Id).ToArray();
        }

        private ConditionParameters DealWithConditionParameter(DatasQueryResultRequestBase req)
        {
            ConditionParameters ps = new ConditionParameters();
            ps.EndTime = req.EndTime;
            ps.StarTime = req.StartTime;
            ps.PointsNumberIds = req.PointsNumberIds;
            return ps;
        }


    }
}
