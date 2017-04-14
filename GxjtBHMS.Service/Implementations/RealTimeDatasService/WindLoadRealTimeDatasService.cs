using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.IDAL;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Linq;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models;

namespace GxjtBHMS.Service.Implementations
{
    public class WindLoadRealTimeDatasService : ServiceBase, IWindLoadRealTimeDatasService
    {
        IWindLoadRealTimeDatasDAL _wldDAL;
        IMonitoringPointsNumberDAL _mpnDAL;
        IMonitoringPointsPositionDAL _mppDAL;
        public WindLoadRealTimeDatasService(IWindLoadRealTimeDatasDAL wldDAL, IMonitoringPointsNumberDAL mpnDAL, IMonitoringPointsPositionDAL mppDAL)
        {
            _wldDAL = wldDAL;
            _mpnDAL = mpnDAL;
            _mppDAL = mppDAL;

        }


        public IEnumerable<IncludeSectionWarningColorDataModel> GetWarningWindLoadDatasBy(IEnumerable<int> sectionIds)
        {
            List<IncludeSectionWarningColorDataModel> resultOfAllSection = new List<IncludeSectionWarningColorDataModel>();
            try
            {
                foreach (var item in sectionIds)
                {
                    IncludeSectionWarningColorDataModel resultOfOneSection = new IncludeSectionWarningColorDataModel();
                    var source = _wldDAL.GetRealTimeWindLoad(item).ToArray();
                    resultOfOneSection.WarningRealTimeData = GetResultsOfOneSection(source);
                    var maxGrade = resultOfOneSection.WarningRealTimeData.Select(m=>m.WarningGrade).Max();
                    resultOfOneSection.SectionWarningColor = resultOfOneSection.WarningRealTimeData.Where(m=>m.WarningGrade== maxGrade).Select(m=>m.WarningColor).First();
                    resultOfAllSection.Add(resultOfOneSection);
                }          
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return resultOfAllSection;
        }

        private List<RealTimeWarningDataModel> GetResultsOfOneSection(WindLoadTable[] source)
        {
            List<RealTimeWarningDataModel> sectionModel = new List<RealTimeWarningDataModel>();
            for (int i = 0; i < source.Length; i++)
            {
                RealTimeWarningDataModel pointModel = new RealTimeWarningDataModel();
                pointModel.PointsNumber = source[i].PointsNumber.Name;
                pointModel.CurrentData = source[i].WindSpeed;
                pointModel.WarningColor = source[i].ThresholdGrade.ThresholdColor;
                pointModel.WarningGrade = source[i].ThresholdGradeId;
                sectionModel.Add(pointModel);
            }
            return sectionModel;
        }

        public IEnumerable<int> GetSectionIdsBy(int testTypeId)
        {
            return _mppDAL.GetModelsByTestTypeId(testTypeId).Select(m => m.Id);
        }

        
    }
}
