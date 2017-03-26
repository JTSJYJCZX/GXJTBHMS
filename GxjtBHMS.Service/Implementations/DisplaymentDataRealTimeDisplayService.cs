using GxjtBHMS.Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using GxjtBHMS.IDAL;
using GxjtBHMS.Service.ExtensionMethods.GetEnumDescription;
using GxjtBHMS.Models.RealTimeMonitoringDatas;
using GxjtBHMS.Models.ThresholdValueSetting;

namespace GxjtBHMS.Service.Implementations
{
    public class DisplaymentDataRealTimeDisplayService : ServiceBase, IDisplaymentDataRealTimeDisplayService
    {
        IRealTimeDisplaymentDatasDAL _cddDAL;
        IMonitoringPointsNumberDAL _mpnDAL;
        IDisplaymentThresholdValueGettingDAL _dtvDAL;
        IMonitoringPointsPositionDAL _mppDAL;
        public DisplaymentDataRealTimeDisplayService(IRealTimeDisplaymentDatasDAL cddDAL, IMonitoringPointsNumberDAL mpnDAL, IDisplaymentThresholdValueGettingDAL dtvDAL, IMonitoringPointsPositionDAL mppDAL)
        {
            _cddDAL = cddDAL;
            _mpnDAL = mpnDAL;
            _dtvDAL = dtvDAL;
            _mppDAL = mppDAL;

        }
        public IEnumerable<IncludeSectionWarningColorDataModel> GetWarningDisplaymentDatasBy(int testTypeId)
        {
            List<IncludeSectionWarningColorDataModel> resultOfAllSection = new List<IncludeSectionWarningColorDataModel>();
            try
            {
                var sectionsId = _mppDAL.GetModelsByTestTypeId(testTypeId).Select(m => m.Id).ToArray();
                foreach (var item in sectionsId)
                {
                    IncludeSectionWarningColorDataModel resultOfOneSection = new IncludeSectionWarningColorDataModel();
                    var thresholdValue = _dtvDAL.GetDisplaymentThresholdValue(item).ToArray();
                    var source = _cddDAL.GetRealTimeDisplayments(item).ToArray();
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

        private IEnumerable<RealTimeWarningDataModel> GetResultsOfOneSection(DisplacementThresholdValueTable[] thresholdValue, RealTimeDisplaymentModel[] source)
        {
            List<RealTimeWarningDataModel> sectionModel = new List<RealTimeWarningDataModel>();
            //for (int i = 0; i < source.Length; i++)
            //{
            //    RealTimeWarningDataModel pointModel = new RealTimeWarningDataModel();
            //    pointModel.PointsNumber = source[i].PointNumberName;
            //    pointModel.CurrentData = source[i].DisplaymentDatas;
            //    pointModel.WarningGrade = GetPointWarningGrade(thresholdValue[i], source[i].DisplaymentDatas);
            //    pointModel.WarningColor = pointModel.WarningGrade.FetchDescription();
            //    sectionModel.Add(pointModel);
            //}
            return sectionModel;
        }

        //private WarningGrade GetPointWarningGrade(DisplaymentThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    if (IsHealth(pointThresholdValue, pointCurrentData))
        //    {
        //        return WarningGrade.Health;
        //    }
        //    else if (IsFirstWarning(pointThresholdValue, pointCurrentData))
        //    {
        //        return WarningGrade.FirstWarning;
        //    }
        //    else if (IsSecondWarning(pointThresholdValue, pointCurrentData))
        //    {
        //        return WarningGrade.SecondWarning;
        //    }
        //    else if (IsThirdWarning(pointThresholdValue, pointCurrentData))
        //    {
        //        return WarningGrade.Danger;
        //    }
        //    else
        //    {
        //        throw new ArgumentNullException("数据有误！");
        //    }
        //}

        //bool IsThirdWarning(DisplaymentThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    return pointCurrentData >= pointThresholdValue.PositiveThirdLevelThresholdValue || pointCurrentData <= pointThresholdValue.NegativeThirdLevelThresholdValue;
        //}

        //bool IsSecondWarning(DisplaymentThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    return (pointCurrentData < pointThresholdValue.PositiveThirdLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveSecondLevelThresholdValue) || (pointCurrentData > pointThresholdValue.NegativeThirdLevelThresholdValue && pointCurrentData <= pointThresholdValue.NegativeSecondLevelThresholdValue);
        //}

        //bool IsFirstWarning(DisplaymentThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    return (pointCurrentData < pointThresholdValue.PositiveSecondLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveFirstLevelThresholdValue) || (pointCurrentData > pointThresholdValue.NegativeSecondLevelThresholdValue && pointCurrentData <= pointThresholdValue.NegativeFirstLevelThresholdValue);
        //}

        //bool IsHealth(DisplaymentThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    return pointCurrentData < pointThresholdValue.PositiveFirstLevelThresholdValue && pointCurrentData > pointThresholdValue.NegativeFirstLevelThresholdValue;
        //}
    }
}

