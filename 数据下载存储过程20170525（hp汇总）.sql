
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
---------------执行存储过程测试代码--------------------------------------
--declare @TxtPathOutput varchar(max)
--Exec usp_BasicSteelArchStrainSaveAsTxt 1,2,@StartTime='2017-5-1 00:00:00',@EndTime='2017-05-23 22:00:00',@filePath_name='D:\BHMSDB\',@TxtPath=@TxtPathOutput output
--print @TxtPathOutput

--------------------------------------------------------------------------
--select count(*) from Basic_SteelArchStrainTable 
--select top 10 * from Basic_SteelArchStrainTable
--select top 10 * from Basic_SteelArchStrainTable order by Id desc
--delete Basic_SteelArchStrainTable

------------------------BCP工具命令格式模板-------------------------------------------
--exec master..xp_cmdshell 'bcp BHMSDB.dbo.temp out "D:\健康监测系统开发文件\jtsjyjczx\GxjtBHMS.Web\Content\MontorningDataDownLoad\DownloadData_20170524.txt" -c -q  -t"," -S User-20170213RT\SQLEXPRESS  -U sa -P 123456' 

-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------


----------------------------------数据下载为TXT存储过程----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
----------------------------------基础数据下载存储过程-----------------------------------------
-----------------------------------------------------------------------------------------------
----------------------------------钢拱肋基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicSteelArchStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicSteelArchStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicSteelArchStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0, @MPN9 int=0,@MPN10 int=0,  ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_SteelArchStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Strain,Temperature,"Time",Name 
	into temp 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelArchStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------钢格构基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicSteelLatticeStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicSteelLatticeStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicSteelLatticeStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_SteelLatticeStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Strain,Temperature,"Time",Name 
	into temp 
	from Basic_SteelLatticeStrainTable as Ba         --- ********需要修改需要修改需要修改需要修改********
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
if  @MPN9>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
if  @MPN10>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name 
	from Basic_SteelLatticeStrainTable as BSAST 
	inner join MonitoringPointsNumbers as MPN 
	on BSAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------索力基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_Basic_CableForceSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_Basic_CableForceSaveAsTxt]    ---查找是否存在该存储过程，否则删除。********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_Basic_CableForceSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,
@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0, @MPN17 int=0,@MPN18 int=0,
@MPN19 int=0,@MPN20 int=0,@MPN21 int=0,@MPN22 int=0,@MPN23 int=0,@MPN24 int=0,@MPN25 int=0, @MPN26 int=0,@MPN27 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_CableForce',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select CableForce,Frequency,Temperature,"Time",Name 
	into temp 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
 if  @MPN16>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN16 and "Time" between @StartTime and @EndTime
	end
 if  @MPN17>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN17 and "Time" between @StartTime and @EndTime
	end
 if  @MPN18>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN18 and "Time" between @StartTime and @EndTime
	end
 if  @MPN19>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN19 and "Time" between @StartTime and @EndTime
	end
 if  @MPN20>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN20 and "Time" between @StartTime and @EndTime
	end
 if  @MPN21>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN21 and "Time" between @StartTime and @EndTime
	end
if  @MPN22>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN22 and "Time" between @StartTime and @EndTime
	end
if  @MPN23>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN23 and "Time" between @StartTime and @EndTime
	end
if  @MPN24>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN24 and "Time" between @StartTime and @EndTime
	end
if  @MPN25>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN25 and "Time" between @StartTime and @EndTime
	end
if  @MPN26>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN26 and "Time" between @StartTime and @EndTime
	end
