﻿using System;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Service.MonitoringDatasQueryService;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using System.Collections.Generic;
using GxjtBHMS.Service.Interfaces.MonitoringDatasQueryServiceInerfaces;

namespace GxjtBHMS.Service
{
    class CableForceEigenvalueDatasQuery : MonitorDatasEigenvalueQueryServiceBase<CableForceEigenValueTable>
    {
    }
}