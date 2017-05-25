using GxjtBHMS.Models;

namespace GxjtBHMS.IDAL.OriginalValueDownLoad
{
    public interface IOriginalDatasDownloadDAL
    {
        string DownLoadTxtByExec(ConditionParameters ps, string path,string procedure_Name);
    }
}