if  @MPN27>0
	begin
	insert into temp 
	select CableForce,Frequency,Temperature,"Time",Name 
	from Basic_CableForceTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN27 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------湿度基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicHumiditySaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicHumiditySaveAsTxt]    ---查找是否存在该存储过程，否则删除。********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicHumiditySaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_Humidity',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                             ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Humidity,"Time",Name 
	into temp 
	from Basic_HumidityTable as Ba         --- ********需要修改需要修改需要修改需要修改********
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
	begin
	insert into temp 
	select Humidity,"Time",Name 
	from Basic_HumidityTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------位移基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicDisplacementSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicDisplacementSaveAsTxt]    ---查找是否存在该存储过程，否则删除。********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicDisplacementSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0, @MPN11 int=0, @MPN12 int=0, @MPN13 int=0, @MPN14 int=0, @MPN15 int=0,  ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_Displacement',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                             ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Displacement,"Time",Name 
	into temp 
	from Basic_DisplacementTable as Ba         --- ********需要修改需要修改需要修改需要修改********
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id  
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
	begin
	insert into temp 
	select Displacement,"Time",Name 
	from Basic_DisplacementTable as Ba 
	inner join MonitoringPointsNumbers as MPN 
	on Ba.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO


----------------------------------温度基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicTemperatureSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicTemperatureSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicTemperatureSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_Temperature',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Temperature,"Time",Name 
	into temp 
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
if @MPN9>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
if  @MPN10>0
	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Temperature,"Time",Name  
	from Basic_TemperatureTable as BTT 
	inner join MonitoringPointsNumbers as MPN 
	on BTT.PointsNumberId=MPN.Id
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------风速基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicWindLoadSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicWindLoadSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicWindLoadSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_WindLoad',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select WindSpeed,"Time",Name 
	into temp 
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id  
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select WindSpeed,"Time",Name  
	from Basic_WindLoadTable as BWT 
	inner join MonitoringPointsNumbers as MPN 
	on BWT.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO

----------------------------------混凝土应变基础数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicConcreteStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicConcreteStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_BasicConcreteStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0,@MPN17 int=0,@MPN18 int=0,@MPN19 int=0,@MPN20 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Original_ConcreteStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Strain,Temperature,"Time",Name  
	into temp 
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
if @MPN9>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
if  @MPN10>0
	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN12 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end
if  @MPN16>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN16 and "Time" between @StartTime and @EndTime
	end
 if  @MPN17>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN17 and "Time" between @StartTime and @EndTime
	end
 if  @MPN18>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN18 and "Time" between @StartTime and @EndTime
	end
 if  @MPN19>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN19 and "Time" between @StartTime and @EndTime
	end
 if  @MPN20>0
 	begin
	insert into temp 
	select Strain,Temperature,"Time",Name  
	from Basic_ConcreteStrainTable as BCST 
	inner join MonitoringPointsNumbers as MPN 
	on BCST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN20 and "Time" between @StartTime and @EndTime
	end
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO



