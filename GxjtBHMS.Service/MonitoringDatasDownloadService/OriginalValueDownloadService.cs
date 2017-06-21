using GxjtBHMS.IDAL;
using GxjtBHMS.IDAL.OriginalValueDownLoad;
using GxjtBHMS.Infrastructure;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using System;
using System.Linq;

namespace GxjtBHMS.Service.MonitoringDatasDownloadService
{
    public  class OriginalValueDownloadService:ServiceBase
    {
        IMonitoringPointsNumberDAL _mpnDAL;
        IOriginalDatasDownloadDAL _originalDatasDownloadDAL;
        public OriginalValueDownloadService()
        {
            _mpnDAL = new NinjectFactory().GetInstance<IMonitoringPointsNumberDAL>();
            _originalDatasDownloadDAL = new NinjectFactory().GetInstance<IOriginalDatasDownloadDAL>();
        }
        public DownLoadDatasResponse DownloadTxt(DatasQueryResultRequestBase req, string path)
        {
            var resp = new DownLoadDatasResponse();
            try
            {
                var ps = DealWithConditionParameter(req);
                switch (req.TestTypeId)
                {
                    case 1:
                        resp.FilePath = _originalDatasDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.BasicSteelArchStrain_Procedure);
                        resp.Succeed = true;
                        break;
                    case 2:
                        resp.FilePath = _originalDatasDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.BasicSteelLatticeStrain_Procedure);
                        resp.Succeed = true;
                        break;
                    case 3:
                        resp.FilePath = _originalDatasDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.BasicConcreteStrain_Procedure);
                        resp.Succeed = true;
                        break;
                    case 4:
                        resp.FilePath = _originalDatasDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.BasicDisplacement_Procedure);
                        resp.Succeed = true;
                        break;
                    case 5:
                        resp.FilePath = _originalDatasDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.BasicCableForce_Procedure);
                        resp.Succeed = true;
                        break;
                    case 6:
                        resp.FilePath = _originalDatasDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.BasicHumidity_Procedure);
                        resp.Succeed = true;
                        break;
                    case 7:
                        resp.FilePath = _originalDatasDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.BasicTemperature_Procedure);
                        resp.Succeed = true;
                        break;
                    case 8:
                        resp.FilePath = _originalDatasDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.BasicWindLoad_Procedure);
                        resp.Succeed = true;
                        break;
                    default:
                        throw new ApplicationException("No TestTypeId");
                }

            }
            catch (Exception ex)
            {
                resp.Message = "无法下载数据";
                Log(ex);
            }
            return resp;
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
