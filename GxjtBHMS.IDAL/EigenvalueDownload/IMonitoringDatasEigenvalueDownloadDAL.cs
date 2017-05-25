using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.IDAL
{
    public interface IMonitoringDatasEigenvalueDownloadDAL 
    {
        string DownLoadTxtByExec(ConditionParameters ps, string path,string ProcName);
    }
}
