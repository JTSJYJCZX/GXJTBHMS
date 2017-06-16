using GxjtBHMS.IDAL.SafetyPreWarning;
using GxjtBHMS.Infrastructure;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace GxjtBHMS.SqlServerDAL.SafetyPreWarningDAL
{

    public class SafetyPreWarningRealTimePushDAL : ISafetyPreWarningRealTimePushDAL
    {
        public AllSafetyWarningDatasModel GetAllSafetyDatas()
        {
            string connectionString = ConfigurationManager.ConnectionStrings[ApplicationSettingsFactory.GetApplicationSettings().DBConnectionName].ConnectionString;//获得Web.config中的连接字符串
            AllSafetyWarningDatasModel models = new AllSafetyWarningDatasModel();
            using (SqlConnection conStr = new SqlConnection(connectionString))//SQL数据库连接对象，以数据库链接字符串为参数
            {
                SqlCommand comStr = new SqlCommand(AppConstants.SafetyWarningRealTimeProc, conStr);//SQL语句执行对象，第一个参数是要执行的语句，第二个是数据库连接对象
                comStr.CommandType = CommandType.StoredProcedure;//因为要使用的是存储过程，所以设置执行
                SqlParameter preFirstAssessmentReportTime = comStr.Parameters.Add("@preFirstAssessmentReportTime", SqlDbType.DateTime);
                preFirstAssessmentReportTime.Direction = ParameterDirection.Output;

                SqlParameter totalSafetyWarningResult = comStr.Parameters.Add("@totalSafetyWarningResult", SqlDbType.VarChar, 8000);
                totalSafetyWarningResult.Direction = ParameterDirection.Output;

                SqlParameter totalSafetyWarningColor = comStr.Parameters.Add("@totalSafetyWarningColor", SqlDbType.VarChar, 8000);
                totalSafetyWarningColor.Direction = ParameterDirection.Output;

                SqlParameter cableForceSafetyWarningResult = comStr.Parameters.Add("@cableForceSafetyWarningResult", SqlDbType.VarChar, 8000);
                cableForceSafetyWarningResult.Direction = ParameterDirection.Output;

                SqlParameter cableForceSafetyWarningColor = comStr.Parameters.Add("@cableForceSafetyWarningColor", SqlDbType.VarChar, 8000);
                cableForceSafetyWarningColor.Direction = ParameterDirection.Output;

                SqlParameter cableForceRedWarningTimes = comStr.Parameters.Add("@cableForceRedWarningTimes", SqlDbType.Int);
                cableForceRedWarningTimes.Direction = ParameterDirection.Output;

                SqlParameter cableForceYellowWarningTimes = comStr.Parameters.Add("@cableForceYellowWarningTimes", SqlDbType.Int);
                cableForceYellowWarningTimes.Direction = ParameterDirection.Output;

                SqlParameter displacementSafetyWarningResult = comStr.Parameters.Add("@displacementSafetyWarningResult", SqlDbType.VarChar, 8000);
                displacementSafetyWarningResult.Direction = ParameterDirection.Output;

                SqlParameter displacementSafetyWarningColor = comStr.Parameters.Add("@displacementSafetyWarningColor", SqlDbType.VarChar, 8000);
                displacementSafetyWarningColor.Direction = ParameterDirection.Output;

                SqlParameter displacementRedWarningTimes = comStr.Parameters.Add("@displacementRedWarningTimes", SqlDbType.Int);
                displacementRedWarningTimes.Direction = ParameterDirection.Output;

                SqlParameter displacementYellowWarningTimes = comStr.Parameters.Add("@displacementYellowWarningTimes", SqlDbType.Int);
                displacementYellowWarningTimes.Direction = ParameterDirection.Output;

                SqlParameter windLoadSafetyWarningResult = comStr.Parameters.Add("@windLoadSafetyWarningResult", SqlDbType.VarChar, 8000);
                windLoadSafetyWarningResult.Direction = ParameterDirection.Output;

                SqlParameter windLoadSafetyWarningColor = comStr.Parameters.Add("@windLoadSafetyWarningColor", SqlDbType.VarChar, 8000);
                windLoadSafetyWarningColor.Direction = ParameterDirection.Output;

                SqlParameter windLoadRedWarningTimes = comStr.Parameters.Add("@windLoadRedWarningTimes", SqlDbType.Int);
                windLoadRedWarningTimes.Direction = ParameterDirection.Output;

                SqlParameter windLoadYellowWarningTimes = comStr.Parameters.Add("@windLoadYellowWarningTimes", SqlDbType.Int);
                windLoadYellowWarningTimes.Direction = ParameterDirection.Output;

                SqlParameter temperatureSafetyWarningResult = comStr.Parameters.Add("@temperatureSafetyWarningResult", SqlDbType.VarChar, 8000);
                temperatureSafetyWarningResult.Direction = ParameterDirection.Output;

                SqlParameter temperatureSafetyWarningColor = comStr.Parameters.Add("@temperatureSafetyWarningColor", SqlDbType.VarChar, 8000);
                temperatureSafetyWarningColor.Direction = ParameterDirection.Output;

                SqlParameter temperatureRedWarningTimes = comStr.Parameters.Add("@temperatureRedWarningTimes", SqlDbType.Int);
                temperatureRedWarningTimes.Direction = ParameterDirection.Output;

                SqlParameter temperatureYellowWarningTimes = comStr.Parameters.Add("@temperatureYellowWarningTimes", SqlDbType.Int);
                temperatureYellowWarningTimes.Direction = ParameterDirection.Output;

                conStr.Open();//打开数据库连接
                comStr.ExecuteNonQuery().ToString();//执行存储过程


                models.PreFirstAssessmentReportTime = comStr.Parameters["@preFirstAssessmentReportTime"].Value.ToString();//在执行完存储过程之后，可得到输出参数 
                models.TotalSafetyPreWarningState = comStr.Parameters["@totalSafetyWarningResult"].Value.ToString();
                models.TotalSafetyPreWarningColor = comStr.Parameters["@totalSafetyWarningColor"].Value.ToString();
                models.CableForceSafetyPreWarningState = comStr.Parameters["@cableForceSafetyWarningResult"].Value.ToString();
                models.CableForceSafetyPreWarningColor = comStr.Parameters["@cableForceSafetyWarningColor"].Value.ToString();
                models.CableForceWarningGrade3Times = Convert.ToInt32(comStr.Parameters["@cableForceRedWarningTimes"].Value);
                models.CableForceWarningGrade2Times = Convert.ToInt32(comStr.Parameters["@cableForceYellowWarningTimes"].Value);
                models.DisplacementSafetyPreWarningState = comStr.Parameters["@displacementSafetyWarningResult"].Value.ToString();
                models.DisplacementSafetyPreWarningColor = comStr.Parameters["@displacementSafetyWarningColor"].Value.ToString();
                models.DisplacementWarningGrade3Times = Convert.ToInt32(comStr.Parameters["@displacementRedWarningTimes"].Value);
                models.DisplacementWarningGrade2Times = Convert.ToInt32(comStr.Parameters["@displacementYellowWarningTimes"].Value);
                models.WindLoadSafetyPreWarningState = comStr.Parameters["@windLoadSafetyWarningResult"].Value.ToString();
                models.WindLoadSafetyPreWarningColor = comStr.Parameters["@windLoadSafetyWarningColor"].Value.ToString();
                models.WindLoadWarningGrade3Times = Convert.ToInt32(comStr.Parameters["@windLoadRedWarningTimes"].Value);
                models.WindLoadWarningGrade2Times = Convert.ToInt32(comStr.Parameters["@windLoadYellowWarningTimes"].Value);
                models.TemperatureSafetyPreWarningState = comStr.Parameters["@temperatureSafetyWarningResult"].Value.ToString();
                models.TemperatureSafetyPreWarningColor = comStr.Parameters["@temperatureSafetyWarningColor"].Value.ToString();
                models.TemperatureWarningGrade3Times = Convert.ToInt32(comStr.Parameters["@temperatureRedWarningTimes"].Value);
                models.TemperatureWarningGrade2Times = Convert.ToInt32(comStr.Parameters["@temperatureYellowWarningTimes"].Value);
            }
            return models;
        }
    }
}

