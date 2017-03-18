using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Web.WebApiContext
{
    public class WebAPIContext : DbContext
    {
        static readonly string ConnectionName;

        public WebAPIContext() : base(ConnectionName) { }
        static WebAPIContext()
        {
            ConnectionName = ApplicationSettingsFactory.GetApplicationSettings().DBConnectionName;
        }

        public DbSet<ConcreteStrainTable> Strains { get; set; }//应变
        public DbSet<DisplacementTable> Displayments { get; set; }//位移
        public DbSet<CableForceTable> CableForces { get; set; }//索力
        public DbSet<TemperatureTable> Temperatures { get; set; }//温度 
        public DbSet<HumidityTable> Humiditys { get; set; }//湿度 

    }
}