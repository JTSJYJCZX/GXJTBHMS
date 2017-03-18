using GxjtBHMS.Service.Interfaces;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.TestTypes;
using System;

namespace GxjtBHMS.Service.Implementations
{
    public class MonitoringTestTypeService : ServiceBase, IMonitoringTestTypeService
    {
        readonly IMonitoringTestTypeDAL _mttDAL;

        public MonitoringTestTypeService(IMonitoringTestTypeDAL mttDAL)
        {
            _mttDAL = mttDAL;
        }


        public QueryAllMonitoringTestTypesResponse GetAllTestType()
        {
            var resp = new QueryAllMonitoringTestTypesResponse();
            try
            {
                var source = _mttDAL.FindAll();
                var models = source.ConvertToMonitoringTestTypeViewModelCollection();
                resp.Datas = models;
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "获取测试类型数据发生错误";
                Log(ex);
            }
            return resp;
        }

    }
}
