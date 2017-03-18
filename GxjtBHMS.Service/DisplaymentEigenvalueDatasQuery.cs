﻿using System;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class DisplaymentEigenvalueDatasQuery : MonitoringDatasEigenvalueQueryServiceBase
    {
        readonly IDisplaymentDatasEigenvalueQueryService _displaymentDatasService;

        public DisplaymentEigenvalueDatasQuery()
        {
            _displaymentDatasService = new NinjectFactory()
                .GetInstance<IDisplaymentDatasEigenvalueQueryService>();
        }

        public override ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            return _displaymentDatasService.GetChartDatasBy(req);
        }




        public override PagedResponse GetPaginatorDatas(DatasQueryResultRequest req)
        {
            var resp = new PagedResponse();

            try
            {
                resp.TotalResultCount = _displaymentDatasService.GetTotalResultCountBy(req);
                if (resp.TotalResultCount > 0)
                {
                    resp.Succeed = true;
                }
                else
                {
                    resp.Message = "无记录";
                }
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return resp;
        }

        public override DownLoadDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _displaymentDatasService.SaveAs(req);
        }
    }
}