------------------------------------------------------------------------------------------------------------------
----------------------------------特征值数据下载存储过程-----------------------------------------
-----------------------------------------------------------------------------------------------
----------------------------------钢拱肋特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueSteelArchStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueSteelArchStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueSteelArchStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_SteelArchStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelArchStrainEigenvalueTable as ESAST 
	inner join MonitoringPointsNumbers as MPN 
	on ESAST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------钢格构特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueSteelLatticeStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueSteelLatticeStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueSteelLatticeStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_SteelLatticeStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_SteelLatticeStrainEigenvalueTable as ESSST 
	inner join MonitoringPointsNumbers as MPN 
	on ESSST.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------混凝土应变特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueConcreteStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueConcreteStrainSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueConcreteStrainSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_ConcreteStrain',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_ConcreteStrainEigenvalueTable as ECSET 
	inner join MonitoringPointsNumbers as MPN 
	on ECSET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------位移特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueDisplacementSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueDisplacementSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueDisplacementSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,    ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_Displacement',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id  
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_DisplacementEigenvalueTable as EDET 
	inner join MonitoringPointsNumbers as MPN 
	on EDET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------索力特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueCableForceSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueCableForceSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueCableForceSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0,@MPN17 int=0,@MPN18 int=0,@MPN19 int=0,@MPN20 int=0,    ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_CableForce',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN11>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN11 and "Time" between @StartTime and @EndTime
	end
 if  @MPN12>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
 if  @MPN13>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN13 and "Time" between @StartTime and @EndTime
	end
 if  @MPN14>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN14 and "Time" between @StartTime and @EndTime
	end
 if  @MPN15>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN15 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN16>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN16 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN17>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN17 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN18>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN18 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN19>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN19 and "Time" between @StartTime and @EndTime
	end	
 if  @MPN20>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_CableForceEigenvalueTable as ECFET 
	inner join MonitoringPointsNumbers as MPN 
	on ECFET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN20 and "Time" between @StartTime and @EndTime
	end	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------温度特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueTemperatureSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueTemperatureSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [usp_EigenvalueTemperatureSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_Temperature',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_TemperatureEigenvalueTable as ETET 
	inner join MonitoringPointsNumbers as MPN 
	on ETET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------湿度特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueHumiditySaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueHumiditySaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [usp_EigenvalueHumiditySaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_Humidity',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
 if  @MPN4>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN4 and "Time" between @StartTime and @EndTime
	end
 if  @MPN5>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN5 and "Time" between @StartTime and @EndTime
	end
 if  @MPN6>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN6 and "Time" between @StartTime and @EndTime
	end
 if  @MPN7>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN7 and "Time" between @StartTime and @EndTime
	end
 if  @MPN8>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN8 and "Time" between @StartTime and @EndTime
	end
 if  @MPN9>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN9 and "Time" between @StartTime and @EndTime
	end
 if  @MPN10>0
 	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_HumidityEigenvalueTable as EHET 
	inner join MonitoringPointsNumbers as MPN 
	on EHET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN10 and "Time" between @StartTime and @EndTime
	end
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO
---------------------------------------------------------------------
----------------------------------风速特征值数据下载存储过程---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueWindLoadSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueWindLoadSaveAsTxt]    ---查找是否存在该存储过程，否则删除。    ********需要修改需要修改需要修改需要修改********
GO
CREATE PROCEDURE [usp_EigenvalueWindLoadSaveAsTxt]   ---创建存储过程
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,   ----查询条件，测点编号     ********需要修改需要修改需要修改需要修改********
@StartTime datetime,           -----查询条件，开始时间
@EndTime datetime,              ----查询条件，结束时间 
@filePath_name varchar(max),    ---输入文件地址
@txtPath nvarchar(max) output   ---输出参数，存储地址
AS
declare                                       ----定义bcp命令的相关参数
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----定义临时表
@sql_userName varchar(200)='sa',             ----定义登录ID
@password varchar(200)='123456',              ----定义sa密码
@servername varchar(200)=@@SERVERNAME,        ----获得服务器名字。
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----生成文件名6位的唯一识别码
@DataType varchar(200)='Eigenvalue_WindLoad',   ----下载文件的类型，用于文件命名    ********需要修改需要修改需要修改需要修改********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----获得下载当天时间
@sql varchar(8000)                            ----定义BCP命令变量
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----查找是否存在临时表，删除表
 if @MPN1>0                     ----如果有测点编号传入，则创建临时表。
	begin
    select Name,"Max","Min",Average,"Time"
	into temp 
	from Eigenvalue_WindLoadEigenvalueTable as EWLET 
	inner join MonitoringPointsNumbers as MPN 
	on EWLET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN1 and "Time" between @StartTime and @EndTime
	end
if @MPN2>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_WindLoadEigenvalueTable as EWLET 
	inner join MonitoringPointsNumbers as MPN 
	on EWLET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN2 and "Time" between @StartTime and @EndTime
	end
if  @MPN3>0
	begin
	insert into temp 
	select Name,"Max","Min",Average,"Time"
	from Eigenvalue_WindLoadEigenvalueTable as EWLET 
	inner join MonitoringPointsNumbers as MPN 
	on EWLET.PointsNumberId=MPN.Id 
	where PointsNumberId=@MPN3 and "Time" between @StartTime and @EndTime
	end
		
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---拼接文件输出地址
--------打开 'xp_cmdshell'模块-----
EXEC sp_configure 'show advanced options', 1;       -----允许配置高级选项
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----重新配置
RECONFIGURE                                         -----打开 'xp_cmdshell'模块
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---拼接bcp命令字符串
EXEC master..xp_cmdshell @sql                       -----执行BCP
-------关闭 'xp_cmdshell'模块------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---生成文件后删除临时表
END
GO