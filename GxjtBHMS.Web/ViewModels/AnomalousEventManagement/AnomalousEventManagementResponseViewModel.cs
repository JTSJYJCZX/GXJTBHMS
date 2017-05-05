using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Service.Messaging;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.AnomalousEventManagement
{
    public class AnomalousEventManagementResponseViewModel: ResponseBase
    {
        public IEnumerable<AnomalousEventManagementViewModel> Datas { get; set; }
        public long TotalPages
        {
            get
            {
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;
                return TotalResultCount % numberOfResultsPrePage == 0 ? TotalResultCount / numberOfResultsPrePage : TotalResultCount / numberOfResultsPrePage + 1;
            }
        }
        public long TotalResultCount { get; set; }
        public int CurrentPage { get; set; }
    }
}