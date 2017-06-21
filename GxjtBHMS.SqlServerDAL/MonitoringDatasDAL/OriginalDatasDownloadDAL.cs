using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.IDAL.OriginalValueDownLoad;

namespace GxjtBHMS.SqlServerDAL.MonitoringDatasDAL
{
    public class OriginalDatasDownloadDAL : IOriginalDatasDownloadDAL
    {
        public string DownLoadTxtByExec(ConditionParameters ps, string path, string procedure_Name)
        {
            string returnPath = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings[ApplicationSettingsFactory.GetApplicationSettings().DBConnectionName].ConnectionString;//获得Web.config中的连接字符串
           
            using (SqlConnection conStr = new SqlConnection(connectionString))//SQL数据库连接对象，以数据库链接字符串为参数
            {
                SqlCommand comStr = new SqlCommand(procedure_Name, conStr);//SQL语句执行对象，第一个参数是要执行的语句，第二个是数据库连接对象
                comStr.CommandType = CommandType.StoredProcedure;//因为要使用的是存储过程，所以设置执行类型为存储过程
                //依次设定存储过程的参数
                for (int i = 0; i < ps.PointsNumberIds.Length; i++)
                {
                    string para = string.Concat("@MPN", i + 1);
                    comStr.Parameters.Add(para, SqlDbType.Int).Value = ps.PointsNumberIds[i];
                }
                comStr.Parameters.Add("@StartTime", SqlDbType.DateTime).Value = ps.StarTime;
                comStr.Parameters.Add("@EndTime", SqlDbType.DateTime).Value = ps.EndTime;
                comStr.Parameters.Add("@filePath_name", SqlDbType.VarChar, 8000).Value = path;
                //定义一个输出参数，不需赋值。Direction用来描述参数的类型
                //Direction默认为输入参数，还有输出参数和返回值型。
                SqlParameter txtPath = comStr.Parameters.Add("@TxtPath", SqlDbType.VarChar, 8000);
                txtPath.Direction = ParameterDirection.Output;
                conStr.Open();//打开数据库连接
                comStr.ExecuteNonQuery().ToString();//执行存储过程
                returnPath = comStr.Parameters["@TxtPath"].Value.ToString();//在执行完存储过程之后，可得到输出参数 
            }
            return returnPath;
        }
    }
}
