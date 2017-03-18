using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.IDAL;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Linq;
using GxjtBHMS.Service.ExtensionMethods.GetEnumDescription;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Models.RealTimeMonitoringDatas;

namespace GxjtBHMS.Service.Implementations
{
    public class StrainDataRealTimeDisplayService : ServiceBase, IStrainDataRealTimeDisplayService
    {
        IRealTimeStrainDatasDAL _csdDAL;
        IMonitoringPointsNumberDAL _mpnDAL;
        IStrainThresholdValueGettingDAL _stvDAL;
        IMonitoringPointsPositionDAL _mppDAL;
        public StrainDataRealTimeDisplayService(IRealTimeStrainDatasDAL csdDAL, IMonitoringPointsNumberDAL mpnDAL, IStrainThresholdValueGettingDAL stvDAL, IMonitoringPointsPositionDAL mppDAL)
        {
            _csdDAL = csdDAL;
            _mpnDAL = mpnDAL;
            _stvDAL = stvDAL;
            _mppDAL = mppDAL;

        }


        public IEnumerable<IncludeSectionWarningColorDataModel> GetWarningStrainDatasBy(int testTypeId)
        {
            List<IncludeSectionWarningColorDataModel> resultOfAllSection = new List<IncludeSectionWarningColorDataModel>();
            try
            {
                var sectionsId = _mppDAL.GetModelsByTestTypeId(testTypeId).Select(m => m.Id).ToArray();
                foreach (var item in sectionsId)
                {
                    IncludeSectionWarningColorDataModel resultOfOneSection = new IncludeSectionWarningColorDataModel();
                    var thresholdValue = _stvDAL.GetStrainThresholdValue(item).ToArray();
                    var source = _csdDAL.GetRealTimeStrains(item).ToArray();
                    resultOfOneSection.WarningRealTimeData = GetResultsOfOneSection(thresholdValue, source);
                    resultOfOneSection.SectionWarningGrade = resultOfOneSection.WarningRealTimeData.Select(m => m.WarningGrade).Max();
                    resultOfOneSection.SectionWarningColor = resultOfOneSection.SectionWarningGrade.FetchDescription();
                    resultOfAllSection.Add(resultOfOneSection);
                }          
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return resultOfAllSection;
        }

        private List<RealTimeWarningDataModel> GetResultsOfOneSection(StrainThresholdValueTable[] thresholdValue, RealTimeStrainModel[] source)
        {
            List<RealTimeWarningDataModel> sectionModel = new List<RealTimeWarningDataModel>();
            for (int i = 0; i < source.Length; i++)
            {
                RealTimeWarningDataModel pointModel = new RealTimeWarningDataModel();
                pointModel.PointsNumber = source[i].PointNumberName;
                pointModel.CurrentData = source[i].StrainDatas;
                pointModel.WarningGrade = GetPointWarningGrade(thresholdValue[i], source[i].StrainDatas);
                pointModel.WarningColor = pointModel.WarningGrade.FetchDescription();
                sectionModel.Add(pointModel);
            }
            return sectionModel;
        }

        private WarningGrade GetPointWarningGrade(StrainThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            if (IsHealth(pointThresholdValue, pointCurrentData))
            {
                return WarningGrade.Health;
            }
            else if (IsFirstWarning(pointThresholdValue, pointCurrentData))
            {
                return WarningGrade.FirstWarning;
            }
            else if (IsSecondWarning(pointThresholdValue, pointCurrentData))
            {
                return WarningGrade.SecondWarning;
            }
            else if (IsThirdWarning(pointThresholdValue, pointCurrentData))
            {
                return WarningGrade.Danger;
            }
            else
            {
                throw new ArgumentNullException("数据有误！");
            }
        }

        bool IsThirdWarning(StrainThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            return pointCurrentData >= pointThresholdValue.PositiveThirdLevelThresholdValue || pointCurrentData <= pointThresholdValue.NegativeThirdLevelThresholdValue;
        }

        bool IsSecondWarning(StrainThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            return (pointCurrentData < pointThresholdValue.PositiveThirdLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveSecondLevelThresholdValue) || (pointCurrentData > pointThresholdValue.NegativeThirdLevelThresholdValue && pointCurrentData <= pointThresholdValue.NegativeSecondLevelThresholdValue);
        }

        bool IsFirstWarning(StrainThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            return (pointCurrentData < pointThresholdValue.PositiveSecondLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveFirstLevelThresholdValue) || (pointCurrentData > pointThresholdValue.NegativeSecondLevelThresholdValue && pointCurrentData <= pointThresholdValue.NegativeFirstLevelThresholdValue);
        }

        bool IsHealth(StrainThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            return pointCurrentData < pointThresholdValue.PositiveFirstLevelThresholdValue && pointCurrentData > pointThresholdValue.NegativeFirstLevelThresholdValue;
        }
    }
}
