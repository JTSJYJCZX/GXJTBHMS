using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using GxjtBHMS.Web.Controllers;
using GxjtBHMS.Service.Interfaces;
using NSubstitute;

namespace GxjtBHMS.Tests.ControllerTests
{
    [TestClass]
    public class MonitoringDatasControllerDownloadSearchResultTest
    {
        MonitoringDatasController _controller;
        IMonitoringTestTypeService _monitoringTestTypeService;
        IMonitoringPointsNumberService _monitoringPointsNumberService;
        IMonitoringPointsPositionService _monitoringPointsPositionService;

        [TestInitialize]
        public void Setup()
        {
            _monitoringTestTypeService = Substitute.For<IMonitoringTestTypeService>();
            _monitoringPointsNumberService = Substitute.For<IMonitoringPointsNumberService>();
            _monitoringPointsPositionService = Substitute.For<IMonitoringPointsPositionService>();
            _controller = new MonitoringDatasController(_monitoringTestTypeService, _monitoringPointsNumberService, _monitoringPointsPositionService);
        }
        [TestMethod]
        public void OriginCode_ValidedGuidAndTestTypeId_ReturnResponseWithExcelBinaryData()
        {
            Assert.AreEqual(1, 2);
        }
    }
}
