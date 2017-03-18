using GxjtBHMS.Service.Interfaces;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.PointsNumbers;

namespace GxjtBHMS.Service.Implementations
{
    public class MonitoringPointsNumberService : ServiceBase, IMonitoringPointsNumberService
    {
        IMonitoringPointsNumberDAL _mpnDAL;
        public MonitoringPointsNumberService(IMonitoringPointsNumberDAL mpnDAL)
        {
            _mpnDAL = mpnDAL;
        }


        public QueryAllMonitoringMonitoringPointsNumberResponse GetAllMonitoringPointsNumber()
        {
            var resp = new QueryAllMonitoringMonitoringPointsNumberResponse();
            try
            {
                IEnumerable<MonitoringPointsNumber> source = _mpnDAL.FindAll();
                var models = source.ConvertToMonitoringTestTypeViewModelCollection();
                resp.Datas = models;
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "获取测点编号数据发生错误";
                Log(ex);
            }
            return resp;
        }

        public QueryMonitoringPointsNumberByPointsPositionIdResponse GetMonitoringPointsNumberByPointsPositionId(int ttId)
        {
            var resp = new QueryMonitoringPointsNumberByPointsPositionIdResponse();
            try
            {
                var source = _mpnDAL.GetModelsByPointsPositionId(ttId);
                var models = source.ConvertToMonitoringTestTypeViewModelCollection();
                resp.Datas = models;
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "获取测点编号数据发生错误";
                Log(ex);
            }
            return resp;
        }
    }
}

