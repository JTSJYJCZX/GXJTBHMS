using GxjtBHMS.IDAL;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging;
using System.Text;
using System.Threading.Tasks;
using GxjtBHMS.Models.AbnormalThresholdValueSetting;
using System.Linq;

namespace GxjtBHMS.Service.AbnomalThresholdValueService
{
   public class AbnomalThresholdValueSettingService: ServiceBase
    {
        IAbnomalThresholdValueSettingDAL _abnomalThresholdValueSettingDAL;
        public AbnomalThresholdValueSettingService()
        {
            _abnomalThresholdValueSettingDAL = new NinjectFactory()
                 .GetInstance<IAbnomalThresholdValueSettingDAL>();
        }

        public AbnomalThresholdValueResponse GetAbnomalThresholdValueList()
        {
            var resp = new AbnomalThresholdValueResponse();
            try
            {
              IEnumerable <AbnormalThresholdValueTable> source = _abnomalThresholdValueSettingDAL.FindAll(); ;
                              
                if (HasNoSearchResult(source))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.AbnomalThresholdValue = source;
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

    }
}
