using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.SafetyPreWarningRealTimeHubService
{
    public class SafetyPreWarningRealTimePushService: ISafetyPreWarningRealTimePushService
    {
        IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_CableForceTable> _cfrts;
        IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_DisplacementTable> _drts;
        IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_TemperatureTable> _trts;
        IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_WindLoadTable> _wlrts;

        public SafetyPreWarningRealTimePushService(IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_CableForceTable> cfrts,
             IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_DisplacementTable> drts,
             IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_TemperatureTable> trts,
             IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_WindLoadTable> wlrts) 
        {
            _cfrts = cfrts;
            _drts = drts;
            _trts =trts;
            _wlrts = wlrts;
        }

        public AllSafetyPreWarningStateDataModel GetSafetyPreWarningRealTimePushModel(GetSafetyWarningDetailRequest req)
        {
            return new AllSafetyPreWarningStateDataModel
            {
                SafetyPreWarningColor = getBridgeSafetyState(req).SafetyPreWarningColor,
                SafetyPreWarningState = getBridgeSafetyState(req).SafetyPreWarningState,
                SafetyPreWarningStateData = GetAllSafetyDatas(req)
            };
        }

        List<SafetyPreWarningStateAndTotalTimesModel> GetAllSafetyDatas(GetSafetyWarningDetailRequest req)
        {
            var cableForceData = _cfrts.GetSafetyPreWarningStateModel(req,1);
            var displacementData = _cfrts.GetSafetyPreWarningStateModel(req,2);
            var windLoadData = _wlrts.GetSafetyPreWarningStateModel(req,3);
            var temperatureData = _trts.GetSafetyPreWarningStateModel(req, 4);
            return new List<SafetyPreWarningStateAndTotalTimesModel>
            {
                cableForceData,
                displacementData,
                temperatureData,
                windLoadData
            };
        }

        SafetyStateModel getBridgeSafetyState(GetSafetyWarningDetailRequest req)
        {
            var datas = GetAllSafetyDatas(req);
            var bridgeSafetyState=new SafetyStateModel();
            var maxBridgeId = datas.Select(m => m.GradeId).Max();
            bridgeSafetyState.SafetyPreWarningColor = datas.Where(m => m.GradeId == maxBridgeId).Select(m => m.SafetyPreWarningColor).First();
            bridgeSafetyState.SafetyPreWarningState = datas.Where(m => m.GradeId == maxBridgeId).Select(m => m.SafetyPreWarningState).First();
            return bridgeSafetyState;
        }
    }
}
