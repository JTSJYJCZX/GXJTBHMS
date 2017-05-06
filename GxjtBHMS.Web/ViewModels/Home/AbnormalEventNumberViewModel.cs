using System;

namespace GxjtBHMS.Web.ViewModels.Home
{
    public class AbnormalEventNumberViewModel
    {
        public int AbnormalEventNumber_SteelArchStrains { get; set; }
        public int AbnormalEventNumber_SteelLatticeStrains { get; set; }
        public int AbnormalEventNumber_ConcreteStrains { get; set; }
        public int AbnormalEventNumber_Displacements { get; set; }
        public int AbnormalEventNumber_CableForces { get; set; }
        public int AbnormalEventNumber_Temperatures { get; set; }
        public int AbnormalEventNumber_Humiditys { get; set; }
        public int AbnormalEventNumber_WindLoads { get; set; }

    }
}

