using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.IDAL.SafetyPreWarning;

namespace GxjtBHMS.Service.SafetyPreWarningRealTimeHubService
{
    public class SafetyPreWarningRealTimePushService : ISafetyPreWarningRealTimePushService
    {
        ISafetyPreWarningRealTimePushDAL _sfwrp;


        public SafetyPreWarningRealTimePushService(ISafetyPreWarningRealTimePushDAL sfwrp)
        {
            _sfwrp = sfwrp;

        }

        public AllSafetyPreWarningStateDataModel GetSafetyPreWarningRealTimePushModel()
        {
            AllSafetyPreWarningStateDataModel models = new AllSafetyPreWarningStateDataModel();
            var source = _sfwrp.GetAllSafetyDatas();
            models.SafetyPreWarningState = source.TotalSafetyPreWarningState;
            models.SafetyPreWarningColor = source.TotalSafetyPreWarningColor;
            
            List<SafetyPreWarningStateAndTotalTimesModel> result = new List<SafetyPreWarningStateAndTotalTimesModel>()
            {
                 new SafetyPreWarningStateAndTotalTimesModel { TestTypeId = 1,
                SafetyPreWarningState=source.CableForceSafetyPreWarningState,
                SafetyPreWarningColor=source.CableForceSafetyPreWarningColor,
                WarningGrade2Times=source.CableForceWarningGrade2Times,
                WarningGrade3Times=source.CableForceWarningGrade3Times },

                new SafetyPreWarningStateAndTotalTimesModel { TestTypeId = 2,
                SafetyPreWarningState=source.DisplacementSafetyPreWarningState,
                SafetyPreWarningColor=source.DisplacementSafetyPreWarningColor,
                WarningGrade2Times=source.DisplacementWarningGrade2Times,
                WarningGrade3Times=source.DisplacementWarningGrade3Times },

                new SafetyPreWarningStateAndTotalTimesModel { TestTypeId = 3,
                SafetyPreWarningState=source.WindLoadSafetyPreWarningState,
                SafetyPreWarningColor=source.WindLoadSafetyPreWarningColor,
                WarningGrade2Times=source.WindLoadWarningGrade2Times,
                WarningGrade3Times=source.WindLoadWarningGrade3Times },

                new SafetyPreWarningStateAndTotalTimesModel { TestTypeId = 4,
                SafetyPreWarningState=source.TemperatureSafetyPreWarningState,
                SafetyPreWarningColor=source.TemperatureSafetyPreWarningColor,
                WarningGrade2Times=source.TemperatureWarningGrade2Times,
                WarningGrade3Times=source.TemperatureWarningGrade3Times },
            };
            models.SafetyPreWarningStateData = result;            
            return models;
        }


    }
}
