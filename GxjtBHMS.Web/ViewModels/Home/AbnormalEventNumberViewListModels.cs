using System;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.Home
{
    public class AbnormalEventNumberViewListModels
    {    
        public AbnormalEventNumberViewListModels()
        {
            AbnormalEventNumberViewModels = new List<AbnormalEventNumberViewModel>();
        }
        public IEnumerable<AbnormalEventNumberViewModel> AbnormalEventNumberViewModels;



    }
}

