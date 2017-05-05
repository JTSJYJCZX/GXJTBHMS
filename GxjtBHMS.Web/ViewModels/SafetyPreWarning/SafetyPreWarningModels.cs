using GxjtBHMS.Service.Messaging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Web.ViewModels.SafetyPreWarning
{
    public class SafetyPreWarningModels:ResponseBase
    {
        public SafetyPreWarningModels()
        {
            SafetyPreWarnings = new List<SafetyPreWarningViewModel>();
        }
        public IEnumerable<SafetyPreWarningViewModel> SafetyPreWarnings;
    }
}