using GxjtBHMS.IDAL;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging;
using System.Text;
using System.Threading.Tasks;
using GxjtBHMS.Models.AbnormalThresholdValueSetting;
using System.Linq;
using GxjtBHMS.Service.Messaging.AbnomalThresholdValueSetting;

namespace GxjtBHMS.Service.AbnomalThresholdValueService
{
   public class AbnormalThresholdValueSettingService: ServiceBase
    {
        IAbnormalThresholdValueSettingDAL _abnormalThresholdValueSettingDAL;
        public AbnormalThresholdValueSettingService()
        {
            _abnormalThresholdValueSettingDAL = new NinjectFactory()
                 .GetInstance<IAbnormalThresholdValueSettingDAL>();
        }

        public AbnormalThresholdValueResponse GetAbnormalThresholdValueList()
        {
            var resp = new AbnormalThresholdValueResponse();
            try
            {
              IEnumerable <AbnormalThresholdValueTable> source = _abnormalThresholdValueSettingDAL.FindAll(); ;
                              
                if (HasNoSearchResult(source))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.AbnormalThresholdValue = source;
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
        /// <summary>
        /// 判断是否有记录
        /// </summary>
        /// <param name="thresholdValues"></param>
        /// <returns></returns>
        protected bool HasNoSearchResult(IEnumerable<AbnormalThresholdValueTable> abnormalThresholdValues)
        {
            return abnormalThresholdValues.Count() == 0;
        }

        public AbnormalThresholdValueResponse ModifyAbnormalThresholdValue(AbnormalThresholdValueSettingRequest req)
        {
            var resp = new AbnormalThresholdValueResponse();
            try
            {
                var abnormalThresholdValues = ModifyAbnormalThresholdValueByTypeId(req);
                abnormalThresholdValues.MaxLevelThresholdValue = req.MaxLevelThresholdValue;
                abnormalThresholdValues.MinLevelThresholdValue = req.MinLevelThresholdValue;
                SaveThresholdValueByPointsNumberId(abnormalThresholdValues);
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

        /// <summary>
        /// 通过测点编号Id修改阈值
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        public AbnormalThresholdValueTable ModifyAbnormalThresholdValueByTypeId(AbnormalThresholdValueSettingRequest req)
        {
            IList<Func<AbnormalThresholdValueTable, bool>> ps = new List<Func<AbnormalThresholdValueTable, bool>>();
            DealWithEqualTypeId(req, ps);
            return _abnormalThresholdValueSettingDAL.FindBy(ps).SingleOrDefault();
        }

        /// <summary>
        /// 处理测试截面查询条件
        /// </summary>
        /// <param name="req"></param>
        /// <param name="ps"></param>
        void DealWithEqualTypeId(AbnormalThresholdValueSettingRequest req, IList<Func<AbnormalThresholdValueTable, bool>> ps)
        {
            if (req.TypeId > 0)
            {
                ps.Add(m => m.Id == req.TypeId);
            }
        }

        /// <summary>
        /// 保存阈值
        /// </summary>
        /// <param name="AbnormalThresholdValue"></param>
        public void SaveThresholdValueByPointsNumberId(AbnormalThresholdValueTable AbnormalThresholdValue)
        {
            _abnormalThresholdValueSettingDAL.Save(AbnormalThresholdValue);
        }
    }
}
