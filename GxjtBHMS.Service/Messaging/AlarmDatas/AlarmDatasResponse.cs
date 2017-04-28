using GxjtBHMS.Service.ViewModels.AlarmDatasModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Service.Messaging.AlarmDatas
{
    public class AlarmDatasResponse: PagedResponse
    {
        public IEnumerable<AlarmDatasModel> Datas { get; set; }
        
    }
}
