using GxjtBHMS.Infrastructure.Configuration;

namespace GxjtBHMS.Service.Messaging
{
    public class PagedResponse : ResponseBase
    {
        public long TotalPages
        {
            get
            {
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;
                return TotalResultCount % numberOfResultsPrePage == 0 ? TotalResultCount / numberOfResultsPrePage : TotalResultCount / numberOfResultsPrePage + 1;
            }
        }
        public long TotalResultCount { get; set; }
    }
}
