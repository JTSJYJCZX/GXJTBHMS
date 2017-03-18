@ECHO OFF
PATH C:\WINDOWS;C:\WINDOWS\COMMAND;C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE
.\packages\OpenCover.4.6.519\tools\OpenCover.Console.exe "-register:user" "-filter:-[*Test]*" "-target:MsTest.exe" "-targetargs:/testcontainer:.\GxjtBHMS.Tests.UnitTests\bin\Debug\GxjtBHMS.Tests.UnitTests.dll" 
.\packages\ReportGenerator.2.4.5.0\tools\ReportGenerator.exe "-reports:results.xml" "-targetdir:.\coverage"

pause