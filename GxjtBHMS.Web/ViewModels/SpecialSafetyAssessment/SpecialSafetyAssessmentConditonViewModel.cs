using System;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.SpecialSafetyAssessment
{
    public class SpecialSafetyAssessmentConditonViewModel
    {
        //报告名称期数
        public string UpLoadReportPeriods { get; set; }
        //报告
        public byte UpLoadReport { get; }
        //报告生成时间
        public DateTime UpLoadReportTime { get; set; }
        //上传文件的大小，供上传文件脚本判断大小用。
        public int  wordFileSize { get; set; }
    }
}