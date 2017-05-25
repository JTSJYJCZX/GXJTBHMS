using GxjtBHMS.IDAL;
using GxjtBHMS.Infrastructure;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using System;
using System.Linq;

namespace GxjtBHMS.Service.MonitoringDatasDownloadService
{
    public class EigenvalueDownloadService:ServiceBase
    {
        IMonitoringPointsNumberDAL _mpnDAL;
        IMonitoringDatasEigenvalueDownloadDAL _monitoringDatasEigenvalueDownloadDAL;


        public EigenvalueDownloadService()
        {
            _monitoringDatasEigenvalueDownloadDAL = new NinjectFactory().GetInstance<IMonitoringDatasEigenvalueDownloadDAL>();
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
                        resp.FilePath = _monitoringDatasEigenvalueDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.SteelArchStrainDatasEigenvalueDownloadProc);
                        resp.Succeed = true;
                    }
                    catch (Exception ex)
                    {
                        resp.Message = "无法下载数据";
                        Log(ex);
                    }
                    return resp;
                case 2:
                    try
                    {
                        var ps = DealWithConditionParameter(req);
                        resp.FilePath = _monitoringDatasEigenvalueDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.SteelLatticeStrainDatasEigenvalueDownloadProc);
                        resp.Succeed = true;
                    }
                    catch (Exception ex)
                    {
                        resp.Message = "无法下载数据";
                        Log(ex);
                    }
                    return resp;
                case 3:
                    try
                    {
                        var ps = DealWithConditionParameter(req);
                        resp.FilePath = _monitoringDatasEigenvalueDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.ConcreteStrainDatasEigenvalueDownloadProc);
                        resp.Succeed = true;
                    }
                    catch (Exception ex)
                    {
                        resp.Message = "无法下载数据";
                        Log(ex);
                    }
                    return resp;
                case 4:
                    try
                    {
                        var ps = DealWithConditionParameter(req);
                        resp.FilePath = _monitoringDatasEigenvalueDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.DisplacementDatasEigenvalueDownloadProc);
                        resp.Succeed = true;
                    }
                    catch (Exception ex)
                    {
                        resp.Message = "无法下载数据";
                        Log(ex);
                    }
                    return resp;
                case 5:
                    try
                    {
                        var ps = DealWithConditionParameter(req);
                        resp.FilePath = _monitoringDatasEigenvalueDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.CableForceDatasEigenvalueDownloadProc);
                        resp.Succeed = true;
                    }
                    catch (Exception ex)
                    {
                        resp.Message = "无法下载数据";
                        Log(ex);
                    }
                    return resp;
                case 6:
                    try
                    {
                        var ps = DealWithConditionParameter(req);
                        resp.FilePath = _monitoringDatasEigenvalueDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.HumidityDatasEigenvalueDownloadProc);
                        resp.Succeed = true;
                    }
                    catch (Exception ex)
                    {
                        resp.Message = "无法下载数据";
                        Log(ex);
                    }
                    return resp;
                case 7:
                    try
                    {
                        var ps = DealWithConditionParameter(req);
                        resp.FilePath = _monitoringDatasEigenvalueDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.TemperatureDatasEigenvalueDownloadProc);
                        resp.Succeed = true;
                    }
                    catch (Exception ex)
                    {
                        resp.Message = "无法下载数据";
                        Log(ex);
                    }
                    return resp;
                case 8:
                    try
                    {
                        var ps = DealWithConditionParameter(req);
                        resp.FilePath = _monitoringDatasEigenvalueDownloadDAL.DownLoadTxtByExec(ps, path, AppConstants.WindLoadDatasEigenvalueDownloadProc);
                        resp.Succeed = true;
                    }
                    catch (Exception ex)
                    {
                        resp.Message = "无法下载数据";
                        Log(ex);
                    }
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
