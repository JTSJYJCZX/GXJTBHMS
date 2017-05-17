using GxjtBHMS.Service.ViewModels.MonitoringDatas.SafetyPreWarning;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.SafetyPreWarning
{
    public class SafetyWarningDetailResponse:ResponseBase
    {
        public IEnumerable<SafetyPreWarningDetailQueryModel> Datas { get; set; }
    }
}