﻿using System;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using System.Linq;
using System.Collections.Generic;
using GxjtBHMS.Models;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.SqlServerDAL;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.Service.Implementations
{
    public class CableForceDatasEigenvalueQueryService : MonitorDatasEigenvalueQueryServiceBase<CableForceEigenValueTable>, ICableForceDatasEigenvalueQueryService
    {
        readonly ICableForceDatasEigenvalueDAL  _cableForceDatasDAL;

        public CableForceDatasEigenvalueQueryService(
            ICableForceDatasEigenvalueDAL  cableForceDatasDAL,
            IMonitorDatasEigenvalueQueryChartService<CableForceEigenValueTable> chartService,
            IMonitorDatasQueryFileSystemService<CableForceEigenValueTable> fileSystemService
            ) : base(chartService, fileSystemService)
        {
            _cableForceDatasDAL = cableForceDatasDAL;
        }


        public ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {
            var resp = new ChartDatasResponse();
            IList<Func<CableForceEigenValueTable, bool>> ps = new List<Func<CableForceEigenValueTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                resp.Datas = _chartService.GetChartDataSourceBy(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = ex.Message;
                Log(ex);
            }
            return resp;
        }

       

         public DownLoadDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownLoadDatasResponse();
            IList<Func<CableForceEigenValueTable, bool>> ps = new List<Func<CableForceEigenValueTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
               resp.Datas= _fileSystemService.ConvertToDocument(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "无法下载数据";
                Log(ex);
            }
            return resp;
        }

        public long GetTotalResultCountBy(DatasQueryResultRequest req)
        {
            IList<Func<CableForceEigenValueTable, bool>> ps = new List<Func<CableForceEigenValueTable, bool>>();
            DealWithConditions(req, ps);
            return _cableForceDatasDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }
    }
}



