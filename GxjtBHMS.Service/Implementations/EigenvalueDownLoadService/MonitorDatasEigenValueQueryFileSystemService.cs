using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.SqlServerDAL;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace GxjtBHMS.Service.Implementations
{
    public  class MonitorDatasEigenValueQueryFileSystemService<T>:IMonitorDatasQueryFileSystemService<T> where T: MonitoringDatasEigenvalueModel
    {
        protected const string Separator = "|";
        readonly IMonitoringDatasEigenvalueDAL<T> _monitoringDatasDAL;
        public MonitorDatasEigenValueQueryFileSystemService(IMonitoringDatasEigenvalueDAL<T> monitoringDatasDAL)
        {
            _monitoringDatasDAL = monitoringDatasDAL;
        }
        public void ConvertToDocument(IList<Func<T, bool>> ps,string filePath)
        {
            IEnumerable<T> datas = new List<T>();
            datas = _monitoringDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            if (!string.IsNullOrEmpty(filePath))
            {
                using (FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.ReadWrite))
                {
                    using (StreamWriter sw = new StreamWriter(fs, Encoding.UTF8))
                    {
                        CreateHeader(sw);
                        CreateBody(sw, datas);
                        sw.Flush();
                        sw.Close();
                        fs.Close();
                    }
                }
            }
        }

        private void CreateBody(StreamWriter sw, IEnumerable<T> datas)
        {
            foreach (var item in datas)
            {
                sw.WriteLine(string.Concat( item.PointsNumber.Name,Separator,item.Time,Separator,item.Max,Separator,item.Min,Separator,item.Average));
            }
        }

        private void CreateHeader(StreamWriter sw)
        {
            string header = string.Concat("测点编号", Separator, "监测时间", Separator, "最大值", Separator, "最小值", Separator, "平均值");
            sw.WriteLine(header);
        }
    }
}
