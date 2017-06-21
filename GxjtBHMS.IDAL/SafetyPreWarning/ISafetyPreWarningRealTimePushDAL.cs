using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;

namespace GxjtBHMS.IDAL.SafetyPreWarning
{
    public interface ISafetyPreWarningRealTimePushDAL
    {
       AllSafetyWarningDatasModel GetAllSafetyDatas();
    }
}
