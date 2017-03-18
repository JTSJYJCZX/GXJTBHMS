using System;
using GxjtBHMS.IDAL;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System.Linq;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using GxjtBHMS.Infrastructure.Configuration;

namespace GxjtBHMS.Service.Implementations
{
    public class ThresholdValueSettingService : ServiceBase, IThresholdValueSettingService
    {
        const string PointsNumber_NavigationProperty = "PointsNumber";
        IThresholdValueSettingDAL _thresholdValueSettingDAL;
        public ThresholdValueSettingService(IThresholdValueSettingDAL thresholdValueSettingDAL)
        {
            _thresholdValueSettingDAL = thresholdValueSettingDAL;
        }


        public PagedResponse GetPaginatorDatas(PointsNumberSearchRequest req)
        {
            var resp = new PagedResponse();
            IList<Func<StrainThresholdValueTable, bool>> ps = new List<Func<StrainThresholdValueTable, bool>>();
            try
            {
                DealWithContainsPointsNumber(req, ps);
                resp.TotalResultCount = _thresholdValueSettingDAL.GetCountByContains(ps);
                if (resp.TotalResultCount > 0)
                {
                    resp.Succeed = true;
                }
                else
                {
                    resp.Message = "无记录！";
                }
            }
            catch (Exception ex)
            {
                resp.Message = "获取分页数据发生错误";
                Log(ex);
            }
            return resp;
        }

        void DealWithContainsPointsNumber(PointsNumberSearchRequest req, IList<Func<StrainThresholdValueTable, bool>> ps)
        {
            if (!string.IsNullOrEmpty(req.PointNumber))
            {
                ps.Add(m => m.PointsNumber.Name.Contains(req.PointNumber));
            }
        }

        StrainThresholdValueResponse IThresholdValueSettingService.GetThresholdValueBy(PointsNumberSearchRequest req)
        {
            var resp = new StrainThresholdValueResponse();
            IList<Func<StrainThresholdValueTable, bool>> ps = new List<Func<StrainThresholdValueTable, bool>>();
            var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;
            try
            {
                DealWithContainsPointsNumber(req, ps);
                var thresholdValues = _thresholdValueSettingDAL.FindBy(ps, req.CurrentPageIndex, numberOfResultsPrePage, PointsNumber_NavigationProperty);
                if (HasNoSearchResult(thresholdValues))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.TotalResultCount = _thresholdValueSettingDAL.GetCountByContains(ps, PointsNumber_NavigationProperty);
                    resp.StrainThresholdValues = thresholdValues;
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                resp.Message = "搜索阈值列表信息发生错误！";
                Log(ex);
            }
            return resp;
        }

        bool HasNoSearchResult(IEnumerable<StrainThresholdValueTable> thresholdValues)
        {
            return thresholdValues.Count() == 0;
        }

        StrainThresholdValueResponse IThresholdValueSettingService.ModifyStrainThresholdValue(StrainThresholdValueSettingRequest model)
        {
            var resp = new StrainThresholdValueResponse();
            try
            {
                var ThresholdValue = _thresholdValueSettingDAL.FindBy(m => m.PointsNumberId == model.PointsNumberId).SingleOrDefault();
                ThresholdValue.PositiveStandardValue = model.PositiveStandardValue;
                ThresholdValue.PositiveFirstLevelThresholdValue = model.PositiveFirstLevelThresholdValue;
                ThresholdValue.PositiveSecondLevelThresholdValue = model.PositiveSecondLevelThresholdValue;
                ThresholdValue.PositiveThirdLevelThresholdValue = model.PositiveThirdLevelThresholdValue;
                ThresholdValue.NegativeStandardValue = model.NegativeStandardValue;
                ThresholdValue.NegativeFirstLevelThresholdValue = model.NegativeFirstLevelThresholdValue;
                ThresholdValue.NegativeSecondLevelThresholdValue = model.NegativeSecondLevelThresholdValue;
                ThresholdValue.NegativeThirdLevelThresholdValue = model.NegativeThirdLevelThresholdValue;
                _thresholdValueSettingDAL.Save(ThresholdValue);
                resp.Message = "保存成功！";
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "阈值保存失败！";
                Log(ex);
            }
            return resp;
        }
    }
}