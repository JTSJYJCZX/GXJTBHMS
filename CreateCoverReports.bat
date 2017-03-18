@ECHO OFF
@set DevEnvDir=E:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE;
@set PATH=%DevEnvDir%;%PATH%

.\packages\OpenCover.4.6.519\tools\OpenCover.Console.exe -register:"user" -filter:"+[*]* -[GxjtBHMS.Web]*Config -[GxjtBHMS.Web]*MvcApplication -[*DependencyInjection]* -[*IDAL]* -[*Tests*]*" -target:"MsTest.exe" -targetargs:"/testcontainer:.\GxjtBHMS.Tests\bin\Debug\GxjtBHMS.Tests.Controllers.dll /testcontainer:.\GxjtBHMS.Tests.UnitTests\bin\Debug\GxjtBHMS.Tests.UnitTests.dll /testcontainer:.\GxjtBHMS.Tests.IntegrationTests\bin\Debug\GxjtBHMS.Tests.IntegrationTests.dll /nologo"

.\packages\ReportGenerator.2.4.5.0\tools\ReportGenerator.exe -reports:"results.xml" -targetdir:"GxjtBHMSReports" 
pause



