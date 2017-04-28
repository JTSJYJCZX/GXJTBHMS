using System;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.SecondLevelSafetyAssessment
{
    public class SecondLevelSafetyAssessmentConditonViewModel
    {
        //报告名称期数
        public string UpLoadReportPeriods { get; set; }
        //报告
        public byte UpLoadReport { get; }
        //报告生成时间
        public DateTime UpLoadReportTime { get; set; }
        //评估结果
        public int UpLoadAssessmentResultGrade { get; set; }
        //评估状态
        public string UpLoadAssessmentState { get; set; }
        //上传文件的大小，供上传文件脚本判断大小用。
        public int  wordFileSize { get; set; }
    }
}