using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace GxjtBHMS.Service.Implementations
{
    abstract class MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase<T> : IMonitorDatasQueryFileSystemService<T> where T : MonitorDatasQueryConditionsModel
    {
        protected const string Separator = "|";
        protected IReadOnlyRepository<T, int> _dal;
        public MonitorDatasOriginalValueDownloadPlainTextFileSystemTxtServiceBase(IReadOnlyRepository<T, int> dal)
        {
            _dal = dal;
        }

        public void ConvertToDocument(IList<Func<T, bool>> ps, string filePath)
        {
            if (!string.IsNullOrEmpty(filePath))
            {
                using (FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.ReadWrite))
                {
                    using (StreamWriter sw = new StreamWriter(fs, Encoding.UTF8))
                    {
                        var datas = GetDataSource(ps);
                        CreateHeader(sw);
                        CreateBody(sw, datas);
                        sw.Flush();
                        sw.Close();
                        fs.Close();
                    }
                }
            }
        }

        protected virtual void CreateHeader(StreamWriter sw)
        {
            string defaultHead = string.Concat( "测点编号", Separator, "监测时间");
            sw.WriteLine(GetHeader(defaultHead));
        }

        abstract protected string GetHeader(string defaultHead);

        abstract protected void CreateBody(StreamWriter sw, IEnumerable<T> alldatas);

        abstract protected IEnumerable<T> GetDataSource(IList<Func<T, bool>> ps);
    }
}
