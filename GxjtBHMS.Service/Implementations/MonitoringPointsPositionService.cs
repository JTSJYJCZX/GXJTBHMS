using GxjtBHMS.Service.Interfaces;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.PointsPosition;
using System.Linq;
using GxjtBHMS.Infrastructure.Helpers;

namespace GxjtBHMS.Service.Implementations
{
    public class MonitoringPointsPositionService : ServiceBase, IMonitoringPointsPositionService
    {
        IMonitoringPointsPositionDAL _mppDAL;
        public MonitoringPointsPositionService(IMonitoringPointsPositionDAL mppDAL)
        {
            _mppDAL = mppDAL;
        }


        public QueryAllMonitoringPointsPositionResponse GetAllMonitoringPointsPosition()
        {
            var resp = new QueryAllMonitoringPointsPositionResponse();
            try
            {
                IEnumerable<MonitoringPointsPosition> source = _mppDAL.FindAll();
                var models = source.ConvertToMonitoringTestTypeViewModelCollection();
                resp.Datas = models;
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "获取测点位置数据发生错误";
                Log(ex);
            }
            return resp;
        }

        public string GetMixedNameWithTestTypeNameAndPointPositionNameAndCurrentDateTimeByPositionId(int positionId)
        {
            var model = _mppDAL.FindBy(m => m.Id == positionId, new string[] { "TestType" }).SingleOrDefault();
            return CreateMixedName(model.Name, model.TestType.Name, DateTime.Now.FormatDateWithoutSymbol());
        }

        string CreateMixedName(string positionName, string testTypeName, string currentDateTime)
        {
            return string.Concat(testTypeName,"_", positionName,"_", currentDateTime);
        }

        public QueryMonitoringPointsPositionsByTestTypeIdResponse GetMonitoringPointsPositionsByTestTypeId(int ttId)
        {
            var resp = new QueryMonitoringPointsPositionsByTestTypeIdResponse();
            try
            {
                if (ttId == 0)
                {
                    resp.Succeed = false;
                }
                var source = _mppDAL.GetModelsByTestTypeId(ttId);
                var models = source.ConvertToMonitoringTestTypeViewModelCollection();
                resp.Datas = models;
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "获取测点位置数据发生错误";
                Log(ex);
            }
            return resp;
        }

    }
}
