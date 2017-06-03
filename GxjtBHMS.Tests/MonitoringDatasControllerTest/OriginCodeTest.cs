using Microsoft.VisualStudio.TestTools.UnitTesting;
using GxjtBHMS.Web.Controllers;
using GxjtBHMS.Service.Interfaces;
using NSubstitute;

namespace GxjtBHMS.Tests.ControllerTests.MonitoringDatasControllerTest
{
    [TestClass]
    public class OriginCodeTest
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
            _controller.SetFakeControllerContext();
        }
    }
}
