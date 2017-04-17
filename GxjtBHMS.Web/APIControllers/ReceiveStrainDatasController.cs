using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Web.Models.ReceiveDatasModel;
using GxjtBHMS.Web.WebApiContext;
using System;
using System.Collections.Generic;
using System.Web.Http;

namespace GxjtBHMS.Web.APIControllers
{
    public class ReceiveStrainDatasController : ApiController
    {
        readonly WebAPIContext _ctx = new WebAPIContext();

        public void PostReceiveDatas(List<ReceiveStrainDatasModel> strainDatas)
        {
            if (ModelState.IsValid&&strainDatas!=null)
            {
                foreach (var item in strainDatas)
                {
                    Basic_ConcreteStrainTable  strainOfOnePoint = new Basic_ConcreteStrainTable ()
                    {
                        PointsNumberId = item.PointsNumberId,
                        Strain = item.Strain,
                        Temperature = item.Temperature,
                        Time = item.Time
                    };
                    _ctx.Strains.Add(strainOfOnePoint);
                  
                };
                _ctx.SaveChanges();
            }

        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _ctx.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
