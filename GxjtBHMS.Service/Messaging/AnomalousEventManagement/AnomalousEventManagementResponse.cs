using GxjtBHMS.Service.ViewModels.AnomalousEventManagement;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.AnomalousEventManagement
{
    public class AnomalousEventManagementResponse : PagedResponse
    {
        public IEnumerable<AnomalousEventManagementModel> Datas { get; set; }
        
    }
}
