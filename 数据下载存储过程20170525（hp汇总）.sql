
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
---------------ִ�д洢���̲��Դ���--------------------------------------
--declare @TxtPathOutput varchar(max)
--Exec usp_BasicSteelArchStrainSaveAsTxt 1,2,@StartTime='2017-5-1 00:00:00',@EndTime='2017-05-23 22:00:00',@filePath_name='D:\BHMSDB\',@TxtPath=@TxtPathOutput output
--print @TxtPathOutput

--------------------------------------------------------------------------
--select count(*) from Basic_SteelArchStrainTable 
--select top 10 * from Basic_SteelArchStrainTable
--select top 10 * from Basic_SteelArchStrainTable order by Id desc
--delete Basic_SteelArchStrainTable

------------------------BCP���������ʽģ��-------------------------------------------
--exec master..xp_cmdshell 'bcp BHMSDB.dbo.temp out "D:\�������ϵͳ�����ļ�\jtsjyjczx\GxjtBHMS.Web\Content\MontorningDataDownLoad\DownloadData_20170524.txt" -c -q  -t"," -S User-20170213RT\SQLEXPRESS  -U sa -P 123456' 

-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------


----------------------------------��������ΪTXT�洢����----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
----------------------------------�����������ش洢����-----------------------------------------
-----------------------------------------------------------------------------------------------
----------------------------------�ֹ��߻����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicSteelArchStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicSteelArchStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicSteelArchStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0, @MPN9 int=0,@MPN10 int=0,  ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_SteelArchStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------�ָ񹹻����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicSteelLatticeStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicSteelLatticeStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicSteelLatticeStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_SteelLatticeStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select Strain,Temperature,"Time",Name 
	into temp 
	from Basic_SteelLatticeStrainTable as Ba         --- ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------���������������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_Basic_CableForceSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_Basic_CableForceSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_Basic_CableForceSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,
@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0, @MPN17 int=0,@MPN18 int=0,
@MPN19 int=0,@MPN20 int=0,@MPN21 int=0,@MPN22 int=0,@MPN23 int=0,@MPN24 int=0,@MPN25 int=0, @MPN26 int=0,@MPN27 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_CableForce',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------ʪ�Ȼ����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicHumiditySaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicHumiditySaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicHumiditySaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_Humidity',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                             ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select Humidity,"Time",Name 
	into temp 
	from Basic_HumidityTable as Ba         --- ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------λ�ƻ����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicDisplacementSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicDisplacementSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicDisplacementSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0, @MPN11 int=0, @MPN12 int=0, @MPN13 int=0, @MPN14 int=0, @MPN15 int=0,  ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_Displacement',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                             ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
	begin
    select Displacement,"Time",Name 
	into temp 
	from Basic_DisplacementTable as Ba         --- ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO


----------------------------------�¶Ȼ����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicTemperatureSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicTemperatureSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicTemperatureSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_Temperature',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------���ٻ����������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicWindLoadSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicWindLoadSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicWindLoadSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_WindLoad',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
 
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO

----------------------------------������Ӧ������������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_BasicConcreteStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_BasicConcreteStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_BasicConcreteStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0,@MPN17 int=0,@MPN18 int=0,@MPN19 int=0,@MPN20 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Original_ConcreteStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO



------------------------------------------------------------------------------------------------------------------
----------------------------------����ֵ�������ش洢����-----------------------------------------
-----------------------------------------------------------------------------------------------
----------------------------------�ֹ�������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueSteelArchStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueSteelArchStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueSteelArchStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_SteelArchStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------�ָ�����ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueSteelLatticeStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueSteelLatticeStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueSteelLatticeStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_SteelLatticeStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------������Ӧ������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueConcreteStrainSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueConcreteStrainSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueConcreteStrainSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_ConcreteStrain',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------λ������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueDisplacementSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueDisplacementSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueDisplacementSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,    ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_Displacement',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]            ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------��������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueCableForceSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueCableForceSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [dbo].[usp_EigenvalueCableForceSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,@MPN11 int=0,@MPN12 int=0,@MPN13 int=0,@MPN14 int=0,@MPN15 int=0,@MPN16 int=0,@MPN17 int=0,@MPN18 int=0,@MPN19 int=0,@MPN20 int=0,    ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_CableForce',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------�¶�����ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueTemperatureSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueTemperatureSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [usp_EigenvalueTemperatureSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_Temperature',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------ʪ������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueHumiditySaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueHumiditySaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [usp_EigenvalueHumiditySaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,@MPN4 int=0,@MPN5 int=0,@MPN6 int=0,@MPN7 int=0,@MPN8 int=0,@MPN9 int=0,@MPN10 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_Humidity',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
	
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO
---------------------------------------------------------------------
----------------------------------��������ֵ�������ش洢����---------  
---------------------------------------------------------------------
if exists(select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_EigenvalueWindLoadSaveAsTxt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop proc [usp_EigenvalueWindLoadSaveAsTxt]    ---�����Ƿ���ڸô洢���̣�����ɾ����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
GO
CREATE PROCEDURE [usp_EigenvalueWindLoadSaveAsTxt]   ---�����洢����
@MPN1 int=0,@MPN2 int=0,@MPN3 int=0,   ----��ѯ�����������     ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@StartTime datetime,           -----��ѯ��������ʼʱ��
@EndTime datetime,              ----��ѯ����������ʱ�� 
@filePath_name varchar(max),    ---�����ļ���ַ
@txtPath nvarchar(max) output   ---����������洢��ַ
AS
declare                                       ----����bcp�������ز���
@sql_query varchar(200)='BHMSDB.dbo.temp',    ----������ʱ��
@sql_userName varchar(200)='sa',             ----�����¼ID
@password varchar(200)='123456',              ----����sa����
@servername varchar(200)=@@SERVERNAME,        ----��÷��������֡�
@fileNameRandId varchar(12)=convert(varchar(12),1000000*round(RAND(),6)),  ----�����ļ���6λ��Ψһʶ����
@DataType varchar(200)='Eigenvalue_WindLoad',   ----�����ļ������ͣ������ļ�����    ********��Ҫ�޸���Ҫ�޸���Ҫ�޸���Ҫ�޸�********
@Date varchar(12)=convert(varchar(12),GETDATE(),112),   ----������ص���ʱ��
@sql varchar(8000)                            ----����BCP�������
BEGIN
 SET NOCOUNT ON;
 if  exists(select * from  sys.objects where object_id = OBJECT_ID(N'[dbo].[temp]') and type in (N'U'))
	drop table [dbo].[temp]             ----�����Ƿ������ʱ��ɾ����
 if @MPN1>0                     ----����в���Ŵ��룬�򴴽���ʱ��
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
		
set @TxtPath=@filePath_name+@DataType+'_'+@Date+'_'+@fileNameRandId+'.txt' ---ƴ���ļ������ַ
--------�� 'xp_cmdshell'ģ��-----
EXEC sp_configure 'show advanced options', 1;       -----�������ø߼�ѡ��
RECONFIGURE;EXEC sp_configure 'xp_cmdshell', 1;     -----��������
RECONFIGURE                                         -----�� 'xp_cmdshell'ģ��
-----------------------------------
set @sql='bcp '+@sql_query + ' out '+'"'+@TxtPath+'" -c -q  -t","'+' -S '+@servername + '  -U '+@sql_userName +' -P'+@password    ---ƴ��bcp�����ַ���
EXEC master..xp_cmdshell @sql                       -----ִ��BCP
-------�ر� 'xp_cmdshell'ģ��------
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE
-----------------------------------
drop table temp    ---�����ļ���ɾ����ʱ��
END
GO