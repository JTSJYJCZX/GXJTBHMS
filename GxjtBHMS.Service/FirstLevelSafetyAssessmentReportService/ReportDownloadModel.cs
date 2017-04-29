using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using System.Collections.Generic;

namespace GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService
{
    public class ReportDownloadModel
    {
        List<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable> _exceptionRecordModels;
        FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable _resultsModel;
        FirstAssessment_FirstLevelSafetyAssessmentReportTable _reportModel;
        public ReportDownloadModel(
            List<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable> exceptionRecordModels,
            FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable resultsModel,
            FirstAssessment_FirstLevelSafetyAssessmentReportTable reportModel
            )
        {
            _exceptionRecordModels = exceptionRecordModels;
            _resultsModel = resultsModel;
            _reportModel = reportModel;
        }
        public IReadOnlyCollection<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable> ExceptionRecordModels
        {
            get
            {
                return _exceptionRecordModels.AsReadOnly();
            }
        }
        public FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable ResultsModel
        {
            get
            {
                return _resultsModel;
            }
        }
        public FirstAssessment_FirstLevelSafetyAssessmentReportTable ReportModel
        {
            get
            {
                return _reportModel;
            }
        }

        public int ExceptionRecordNumber
        {
            get
            {
                return _exceptionRecordModels.Count;
            }
        }

    }
}
