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

        public DbSet<Basic_ConcreteStrainTable > Strains { get; set; }//应变
        public DbSet<Basic_DisplacementTable> Displayments { get; set; }//位移
        public DbSet<Basic_CableForceTable> CableForces { get; set; }//索力
        public DbSet<Basic_TemperatureTable> Temperatures { get; set; }//温度 
        public DbSet<Basic_HumidityTable> Humiditys { get; set; }//湿度 

    }
}