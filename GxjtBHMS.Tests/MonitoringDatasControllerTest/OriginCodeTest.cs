using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using GxjtBHMS.Web.Controllers;
using GxjtBHMS.Service.Interfaces;
using NSubstitute;
using GxjtBHMS.Web.Models;
using NPOI.HSSF.UserModel;
using System.IO;

namespace GxjtBHMS.Tests.ControllerTests.MonitoringDatasControllerTest
{
    [TestClass]
    public class OriginCodeTest
    {
        MonitoringDatasController _controller;
        IMonitoringTestTypeService _monitoringTestTypeService;
        IMonitoringPointsNumberService _monitoringPointsNumberService;
        IMonitoringPointsPositionService _monitoringPointsPositionService;
        IFileConverter _fileConverter;
        string key = string.Empty;
        [TestInitialize]
        public void Setup()
        {
            _monitoringTestTypeService = Substitute.For<IMonitoringTestTypeService>();
            _monitoringPointsNumberService = Substitute.For<IMonitoringPointsNumberService>();
            _monitoringPointsPositionService = Substitute.For<IMonitoringPointsPositionService>();
            _fileConverter = Substitute.For<IFileConverter>();
            _controller = new MonitoringDatasController(_monitoringTestTypeService, _monitoringPointsNumberService, _monitoringPointsPositionService, _fileConverter);
            _controller.SetFakeControllerContext();
            key = Guid.NewGuid().ToString();
        }

        [TestMethod]
        public void OriginCode_ValidedGuidAndTestTypeId_ReponseAddHeaderIsCalled()
        {
            const string fileName = "test";

            _monitoringPointsPositionService.CreateDownloadFileMixedName(Arg.Any<int>()).Returns(fileName);

            string preFileName = string.Format("attachment; filename={0}.xls", fileName);

            CacheHelper.SetCache(key, new HSSFWorkbook());

            _fileConverter.GetStream(CacheHelper.GetCache(key)).Returns(new MemoryStream());

            _controller.OriginCode(key, Arg.Any<int>(),Arg.Any<string>());

            _controller.Response.Received().AddHeader("Content-Disposition", preFileName);
        }

        [TestMethod]
        public void OriginCode_ValidedGuidAndTestTypeId_ReponseBinaryWriteIsCalled()
        {
            CacheHelper.SetCache(key, new HSSFWorkbook());

            _fileConverter.GetStream(CacheHelper.GetCache(key)).Returns(new MemoryStream());

            _controller.OriginCode(key, Arg.Any<int>(), Arg.Any<string>());

            _controller.Response.Received().BinaryWrite(Arg.Any<byte[]>());
        }

        [TestMethod]
        [ExpectedException(typeof(ApplicationException))]
        public void OriginCode_InvalidGuid_ThrowException()
        {
            _controller.OriginCode(key, Arg.Any<int>(), Arg.Any<string>());
        }

    }
}
