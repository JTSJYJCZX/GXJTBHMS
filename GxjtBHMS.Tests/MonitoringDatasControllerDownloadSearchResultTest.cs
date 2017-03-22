using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using GxjtBHMS.Web.Controllers;
using GxjtBHMS.Service.Interfaces;
using NSubstitute;
using GxjtBHMS.Web.Models;
using NPOI.HSSF.UserModel;

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
            _controller.SetFakeControllerContext();
        }

        [TestMethod]
        public void OriginCode_ValidedGuidAndTestTypeId_ReponseAddHeaderIsCalled()
        {
            const string fileName = "test";

            _monitoringPointsPositionService.GetMixedNameWithTestTypeNameAndPointPositionNameAndCurrentDateTimeByPositionId(Arg.Any<int>()).Returns(fileName);

            string preFileName = string.Format("attachment; filename={0}.xls", fileName);

            var key = Guid.NewGuid().ToString();

            CacheHelper.SetCache(key, new HSSFWorkbook());

            _controller.OriginCode(key, Arg.Any<int>());

            _controller.Response.Received().AddHeader("Content-Disposition", preFileName);
        }

        [TestMethod]
        public void OriginCode_ValidedGuidAndTestTypeId_ReponseBinaryWriteIsCalled()
        {
            var key = Guid.NewGuid().ToString();

            CacheHelper.SetCache(key, new HSSFWorkbook());

            _controller.OriginCode(key, Arg.Any<int>());

            _controller.Response.Received().BinaryWrite(Arg.Any<byte[]>());
        }

    }
}
