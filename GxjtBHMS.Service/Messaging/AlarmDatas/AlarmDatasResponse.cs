using GxjtBHMS.Service.ViewModels.AlarmDatasModel;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.AlarmDatas
{
    public class AlarmDatasResponse: PagedResponse
    {
        public IEnumerable<AlarmDatasModel> Datas { get; set; }
        
    }
}
